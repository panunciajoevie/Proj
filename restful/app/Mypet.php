<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Mypet extends Model
{
    protected $table = 'mypets';

    protected $fillable = [
       'age'
    ];
}
