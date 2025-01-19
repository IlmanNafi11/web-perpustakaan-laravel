<?php

namespace App\Filament\Pages;

class Dashboard extends \Filament\Pages\Dashboard
{
    protected static ?string $title = 'Dashboard';

    public function getColumns(): int | string | array
    {
        return 2;
    }
}
