<?php

namespace App\Filament\Resources;

use Filament\Forms;
use App\Models\Book;
use Filament\Tables;
use App\Rules\BookRule;
use Filament\Infolists;
use App\Models\category;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Resources\Pages\Page;
use Filament\Forms\Components\Fieldset;
use Illuminate\Database\Eloquent\Model;
use Filament\Notifications\Notification;
use Filament\Tables\Actions\ActionGroup;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\BookResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Illuminate\Database\Eloquent\Factories\Relationship;
use App\Filament\Resources\BookResource\RelationManagers;


class BookResource extends Resource
{
    protected static ?string $model = Book::class;
    protected static ?string $label = 'Books and E-Books';
    protected static ?string $navigationLabel = 'Books and E-Books';
    protected static ?string $navigationIcon = 'heroicon-s-book-open';

    protected static ?string $navigationGroup = 'Library Collection';
    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Infolists\Components\Group::make([
                    Infolists\Components\ImageEntry::make('cover')
                        ->label('Book Cover')
                        ->extraAttributes([
                            'alt' => 'book-cover',
                            'loading' => 'lazy',
                        ])
                        ->height(300),
                ]),
                Infolists\Components\Group::make([
                    Infolists\Components\TextEntry::make('title'),
                    Infolists\Components\TextEntry::make('author'),
                    Infolists\Components\TextEntry::make('isbn'),
                    Infolists\Components\TextEntry::make('quantity'),
                    Infolists\Components\TextEntry::make('available'),
                    Infolists\Components\TextEntry::make('year'),
                    Infolists\Components\TextEntry::make('category.category_name'),
                    Infolists\Components\TextEntry::make('type'),
                    Infolists\Components\TextEntry::make('language'),
                    Infolists\Components\TextEntry::make('publisher'),
                    Infolists\Components\TextEntry::make('description')
                        ->columnSpanFull(),
                ])
                    ->columns(2),
            ]);
    }
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title')
                    ->maxLength(255)
                    ->label('Title')
                    ->rule([
                        new BookRule,
                        'required',
                    ])
                    ->validationMessages([
                        'required' => 'Title is required',
                        'max' => 'Title is too long',
                    ])
                    ->placeholder('Enter book title'),
                Forms\Components\TextInput::make('author')
                    ->maxLength(255)
                    ->label('Author')
                    ->rule([
                        new BookRule,
                        'required',
                    ])
                    ->validationMessages([
                        'required' => 'Author is required',
                        'max' => 'Author is too long',
                    ])
                    ->placeholder('Enter book author'),
                Forms\Components\TextInput::make('isbn')
                    ->numeric()
                    ->label('ISBN')
                    ->rule([
                        'required',
                        'regex:/^\d{13}$/',
                    ])
                    ->validationMessages([
                        'required' => 'ISBN is required',
                        'regex' => 'The input must be exactly 13 digits.',
                    ])
                    ->placeholder('Enter book ISBN'),
                Forms\Components\Select::make('language')
                    ->options([
                        'english' => 'English',
                        'indonesian' => 'Indonesian',
                        'japan' => 'Japan',
                        'korea' => 'Korea',
                    ])
                    ->searchable()
                    ->rule([
                        'required',
                    ])
                    ->label('Language')
                    ->placeholder('Select book language'),
                Forms\Components\Textarea::make('description')
                    ->columnSpanFull()
                    ->label('Description')
                    ->rule([
                        'required',
                    ])
                    ->validationMessages([
                        'required' => 'Description is required',
                    ])
                    ->placeholder('Enter book description'),
                Fieldset::make('Stock')
                    ->schema([
                        Forms\Components\TextInput::make('quantity')
                            ->numeric()
                            ->default(0)
                            ->label('Quantity')
                            ->gte('available')
                            ->rule([
                                'required',
                            ])
                            ->validationMessages([
                                'required' => 'Quantity is required',
                                'gte' => 'Quantity must be greater than available',
                            ])
                            ->placeholder('Enter book quantity'),
                        Forms\Components\TextInput::make('available')
                            ->numeric()
                            ->default(0)
                            ->label('Available')
                            ->lte('quantity')
                            ->rule([
                                'required',
                            ])
                            ->validationMessages([
                                'required' => 'Available is required',
                                'lte' => 'Available must be less than quantity',
                            ])
                            ->placeholder('Enter book available'),
                    ]),
                Forms\Components\Select::make('year')
                    ->options(
                        collect(range(date('Y'), 1900))->mapWithKeys(fn($year) => [$year => $year])->toArray()
                    )
                    ->rule([
                        'required',
                    ])
                    ->searchable()
                    ->label('Publication Year')
                    ->placeholder('Select publication year'),
                Forms\Components\TextInput::make('publisher')
                    ->maxLength(255)
                    ->label('Publisher')
                    ->rule([
                        'required',
                        new BookRule
                    ])
                    ->validationMessages([
                        'required' => 'Publisher is required',
                    ])
                    ->placeholder('Enter book publisher'),
                Forms\Components\Select::make('category_id')
                    ->searchable()
                    ->relationship('category', 'category_name')
                    ->createOptionForm([
                        Forms\Components\TextInput::make('category_name')
                            ->required()
                            ->maxLength(255),
                    ])
                    ->rule([
                        'required',
                    ])
                    ->options(category::all()->pluck('category_name', 'id'))
                    ->label('Category')
                    ->placeholder('Select book category'),
                Forms\Components\Radio::make('type')
                    ->options([
                        'e-book' => 'E Book',
                        'phisical book' => 'Phisical Book',
                    ])
                    ->rule([
                        'required',
                    ])
                    ->label('Type')
                    ->helperText('Select book type.'),
                Forms\Components\FileUpload::make('cover')
                    ->image()
                    ->directory('book-cover')
                    ->maxSize(2048)
                    ->maxFiles(1)
                    ->label('Book Cover')
                    ->acceptedFileTypes(['image/jpeg', 'image/jpg', 'image/png'])
                    ->rule([
                        'required',
                    ])
                    ->validationMessages([
                        'required' => 'Book cover is required',
                        'max' => 'Book cover is too large',
                    ])
                    ->helperText('Upload a book cover image in png, jpg or jpeg format.'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('cover'),
                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->label('Title'),
                Tables\Columns\TextColumn::make('author')
                    ->searchable()
                    ->label('Author'),
                Tables\Columns\TextColumn::make('isbn')
                    ->searchable()
                    ->label('ISBN'),
                Tables\Columns\TextColumn::make('quantity')
                    ->numeric()
                    ->sortable()
                    ->searchable()
                    ->label('Quantity'),
                Tables\Columns\TextColumn::make('available')
                    ->numeric()
                    ->sortable()
                    ->label('Available'),
                Tables\Columns\TextColumn::make('year')
                    ->label('Publication Year')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('category.category_name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('type')
                    ->searchable(),
            ])
            ->filters(filters: [
                SelectFilter::make('author')
                    ->searchable()
                    ->label('Author')
                    ->options(Book::select('author')->distinct()->pluck('author', 'author')),
                SelectFilter::make('type')
                    ->searchable()
                    ->label('Type')
                    ->options([
                        'e-book' => 'E Book',
                        'phisical book' => 'Phisical Book',
                    ]),
                SelectFilter::make('category_id')
                    ->options(category::all()->pluck('category_name', 'id'))
                    ->label('Category'),

            ])
            ->deferLoading()
            ->actions([
                ActionGroup::make([
                    Tables\Actions\EditAction::make()
                    ->color('primary'),
                    Tables\Actions\DeleteAction::make()
                        ->successNotification(
                            Notification::make()
                                ->success()
                                ->title('Book deleted')
                                ->body('The book has been deleted successfully.'),
                        )
                        ->modalHeading('Delete Book')
                        ->modalDescription('Are you sure you want to delete this book?'),
                    Tables\Actions\ViewAction::make(),
                ])
                    ->label('More Actions')
                    ->color('primary')
                    ->button(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make()
                        ->modalHeading('Delete Book')
                        ->modalDescription('Are you sure you want to delete this book?'),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListBooks::route('/'),
            'create' => Pages\CreateBook::route('/create'),
            'edit' => Pages\EditBook::route('/{record}/edit'),
        ];
    }

    public static function getRecordSubNavigation(Page $page): array
    {
        return $page->generateNavigationItems([
            // ...
        ]);
    }
}
