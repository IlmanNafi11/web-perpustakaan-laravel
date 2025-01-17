<?php

namespace App\Filament\Resources;

use App\Filament\Resources\BorrowRequestResource\Pages;
use App\Filament\Resources\BorrowRequestResource\RelationManagers;
use App\Models\BorrowRecord;
use App\Models\BorrowRequest;
use Carbon\Carbon;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\ImageEntry;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\DatePicker;
use Filament\Tables\Filters\Filter;
use Filament\Tables\Actions\Action;
use Filament\Tables\Actions\ActionGroup as ActionsActionGroup;
use Filament\Notifications\Notification;
use Filament\Tables\Actions\DeleteAction;
use Filament\Infolists;
use Filament\Infolists\Components\Group;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Illuminate\Support\Facades\Blade;

class BorrowRequestResource extends Resource
{
    protected static ?string $model = BorrowRequest::class;

    protected static ?string $navigationIcon = 'eos-assignment-returned-o';
    protected static ?string $navigationGroup = 'Transcation';

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
                TextColumn::make('member.user.name')
                    ->searchable()
                    ->sortable()
                    ->label('Member'),
                TextColumn::make('book.title')
                    ->searchable()
                    ->sortable()
                    ->label('Book'),
                TextColumn::make('status')
                    ->badge()
                    ->sortable()
                    ->label('Status')
                    ->color(fn(string $state): string => match ($state) {
                        'pending' => 'warning',
                        'approved' => 'success',
                        'rejected' => 'danger',
                    })
                    ->icon(fn(string $state): string => match ($state) {
                        'pending' => 'heroicon-o-clock',
                        'approved' => 'heroicon-o-check-circle',
                        'rejected' => 'heroicon-o-x-circle',
                    }),
                TextColumn::make('quantity')
                    ->sortable()
                    ->label('Quantity'),
                TextColumn::make('request_at')
                    ->sortable()
                    ->label('Request At'),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->options([
                        'pending' => 'Pending',
                        'approved' => 'Approved',
                        'rejected' => 'Rejected',
                    ])
                    ->label('Status'),
                Filter::make('created_at')
                    ->form([
                        DatePicker::make('request_from'),
                        DatePicker::make('request_until'),
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        return $query
                            ->when(
                                $data['request_from'],
                                fn(Builder $query, $date): Builder => $query->whereDate('request_at', '>=', $date),
                            )
                            ->when(
                                $data['request_until'],
                                fn(Builder $query, $date): Builder => $query->whereDate('request_at', '<=', $date),
                            );
                    })
            ])
            ->actions([
                ActionsActionGroup::make([
                    Action::make('Approve')
                        ->color('success')
                        ->visible(fn($record) => $record->status !== 'approved')
                        ->icon('heroicon-o-check-circle')
                        ->label('Approve')
                        ->action(function ($record) {
                            $record->update(['status' => 'approved']);
                            Notification::make()
                                ->title('Status updated')
                                ->success()
                                ->body('The request has been successfully approved.')
                                ->send();
                        })
                        ->requiresConfirmation()
                        ->modalHeading('Approve the request')
                        ->modalDescription('Are you sure you want to approve this request?'),
                    Action::make('Reject')
                        ->color('gray')
                        ->visible(fn($record) => $record->status !== 'approved')
                        ->icon('heroicon-o-x-circle')
                        ->action(function ($record) {
                            $record->update(['status' => 'rejected']);
                            Notification::make()
                                ->title('Status updated')
                                ->success()
                                ->body('Request denied.')
                                ->send();
                        })
                        ->requiresConfirmation()
                        ->modalHeading('Deny the request')
                        ->modalDescription('Are you sure you want to reject this request?'),
                    DeleteAction::make(),
                    Tables\Actions\ViewAction::make(),
                    Action::make('TakenStatus')
                    ->form([
                        DatePicker::make('borrow_at')
                            ->label('Borrow at')
                            ->afterOrEqual('now')
                            ->rules([
                                'required'
                            ]),
                        DatePicker::make('return_at')
                            ->label('Return at')
                            ->afterOrEqual('borrow_at')
                            ->rules([
                                'required'
                            ]),
                    ])
                    ->action(function (array $data, BorrowRequest $record) {
                        $borrowRequest = $record;

                        $borrowRequest->is_taken = true;
                        $borrowRequest->save();

                        $borrowRecord = new BorrowRecord();
                        $borrowRecord->borrow_request_id = $borrowRequest->id;
                        $borrowRecord->borrow_at = $data['borrow_at'];
                        $return_at = $data['return_at'];
                        $borrowRecord->return_at = $return_at;
                        $borrowRecord->due_date = Carbon::parse($return_at)->addDays(3);
                        $borrowRecord->save();

                        Notification::make()
                                ->title('Success')
                                ->success()
                                ->body('Book pickup status updated.')
                                ->send();
                    })
                    ->label('Update pickup status')
                    ->icon('elemplus-takeaway-box')
                    ->visible(fn($record) => $record->status === 'approved')
                ])
                    ->button()
                    ->label('More Actions')
                    ->color('primary'),
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
            'index' => Pages\ListBorrowRequests::route('/'),
        ];
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Group::make([
                    ImageEntry::make('member.user.photo_path')
                        ->label('Member Photo')
                        ->size(250),
                ]),
                Group::make([
                    TextEntry::make('member.user.name')
                        ->label('Member Name'),
                    TextEntry::make('book.title')
                        ->label('Book Title'),
                    TextEntry::make('member.user.email')
                        ->label('Member Email'),
                    TextEntry::make('member.user.phone')
                        ->label('Member Phone'),
                    TextEntry::make('status')
                        ->label('Request status')
                        ->color(fn(string $state): string => match ($state) {
                            'pending' => 'warning',
                            'approved' => 'success',
                            'rejected' => 'danger',
                        })
                        ->icon(fn(string $state): string => match ($state) {
                            'pending' => 'heroicon-o-clock',
                            'approved' => 'heroicon-o-check-circle',
                            'rejected' => 'heroicon-o-x-circle',
                        })
                        ->badge(),
                    TextEntry::make('is_taken')
                        ->label('Taken Status')
                        ->color(fn($state) => $state === 'Has been taken' ? 'success' : 'warning')
                        ->badge()
                        ->icon(fn($state) => $state === 'Has been taken' ? 'heroicon-o-check-circle' : 'heroicon-o-clock')
                        ->state(function ($record) {
                            return $record->is_taken === 1 ? 'Has been taken' : 'Not taken yet';
                        })
                        ->visible(function ($record) {
                            return $record->status === 'approved' ? true : false;
                        }),
                    TextEntry::make('quantity')
                        ->label('Quantity'),
                    TextEntry::make('request_at')
                        ->label('Request At'),
                ])->columns(2),
            ]);
    }
}
