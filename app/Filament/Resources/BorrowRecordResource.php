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
use Filament\Forms\Components\TextInput;
use Filament\Tables\Actions\ViewAction;
use Filament\Infolists;
use Filament\Infolists\Components\Group;
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
                TextColumn::make('borrowRequest.book.title')
                    ->label('Book Title')
                    ->searchable()
                    ->sortable(),
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
                        ->visible(fn($record) => $record->return_at === null ? true : false)
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
                                            'loading'=> 'lazy',
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
                            ->schema([
                                Group::make([
                                    Infolists\Components\ImageEntry::make('borrowRequest.book.cover')
                                        ->label('Book Cover')
                                        ->height(250)
                                        ->extraImgAttributes([
                                            'object-fit' => 'cover',
                                            'loading'=> 'lazy',
                                        ]),
                                ]),
                                Group::make([
                                    Infolists\Components\TextEntry::make('borrowRequest.book.title')
                                        ->label('Borrowed books'),
                                    Infolists\Components\TextEntry::make('borrowRequest.quantity')
                                        ->label('Total borrowed'),
                                    Infolists\Components\TextEntry::make('borrow_at')
                                        ->label('Borrow at'),
                                    Infolists\Components\TextEntry::make('return_at')
                                        ->label('Return at')
                                        ->state(fn($record) => $record->return_at ??= 'Waiting for return')
                                        ->badge()
                                        ->color(fn($record) => $record->return_at === 'Waiting for return' ? 'warning' : 'gray')
                                        ->icon(fn($state) => $state === 'Waiting for return' ? 'heroicon-o-clock' : 'heroicon-o-check-circle'),
                                    Infolists\Components\TextEntry::make('due_date')
                                        ->label('Due date'),
                                ]),
                            ])
                            ->columns(2),
                    ])
            ]);
    }
}
