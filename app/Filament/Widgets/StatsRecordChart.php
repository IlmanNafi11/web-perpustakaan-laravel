<?php

namespace App\Filament\Widgets;

use App\Models\BorrowRequest;
use App\Service\DashboardStatService;
use Filament\Widgets\ChartWidget;

class StatsRecordChart extends ChartWidget
{
    protected static ?string $heading = 'Loan Request Statictic';
    protected static ?string $maxHeight = '400px';

    protected int | string | array $columnSpan = 'full';
    protected function getData(): array
    {
        $dashboardService = new DashboardStatService();

        return [
            'datasets' => [
                [
                    'label' => 'Loan Request',
                    'data' => $dashboardService->getCardChartStatisticOfThisMonth(BorrowRequest::class, 'request_at'),
                ],
            ],
            'labels' => $dashboardService->getTotalDayOfTheMonth(),
        ];
    }

    protected function getType(): string
    {
        return 'bar';
    }

    public function getDescription(): ?string
    {
        return 'Loan Requests this month';
    }
}
