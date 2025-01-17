<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BorrowRequest extends Model
{
    use HasFactory;
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

    public function borrowRecord()
    {
        return $this->hasOne(BorrowRecord::class);
    }
}
