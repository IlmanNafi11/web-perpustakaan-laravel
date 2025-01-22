<?php

namespace App\Filament\Resources;

use Filament\Actions;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\BorrowRecord;
use Filament\Resources\Resource;
use Filament\Tables\Actions\Action;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\ActionGroup;
use Filament\Tables\Actions\DeleteAction;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\BorrowRecordResource\Pages;
use App\Filament\Resources\BorrowRecordResource\RelationManagers;
use App\Models\Book;
use App\Models\BorrowRequestBooks;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Actions\ViewAction;
use Filament\Infolists;
use Filament\Infolists\Components\Group;
use Filament\Infolists\Components\ImageEntry;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Infolist;
use Filament\Tables\Actions\BulkActionGroup;
use Filament\Tables\Actions\DeleteBulkAction;
use Filament\Infolists\Components\Tabs;
use Filament\Infolists\Components\TextEntry;

class BorrowRecordResource extends Resource
{
    protected static ?string $model = BorrowRecord::class;

    protected static ?string $navigationIcon = 'vaadin-records';
    protected static ?string $navigationGroup = 'Transaction';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('borrowRequest.member.user.name')
                    ->label('Member Name')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('borrowRequest.member.user.email')
                    ->label('Member Email')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('title')
                    ->label('Book Title')
                    ->searchable()
                    ->sortable()
                    ->state(function($record) {
                        $borrowId = $record->borrow_request_id;
                        return BorrowRequestBooks::where('borrow_request_id', $borrowId)->pluck('book_id')->flatMap(function($book) {
                            return Book::where('id', $book)->pluck('title')->toArray();
                        });
                    }),
                TextColumn::make('borrow_at')
                    ->label('Borrow at')
                    ->sortable(),
                TextColumn::make('return_at')
                    ->label('Return at')
                    ->sortable()
                    ->state(fn($record) => $record->return_at ??= 'Waiting for return'),
                TextColumn::make('due_date')
                    ->label('Due Date')
                    ->sortable(),
                TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'borrowed' => 'warning',
                        'returned' => 'success',
                        'overdue' => 'danger',
                    })
                    ->icon(fn(string $state): string => match ($state) {
                        'borrowed' => 'heroicon-o-clock',
                        'returned' => 'heroicon-o-check-circle',
                        'overdue' => 'heroicon-o-x-circle',
                    }),
            ])
            ->filters([
                //
            ])
            ->actions([
                ActionGroup::make([
                    Action::make('return_at')
                        ->label('Return Book')
                        ->color('success')
                        ->visible(function ($record) {
                            if ($record->status === 'borrowed' || $record->status === 'overdue') {
                                return true;
                            }
                        })
                        ->icon('heroicon-o-check-circle')
                        ->requiresConfirmation()
                        ->modalHeading('Confirmation')
                        ->modalDescription('Confirmation of book return? Please double check before agreeing')
                        ->action(function ($record) {
                            $record->update([
                                'return_at' => now(),
                                'status' => 'returned'
                            ]);
                        }),
                    DeleteAction::make(),
                    ViewAction::make()
                ])
                    ->label('More Action')
                    ->button(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
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
            'index' => Pages\ListBorrowRecords::route('/'),
        ];
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Tabs::make()
                    ->columnSpanFull()
                    ->tabs([
                        Tabs\Tab::make('Member Detail')
                            ->schema([
                                Group::make([
                                    Infolists\Components\ImageEntry::make('borrowRequest.member.user.photo_path')
                                        ->label('Member Profile')
                                        ->height(250)
                                        ->width(200)
                                        ->extraAttributes([
                                            'object-fit' => 'cover',
                                            'loading' => 'lazy',
                                        ]),
                                ]),
                                Group::make([
                                    Infolists\Components\TextEntry::make('borrowRequest.member.user.name')
                                        ->label('Member Name'),
                                    Infolists\Components\TextEntry::make('borrowRequest.member.user.phone')
                                        ->label('Member Phone'),
                                    Infolists\Components\TextEntry::make('borrowRequest.member.user.email')
                                        ->label('Member Email'),
                                    Infolists\Components\TextEntry::make('borrowRequest.member.user.address')
                                        ->label('Member Address'),
                                ]),
                            ])
                            ->columns(2),
                        Tabs\Tab::make('Book Detail')
                            ->schema(function ($record) {
                                $borrowId = $record->borrow_request_id;

                                $books = BorrowRequestBooks::where('borrow_request_id', $borrowId)->select('book_id', 'quantity')->get()->flatMap(function ($book) {
                                    $data = Book::where('id', $book->book_id)->select('title', 'author', 'publisher', 'cover')->get()->map(function ($item) use ($book) {
                                        $item->quantity = $book->quantity;
                                        return $item;
                                    });
                                    return $data;
                                });

                                return $books->map(function ($item) {
                                    return Section::make($item->title)
                                        ->schema([
                                            Group::make([
                                                ImageEntry::make('cover')
                                                    ->label('Cover')
                                                    ->state($item->cover),
                                            ]),
                                            Group::make([
                                                TextEntry::make('title')
                                                    ->label('Title')
                                                    ->state($item->title),
                                                TextEntry::make('author')
                                                    ->label('Author')
                                                    ->state($item->author),
                                                TextEntry::make('publisher')
                                                    ->label('Publisher')
                                                    ->state($item->publisher),
                                                TextEntry::make('quantity')
                                                    ->label('Borrow amount')
                                                    ->state($item->quantity),
                                                TextEntry::make('borrow_at')
                                                    ->label('Borrow at'),
                                                TextEntry::make('return_at')
                                                    ->label('Return at'),
                                                TextEntry::make('due_date')
                                                    ->label('Due date'),
                                                TextEntry::make('status')
                                                    ->label('Status')
                                                    ->badge()
                                                    ->color(fn($record) => match ($record->status) {
                                                        'borrowed' => 'warning',
                                                        'overdue' => 'danger',
                                                        'returned' => 'success',
                                                    }),
                                            ])
                                                ->columns(2)

                                        ])
                                        ->columns(2);
                                })->toArray();
                            })
                            ->columns(2),
                    ])
            ]);
    }
}
