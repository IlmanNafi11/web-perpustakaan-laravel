<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BorrowRequestBooks extends Model
{
    use HasFactory;
    protected $fillable = ['borrow_request_id', 'book_id'];

    public function book()
    {
        return $this->belongsTo(Book::class);
    }

    public function borrowRequest()
    {
        return $this->belongsTo(BorrowRequest::class);
    }
}
