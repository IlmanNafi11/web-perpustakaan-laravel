<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BorrowRequest extends Model
{
    protected $fillable = [
        "member_id",
        "book_id",
        "status",
        "quantity",
        "request_at",
        "processed_at",
    ];

    protected static function booted()
    {
        static::updating(function ($model) {
            $model->processed_at = now();
        });
    }

    public function member()
    {
        return $this->belongsTo(Member::class);
    }

    public function book()
    {
        return $this->belongsTo(Book::class);
    }
}
