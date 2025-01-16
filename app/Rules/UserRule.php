<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class UserRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string, ?string=): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */

    /**
     * Validasi field input user sesuai dengan aturan yang ditentukan.
     *
     * @param string $attribute attribute yang akan divalidasi
     * @param mixed $value value dari attribute yang akan divalidasi
     * @param \Closure $fail callback yang akan dipanggil jika validasi gagal
     * @return void
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $rules = [
            'data.name' => '/^[a-zA-Z\s.\',]+$/',
            'data.phone' => '/^\d+$/',
            'data.address' => '/^[a-zA-Z0-9.,\s]+$/',
        ];

        if (isset($rules[$attribute]) && !preg_match($rules[$attribute], $value)) {
            $messages = [
                'data.name' => 'Only accepts letters, spaces, periods, single quotes, and commas.',
                'data.phone' => 'Invalid telephone number.',
                'data.address' => 'Only accepts letters, numbers, spaces, periods, and commas.',
            ];

            $fail($messages[$attribute] ?? 'Invalid input.');
        }
    }
}
