<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class categorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("category")->insert(
            [
                ["category_name"=> "filosofi"],
                ["category_name"=> "education"],
                ["category_name"=> "comic"],
                ["category_name" => "novel"],
                ["category_name" => "ensiclopedia"],
                ["category_name" => "self improvement"],
            ]
        );
    }
}
