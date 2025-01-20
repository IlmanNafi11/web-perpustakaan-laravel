<?php

namespace App\Filament\Resources;

use Carbon\Carbon;
use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\BorrowRecord;
use App\Models\BorrowRequest;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Actions\Action;
use Filament\Tables\Filters\Filter;
use Illuminate\Support\Facades\Log;
use Filament\Infolists\Components\Tabs;
use Filament\Tables\Columns\TextColumn;
use Filament\Infolists\Components\Group;
use Filament\Notifications\Notification;
use Filament\Forms\Components\DatePicker;
use Filament\Tables\Actions\DeleteAction;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\Tabs\Tab;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Components\ImageEntry;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\BorrowRequestResource\Pages;
use Filament\Tables\Actions\ActionGroup as ActionsActionGroup;
use App\Filament\Resources\BorrowRequestResource\RelationManagers;
use App\Filament\Resources\BorrowRequestResource\Widgets\StatsOverview;

class BorrowRequestResource extends Resource
{
    protected static ?string $model = BorrowRequest::class;

    protected static ?string $navigationIcon = 'eos-assignment-returned-o';
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
                TextColumn::make('member.user.name')
                    ->searchable()
                    ->sortable()
                    ->label('Member'),
                TextColumn::make('books.title')
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
                                ])
                                ->validationMessages([
                                    'required' => 'The loan date cannot be empty'
                                ]),
                            DatePicker::make('return_at')
                                ->label('Return at')
                                ->afterOrEqual('borrow_at')
                                ->rules([
                                    'required'
                                ])
                                ->validationMessages([
                                    'required' => 'The return date cannot be blank'
                                ]),
                        ])
                        ->action(function (array $data, BorrowRequest $record) {
                            $borrowRequest = $record;

                            $borrowRequest->is_taken = true;
                            $borrowRequest->save();

                            $borrowRecord = new BorrowRecord();
                            $borrowRecord->borrow_request_id = $borrowRequest->id;
                            $borrowRecord->borrow_at = $data['borrow_at'];
                            $borrowRecord->return_at = $data['return_at'];
                            $borrowRecord->due_date = Carbon::parse($data['return_at'])->addDays(3);
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
                Tabs::make('Tabs 1')
                    ->columnSpanFull()
                    ->tabs([
                        Tabs\Tab::make('requestDetails')
                            ->label('Member details')
                            ->schema([
                                Group::make([
                                    ImageEntry::make('member.user.photo_path')
                                        ->label('Member Photo')
                                        ->size(250),
                                ]),
                                Group::make([
                                    TextEntry::make('member.user.name')
                                        ->label('Member Name'),
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
                                    TextEntry::make('request_at')
                                        ->label('Request At'),
                                ])
                                ->columns(2)
                            ])
                            ->columns(2),
                        Tabs\Tab::make('Books Detail')
                            ->label('Books Detail')
                            ->schema(function ($record) {

                                // Ambil jumlah buku terkait yang dipinjam
                                $borrow = $record->borrowRequestBooks->mapWithKeys(fn($borrow): array => [
                                    $borrow->book_id => [
                                        'quantity' => $borrow->quantity,
                                        'book_id' => $borrow->book_id,
                                    ]
                                ]);

                                // dd($borrow);
                                // Ambil books terkait
                                $books = $record->books->map(function ($book) use ($borrow) {
                                    $loanAmount = $borrow[$book->id]['quantity'] ?? 1;

                                    return [
                                        'id' => $book->id,
                                        'cover' => $book->cover,
                                        'title' => $book->title,
                                        'publisher' => $book->publisher,
                                        'author' => $book->author,
                                        'stock' => $book->quantity,
                                        'loan_amount' => $loanAmount,
                                    ];
                                });

                                // dd($books);

                                return $books->map(function ($book) {
                                    return Section::make($book['title'] ?? 'bro')
                                        ->label($book['title'])
                                        ->schema([
                                            Group::make([
                                                ImageEntry::make('cover')
                                                    ->state($book['cover'])
                                                    ->label('Book Cover')
                                            ]),
                                            Group::make([
                                                TextEntry::make('title')
                                                    ->label('Title')
                                                    ->state($book['title']),
                                                TextEntry::make('author')
                                                    ->label('Author')
                                                    ->state($book['author']),
                                                TextEntry::make('publisher')
                                                    ->label('Publisher')
                                                    ->state($book['publisher']),
                                                TextEntry::make('stock')
                                                    ->label('Available')
                                                    ->state($book['stock']),
                                                TextEntry::make('quantity')
                                                    ->label('Loan amount')
                                                    ->state($book['loan_amount']),
                                            ])
                                            ->columns(2),
                                        ])
                                        ->columns(2);
                                })->toArray();
                            }),
                    ]),
            ]);
    }
}
