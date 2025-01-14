<?php

namespace App\Http\Controllers;

use App\Models\category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function getCategoryList()
    {
        $categories = category::select('id' ,'category_name')->get();
        return response()->json($categories);
    }
}
