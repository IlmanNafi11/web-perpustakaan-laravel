<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class category extends Model
{
    protected $fillable = [
        'category_name',
    ];
    protected  $guarded = ['id'];
    public function book()
    {
        return $this->hasMany(Book::class);
    }
}
