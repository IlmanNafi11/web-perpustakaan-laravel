<?php
use App\Http\Controllers\CategoryController;
use Illuminate\Support\Facades\Route;

Route::get('category-list', [CategoryController::class, 'getCategoryList']);
