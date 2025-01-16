<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    protected $fillable = [
        'title',
        'author',
        'isbn',
        'cover',
        'description',
        'quantity',
        'available',
        'year',
        'publisher',
        'language',
        'category_id',
        'type',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function borrowRequests()
    {
        return $this->hasMany(BorrowRequest::class);
    }
}
