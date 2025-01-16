<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class BookRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $rules = [
            "data.title"=> "/^[a-zA-Z0-9\s\.\,\-\_\&\(\)\:\?]+$/",
            "data.author"=> "/^[a-zA-Z\s.\',]+$/",
            "data.publisher"=> "/^[a-zA-Z\s.\',]+$/",
        ];

        $messages = [
            "data.title"=> "Invalid book title",
            "data.author"=> "Only accepts letters, spaces, periods, single quotes, and commas.",
            "data.publisher"=> "Only accepts letters, spaces, periods, single quotes, and commas.",
        ];

        if (isset($attribute) && !preg_match($rules[$attribute], $value)) {
            $fail($messages[$attribute] ?? 'Invalid input.');
        }

    }
}
