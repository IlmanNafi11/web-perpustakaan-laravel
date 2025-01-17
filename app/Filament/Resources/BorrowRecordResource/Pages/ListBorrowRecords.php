<?php

namespace App\Filament\Resources\BorrowRecordResource\Pages;

use App\Filament\Resources\BorrowRecordResource;
use Filament\Actions\Action;
use Filament\Resources\Pages\ListRecords;

class ListBorrowRecords extends ListRecords
{
    protected static string $resource = BorrowRecordResource::class;

    protected function getHeaderActions(): array
    {
        return [
        ];
    }
}
