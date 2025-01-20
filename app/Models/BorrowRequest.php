<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BorrowRequest extends Model
{
    use HasFactory;
    protected $fillable = [
        "member_id",
        "status",
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

    public function borrowRequestBooks()
    {
        return $this->hasMany(related: BorrowRequestBooks::class);
    }

    public function borrowRecord()
    {
        return $this->hasOne(BorrowRecord::class);
    }

    public function books()
    {
        return $this->hasManyThrough(Book::class, BorrowRequestBooks::class, 'borrow_request_id', 'id', 'id', 'book_id');
    }
}
