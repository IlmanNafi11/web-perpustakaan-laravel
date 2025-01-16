<?php

namespace App\Filament\Resources\AdminResource\Pages;

use App\Filament\Resources\AdminResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;
use Filament\Notifications\Notification;

class CreateAdmin extends CreateRecord
{
    protected static string $resource = AdminResource::class;

    protected function getCreatedNotification(): ?Notification
    {
    return Notification::make()
        ->success()
        ->icon("heroicon-o-check-circle")
        ->title('Succeed')
        ->body('Admin added successfully');
    }
}
