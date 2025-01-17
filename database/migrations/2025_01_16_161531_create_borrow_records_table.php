<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('borrow_records', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId('borrow_request_id')->constrained()->cascadeOnDelete()->cascadeOnUpdate();
            $table->date('borrow_at');
            $table->date('return_at')->nullable();
            $table->date('due_date');
            $table->string('status')->default('borrowed');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('borrow_records');
    }
};
