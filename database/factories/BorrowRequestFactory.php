<?php

namespace Database\Factories;

use App\Models\Book;
use App\Models\Member;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\BorrowRequest>
 */
class BorrowRequestFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $status = $this->faker->randomElement(['pending', 'approved', 'rejected']);
        $processed_at = $status === 'approved' || $status === 'rejected' ? now() : null;
        return [
            "member_id"=> Member::inRandomOrder()->first()->id,
            "book_id"=> Book::inRandomOrder()->first()->id,
            'status' => $status,
            'quantity' => $this->faker->numberBetween(1, 5),
            'request_at' => now(),
            'processed_at'=> $processed_at,
            'is_taken' => $status === 'approved' ? true : false,
        ];
    }
}
