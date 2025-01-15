<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // DB::table('users')->insert([
        //     'name' => 'ilmannafi',
        //     'email' => 'ilman@gmail.com',
        //     'password' => bcrypt('12345678'),
        //     'address' => 'Jl. Raya No. 1',
        //     'role' => 'admin',
        //     'phone' => '08123456789',
        // ]);
        User::factory()->count(10)->create();
    }
}
