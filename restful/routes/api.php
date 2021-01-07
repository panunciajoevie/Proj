<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::group([ 'prefix' => '/auth'], 
 function () {

Route::post('/login', 'AuthController@login');

Route::post('/register', 'AuthController@register');

Route::put('/update/{id}', 'AuthController@update');
Route::delete('/delete/{id}','AuthController@delete');
Route::get('/logout', 'AuthController@logout');
Route::post('/refresh', 'AuthController@refresh');
}); 



Route::group(['middleware' => 'api','prefix'=>'/mypets'], 
 function(){

Route::get('/index', 'MypetController@index');
Route::post('/create', 'MypetController@create');
Route::put('/update/{id}', 'MypetController@update');
Route::delete('/delete/{id}','MypetController@delete');

});



Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
