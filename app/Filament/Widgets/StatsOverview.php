<?php

namespace App\Filament\Widgets;

use App\Http\Controllers\CategoryController;
use App\Models\Book;
use App\Models\BorrowRecord;
use App\Models\BorrowRequest;
use App\Models\Member;
use App\Service\DashboardStatService;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;
use Illuminate\Support\Facades\DB;
use Symfony\Component\VarDumper\VarDumper;
use Illuminate\Support\Facades\Log;

class StatsOverview extends BaseWidget
{
    protected ?string $heading = 'Analytics';
    protected ?string $description = 'An overview of some analytics.';
    protected function getStats(): array
    {
        $dashboardService = new DashboardStatService();

        // Data statistik buku
        $bookStatistic = $dashboardService->getBookPercentageStatistics();
        $bookPercentage = (int) $bookStatistic['percentage_change'];
        $bookStatus = (string) $bookStatistic['status'];
        $statBookIcon = (string) $bookStatistic['icon'];
        $statBookColor = (string) $bookStatistic['color'];

        // Data statistik member
        $memberStatistic = $dashboardService->getMemberPercentageStatistics();
        $memberPercentage = (int) $memberStatistic['percentage_change'];
        $memberStatus = (string) $memberStatistic['status'];
        $statMemberIcon = (string) $memberStatistic['icon'];
        $statMemberColor = (string) $memberStatistic['color'];

        // Data statistik permintaan peminjaman
        $loanRequestStatistic = $dashboardService->getLoanRequestPercentageStatistics();
        $loanRequestPercentage = (int) $loanRequestStatistic['percentage_change'];
        $loanRequestStatus = (string) $loanRequestStatistic['status'];
        $statLoanRequestIcon = (string) $loanRequestStatistic['icon'];
        $statLoanRequestColor = (string) $loanRequestStatistic['color'];

        // Data statistic total transaksi peminjaman
        $loanTransactionStatictic = $dashboardService->getLoanTransactionPercentageStatistics();
        $loanTransactionPercentage = (int) $loanTransactionStatictic['percentage_change'];
        $loanTransactionStatus = (string) $loanTransactionStatictic['status'];
        $statLoanTransactionIcon = (string) $loanTransactionStatictic['icon'];
        $statLoanTransactionColor = (string) $loanTransactionStatictic['color'];

        // dd($dashboardService->getCardChartStatisticOfThisMonth(Member::class, 'created_at', null, 'select'));
        return [
            Stat::make('Total Books', $dashboardService->getTotalBooks())
                ->description($bookPercentage . '% ' . $bookStatus)
                ->descriptionIcon($statBookIcon)
                ->color($statBookColor)
                ->chart($dashboardService->getCardChartStatisticOfThisMonth(Book::class, 'created_at')),
            Stat::make('Total Member', $dashboardService->getTotalMembers())
                ->description($memberPercentage . '% ' . $memberStatus)
                ->descriptionIcon($statMemberIcon)
                ->color($statMemberColor)
                ->chart($dashboardService->getCardChartStatisticOfThisMonth(Member::class, 'created_at')),
            Stat::make('Loan Request', $dashboardService->getTotalBorrowRequest())
                ->description($loanRequestPercentage . '% ' . $loanRequestStatus)
                ->descriptionIcon($statLoanRequestIcon)
                ->color($statLoanRequestColor)
                ->chart($dashboardService->getCardChartStatisticOfThisMonth(BorrowRequest::class, 'request_at')),
            Stat::make('Today\'s loan transactions', $dashboardService->getTotalTransactionTodays())
                ->description($loanTransactionPercentage. '% ' . $loanTransactionStatus)
                ->descriptionIcon($statLoanTransactionIcon)
                ->color($statLoanTransactionColor)
                ->chart($dashboardService->getCardChartStatisticOfThisMonth(BorrowRecord::class, 'created_at')),
        ];
    }
}
