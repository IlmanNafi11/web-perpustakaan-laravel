<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BorrowRecord extends Model
{
    use HasFactory;
    protected $fillable = [
        "borrow_request_id",
        "borrow_date",
        "return_date",
        "due_date",
    ];

    public function borrowRequest()
    {
        return $this->belongsTo(BorrowRequest::class);
    }
}
