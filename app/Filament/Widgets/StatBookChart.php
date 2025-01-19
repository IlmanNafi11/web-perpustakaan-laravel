<?php

namespace App\Filament\Widgets;

use Illuminate\Support\Str;
use Filament\Widgets\ChartWidget;
use App\Service\DashboardStatService;

class StatBookChart extends ChartWidget
{
    protected static ?string $heading = 'Category statistics';
    protected static ?int $sort = 3;
    protected static ?string $maxHeight = '400px';

    protected function getData(): array
    {
        $dashboardService = new DashboardStatService();

        $categories = $dashboardService->getTotalBookByCategory()->map(function ($categories) {
            return Str::ucfirst($categories['category_name']);
        });

        $totalBookPerCategory = $dashboardService
            ->getTotalBookByCategory()
            ->map(fn($category) => $category['book_count']);

        return [
            'datasets' => [
                [
                    'label' => '5 Most Categories',
                    'data' => $totalBookPerCategory,
                    'backgroundColor' => [
                        'rgb(255, 99, 132)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(156, 255, 126)',
                        'rgb(253, 116, 242)',
                    ],
                    'hoverOffset' => 4,
                ]
            ],
            'labels' => $categories
        ];
    }

    protected function getType(): string
    {
        return 'pie';
    }

    public function getDescription(): ?string
    {
        return '5 Categories with the most books';
    }
}
