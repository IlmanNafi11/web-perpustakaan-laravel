<?php

namespace Database\Seeders;

use App\Models\BorrowRequest;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BorrowRequestSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        BorrowRequest::factory()
            ->count(50)
            ->create();
    }
}
