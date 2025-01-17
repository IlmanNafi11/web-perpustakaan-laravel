<?php

namespace Database\Seeders;

use App\Models\BorrowRecord;
use Database\Factories\BorrowRecordFactory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BorrowRecordSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        BorrowRecord::factory()->count(5)->create();
    }
}
