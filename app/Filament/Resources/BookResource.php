<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BookResource\Pages;
use App\Filament\Resources\BookResource\RelationManagers;
use App\Http\Controllers\CategoryController;
use App\Models\Book;
use App\Models\category;
use Filament\Forms;
use Filament\Forms\Components\Fieldset;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\Relationship;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class BookResource extends Resource
{
    protected static ?string $model = Book::class;
    protected static ?string $label = 'Books and E-books';
    protected static ?string $navigationLabel = 'Books and E-books';
    protected static ?string $navigationIcon = 'heroicon-s-book-open';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title')
                    ->required()
                    ->maxLength(255)
                    ->label('Title'),
                Forms\Components\TextInput::make('author')
                    ->required()
                    ->maxLength(255)
                    ->label('Author'),
                Forms\Components\TextInput::make('isbn')
                    ->required()
                    ->numeric()
                    ->label('ISBN')
                    ->maxLength(255),
                Forms\Components\FileUpload::make('cover')
                    ->required()
                    ->image()
                    ->directory('book-cover')
                    ->maxSize(2048)
                    ->maxFiles(1)
                    ->acceptedFileTypes(['image/jpeg', 'image/jpg', 'image/png'])
                    ->label('Book Cover'),
                Forms\Components\Textarea::make('description')
                    ->required()
                    ->columnSpanFull()
                    ->label('Description'),
                Fieldset::make('Stock')
                    ->schema([
                        Forms\Components\TextInput::make('quantity')
                            ->required()
                            ->numeric()
                            ->default(0)
                            ->label('Quantity')
                            ->gt('available')
                            ->validationMessages([
                                'gt' => 'Quantity must be greater than available',
                            ]),
                        Forms\Components\TextInput::make('available')
                            ->required()
                            ->numeric()
                            ->default(0)
                            ->label('Available'),
                    ]),
                Forms\Components\Select::make('year')
                    ->required()
                    ->options(
                        collect(range(date('Y'), 1900))->mapWithKeys(fn($year) => [$year => $year])->toArray()
                    )
                    ->searchable()
                    ->label('Publication Year'),
                Forms\Components\TextInput::make('publisher')
                    ->required()
                    ->maxLength(255)
                    ->alpha()
                    ->label('Publisher'),
                Forms\Components\Select::make('language')
                    ->options([
                        'english' => 'English',
                        'indonesian' => 'Indonesian',
                        'japan' => 'Japan',
                        'korea' => 'Korea',
                    ])
                    ->searchable()
                    ->required()
                    ->label('Language'),
                Forms\Components\Select::make('category_id')
                    ->required()
                    ->searchable()
                    ->relationship('category', 'category_name')
                    ->createOptionForm([
                        Forms\Components\TextInput::make('category_name')
                            ->required()
                            ->maxLength(255),
                    ])
                    ->options(category::all()->pluck('category_name', 'id'))
                    ->label('Category'),
                Forms\Components\Radio::make('type')
                    ->required()
                    ->options([
                        'e-book' => 'E Book',
                        'phisical book' => 'Phisical Book',
                    ])
                    ->label('Type'),
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
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
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
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
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
}
