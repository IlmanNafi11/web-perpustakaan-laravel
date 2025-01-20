<?php

namespace Database\Seeders;

use App\Models\BorrowRequest;
use App\Models\BorrowRequestBooks;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BorrowRequestBookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $count = BorrowRequest::count();
        BorrowRequestBooks::factory()->count($count)->create();
    }
}
