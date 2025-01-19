<?php

namespace App\Service;

use App\Models\Book;
use App\Models\BorrowRecord;
use App\Models\BorrowRequest;
use App\Models\category;
use App\Models\Member;
use Carbon\Carbon;
use Carbon\Month;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class DashboardStatService
{
    /**
     * Mengambil total koleksi buku yang tersedia
     * @return int total koleksi buku
     */
    public function getTotalBooks(): int
    {
        return Book::sum('quantity');
    }

    /**
     * Mengambil total koleksi judul buku yang tersedia
     * @return int total koleksi judul buku
     */
    public function getTotalBookTitles(): int
    {
        return Book::distinct()->count('title');
    }

    /**
     * Mengambil total member yang terdaftar
     * @return int total member
     */
    public function getTotalMembers(): int
    {
        return Member::count();
    }

    /**
     * Mengambil total permintaan peminjaman pada hari ini
     * @return int total permintaan peminjaman
     */
    public function getTotalBorrowRequest(): int
    {
        return BorrowRequest::whereDate('request_at', today())->count();
    }

    /**
     * Mengambil total transaksi peminjaman yang berhasil pada hari ini.
     * Transaksi dikatakan berhasil hanya jika buku diambil oleh pengaju peminjaman buku.
     * @return int total transaksi peminjaman
     */
    public function getTotalTransactionTodays(): int
    {
        return BorrowRecord::whereDate('borrow_at', today())->count();
    }

    /**
     * Mangambil nilai persentase dari total kuantitas buku. persentase didapatkan melalui
     * perbandingan antara nilai total kuantitas pada hari sebelumnya dengan hari saat ini.
     *   
     * @return array {
     *     percentage_change: float,
     *     status: string,
     *     today: int,
     *     yesterday: int,
     *     color: string,
     *     icon: string
     * }
     */
    public function getBookPercentageStatistics()
    {
        $today = Book::whereDate('updated_at', today())->sum('quantity');
        $yesterday = Book::whereDate('updated_at', today()->subDay())->sum('quantity');
        $style = $this->getStyleStatistic();

        if ($today == 0 && $yesterday == 0) {
            return [
                'percentage_change' => 0,
                'status' => 'no change',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        if ($yesterday == 0) {
            $style = $this->getStyleStatistic('increase');
            return [
                'percentage_change' => 100,
                'status' => 'increase',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        $difference = $today - $yesterday;
        $percentageChange = ($difference / $yesterday) * 100;

        $status = $percentageChange > 0 ? 'increase' : ($percentageChange < 0 ? 'decrease' : 'no change');
        $style = $this->getStyleStatistic(status: $status);

        return [
            'status' => $status,
            'percentage_change' => round($percentageChange, 2),
            'today' => $today,
            'yesterday' => $yesterday,
            'color' => $style['color'],
            'icon' => $style['icon'],
        ];
    }

    /**
     * Mengambil nilai persentase data member. persentase didapatkan dengan membandingkan jumlah pendaftaran member pada hari ini dengan hari sebelumnya. 
     * @return array persentase jumlah pendaftaran member
     */
    public function getMemberPercentageStatistics()
    {
        $today = Member::whereDate('created_at', today())->count();
        $yesterday = Member::whereDate('created_at', today()->subDay())->count();
        $style = $this->getStyleStatistic();

        if ($today == 0 && $yesterday == 0) {
            return [
                'percentage_change' => 0,
                'status' => 'no change',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        if ($yesterday == 0) {
            $style = $this->getStyleStatistic('increase');
            return [
                'percentage_change' => 100,
                'status' => 'increase',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        $difference = $today - $yesterday;
        $percentageChange = ($difference / $yesterday) * 100;

        $status = $percentageChange > 0 ? 'increase' : ($percentageChange < 0 ? 'decrease' : 'no change');
        $style = $this->getStyleStatistic(status: $status);

        return [
            'status' => $status,
            'percentage_change' => round($percentageChange, 2),
            'today' => $today,
            'yesterday' => $yesterday,
            'color' => $style['color'],
            'icon' => $style['icon'],
        ];
    }

    /**
     * Mengambil nilai persentase permintan peminjaman buku. Persentase didapatkan dengan membandingkan jumlah permintaan pada hari ini dengan hari sebelumnya. 
     * @return array Persentase permintaan peminjaman
     */
    public function getLoanRequestPercentageStatistics()
    {
        $today = BorrowRequest::whereDate('request_at', today())->count();
        $yesterday = BorrowRequest::whereDate('request_at', today()->subDay())->count();
        $style = $this->getStyleStatistic();

        if ($today == 0 && $yesterday == 0) {
            return [
                'percentage_change' => 0,
                'status' => 'no change',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        if ($yesterday == 0) {
            $style = $this->getStyleStatistic('increase');
            return [
                'percentage_change' => 100,
                'status' => 'increase',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        $difference = $today - $yesterday;
        $percentageChange = ($difference / $yesterday) * 100;

        $status = $percentageChange > 0 ? 'increase' : ($percentageChange < 0 ? 'decrease' : 'no change');
        $style = $this->getStyleStatistic(status: $status);

        return [
            'status' => $status,
            'percentage_change' => round($percentageChange, 2),
            'today' => $today,
            'yesterday' => $yesterday,
            'color' => $style['color'],
            'icon' => $style['icon'],
        ];
    }

    /**
     * Mengambil nilai persentase transaksi peminjaman. Persentase didapatkan dengan membandingkan jumlah transaksi peminjaman pada hari ini dengan hari sebelumnya. 
     * @return array Persentase transaksi peminjaman
     */
    public function getLoanTransactionPercentageStatistics()
    {
        $today = BorrowRecord::whereDate('borrow_at', operator: today())->count();
        $yesterday = BorrowRecord::whereDate('borrow_at', today()->subDay())->count();
        $style = $this->getStyleStatistic();

        if ($today == 0 && $yesterday == 0) {
            return [
                'percentage_change' => 0,
                'status' => 'no change',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        if ($yesterday == 0) {
            $style = $this->getStyleStatistic('increase');
            return [
                'percentage_change' => 100,
                'status' => 'increase',
                'today' => $today,
                'yesterday' => $yesterday,
                'color' => $style['color'],
                'icon' => $style['icon'],
            ];
        }

        $difference = $today - $yesterday;
        $percentageChange = ($difference / $yesterday) * 100;

        $status = $percentageChange > 0 ? 'increase' : ($percentageChange < 0 ? 'decrease' : 'no change');
        $style = $this->getStyleStatistic(status: $status);

        return [
            'status' => $status,
            'percentage_change' => round($percentageChange, 2),
            'today' => $today,
            'yesterday' => $yesterday,
            'color' => $style['color'],
            'icon' => $style['icon'],
        ];
    }

    /**
     * Mengambil style stats card overview berdasarkan nilai $status
     * @param string $status status statistik (no change | increase | decrease)
     * @return array {
     * color: string,
     * icon : string,
     * }
     */
    private function getStyleStatistic(string $status = 'no change')
    {

        $color = $status !== 'no change' ? ($status === 'increase' ? 'success' : 'danger') : 'gray';
        $icon = $status !== 'no change' ? ($status === 'increase' ? 'heroicon-m-arrow-trending-up' : 'heroicon-m-arrow-trending-down') : null;
        return [
            'color' => $color,
            'icon' => $icon
        ];
    }

    /**
     * Mengambil data statistik $model berdasarkan $column yang ditentukan dalam rentang bulan saat ini
     * @param string $model model yang ingin didapatkan statistiknya
     * @param string $column kolom dari model yang ditentukan sebagai filter
     * @return mixed
     */
    public function getCardChartStatisticOfThisMonth(string $model, string $column)
    {
        return $model::whereMonth($column, now()->month)
            ->select(DB::raw(value: "DATE($column) as day"), DB::raw('count(*) as total_per_day'))
            ->groupBy(DB::raw("DATE($column)"))
            ->orderBy('day')
            ->pluck('total_per_day')
            ->toArray();
    }

    /**
     * Mengambil total buku dari setiap categori
     * @return \Illuminate\Database\Eloquent\Collection Koleksi kategori dengan jumlah buku terkait
     */
    public function getTotalBookByCategory()
    {
        return category::withCount('book')
            ->orderByDesc('book_count')
            ->take(5)
            ->get();
    }

    /**
     * Mengembalikan seluruh tanggal dari bulan saat ini 
     * @return array array tanggal
     */
    public function getTotalDayOfTheMonth()
    {
        $end = Carbon::now()->daysInMonth();
        return range(1, $end);
    }

    /**
     * Mengambil 10 buku dengan jumlah stok terendah pada saat ini. Dapat digunakan sebagai indikator menipisnya ketersediaan pada buku tertentu
     * @return \Illuminate\Database\Eloquent\Collection Koleksi buku
     */
    public function getLowestStockOfBooks()
    {
        return Book::select('title', 'quantity', 'type')
            ->orderBy('quantity')
            ->take(10)
            ->get();
    }
}
