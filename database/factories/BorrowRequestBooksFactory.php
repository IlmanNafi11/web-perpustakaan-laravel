<?php

namespace Database\Factories;

use App\Models\Book;
use App\Models\Model;
use App\Models\BorrowRequest;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\BorrowRequestBooks>
 */
class BorrowRequestBooksFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $borrowRequest = BorrowRequest::inRandomOrder()->first()->id;
        $book = Book::inRandomOrder()->first()->id;
        return [
            'borrow_request_id' =>$borrowRequest,
            'book_id' =>$book,
        ];
    }
}
