<?php

namespace App\Filament\Widgets;

use Filament\Widgets\ChartWidget;
use App\Service\DashboardStatService;

class StatsLowestBooks extends ChartWidget
{
    protected static ?string $heading = 'Book stock statistics';
    protected static ?int $sort = 5;

    protected function getData(): array
    {
        $dashboardService = new DashboardStatService();

        $title = $dashboardService->getLowestStockOfBooks()->map(fn($books) => $books->title);

        $quantity = $dashboardService->getLowestStockOfBooks()->map(fn($books) => $books->quantity);

        return [
            'datasets' => [
                [
                    'label' => 'Book Stock',
                    'data' => $quantity,
                    'fill' => false,
                    'borderColor' => 'rgb(75, 192, 192)',
                    'tension' => 0.1,
                ]
            ],
            'labels' => $title
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }

    public function getDescription(): ?string
    {
        return '10 Books that have the lowest stock at the moment';
    }
}
