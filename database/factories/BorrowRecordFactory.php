<?php

namespace Database\Factories;

use App\Models\BorrowRequest;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\BorrowRecord>
 */
class BorrowRecordFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $borrowRequest = BorrowRequest::where('is_taken', true)->inRandomOrder()->first();
        $borrow_at = $borrowRequest ? $borrowRequest->processed_at : null;
        $dueDate = Carbon::parse($borrow_at)->addWeek();
        $returnedAt = $this->faker->boolean(70)
            ? $this->faker->dateTimeBetween($borrow_at, '+2 week')
            : null;

        $status = $returnedAt
            ? ($returnedAt > $dueDate ? 'overdue' : 'returned')
            : 'borrowed';

        return [
            'borrow_request_id' => $borrowRequest ? $borrowRequest->id : null,
            'due_date' => $dueDate,
            'borrow_at' => $borrow_at,
            'return_at' => $returnedAt,
            'status' => $status,
        ];
    }
}
