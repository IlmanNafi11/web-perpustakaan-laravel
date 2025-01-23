<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AdminResource\Pages;
use App\Filament\Resources\AdminResource\RelationManagers;
use App\Models\User;
use App\Rules\UserRule;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Tables\Actions\CreateAction;
use Filament\Tables\Actions\EditAction;
use Filament\Forms;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Notifications\Notification;
use Filament\Tables\Actions\DeleteAction;

class AdminResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-user';
    protected static ?string $label = 'Admin';
    protected static ?string $navigationLabel = 'Admins';
    protected static ?string $navigationGroup = 'User Management';

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->where('role', 3);
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                TextInput::make('name')
                    ->label('Name')
                    ->required()
                    ->rule([new UserRule]),
                TextInput::make('email')
                    ->label('Email')
                    ->required()
                    ->unique()
                    ->validationMessages([
                        'unique' => 'Email is already in use',
                        'email' => 'Email is not valid',
                        'required' => 'Email is required',
                    ]),
                TextInput::make('phone')
                    ->label('Phone')
                    ->required()
                    ->numeric()
                    ->minLength(12)
                    ->maxLength(13)
                    ->startsWith('08')
                    ->rule([new UserRule]),
                TextInput::make('address')
                    ->label('Address')
                    ->required()
                    ->rule([new UserRule]),
                TextInput::make('password')
                    ->label('Password')
                    ->required()
                    ->password()
                    ->revealable()
                    ->minLength(8)
                    ->same('re-password'),
                TextInput::make('re-password')
                    ->label('Re-pasword')
                    ->required()
                    ->password()
                    ->revealable()
                    ->minLength(8),
                Select::make('role')
                ->label('Role')
                ->relationship('roles', 'name')
                ->searchable()
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('photo_path')
                    ->label('Photo')
                    ->circular()
                    ->extraImgAttributes([
                        'loading' => 'lazy',
                    ]),
                TextColumn::make('name')
                    ->searchable(),
                TextColumn::make('email'),
                TextColumn::make('phone')
                    ->searchable(),
                TextColumn::make('address'),
            ])
            ->filters([
                //
            ])
            ->actions([
                DeleteAction::make()
                    ->successNotification(
                        Notification::make()
                            ->success()
                            ->title('Admin deleted')
                            ->body('The admin has been deleted successfully.'),
                    )
                    ->button(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->deferLoading();
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
            'index' => Pages\ListAdmins::route('/'),
            'create' => Pages\CreateAdmin::route('/create'),
        ];
    }
}
