<?php

namespace App\Http\Controllers;
use App\Mypet;
use Illuminate\Http\Request;

class MypetController extends Controller
{
    public function index()
    {
        $record = Mypet::all();
        return response()->json($record);
    }

    public function create(Request $request)
    {
        $record = new Mypet;
        $record->name = $request->name;
        $record->pet = $request->pet;
        $record->breed = $request->breed;
        $record->age = $request->age;
        $record->sex = $request->sex;
        $record->save();
        
        return response()->json(array(
            'success' => true, 'mypets' => Mypet::findOrFail($record->id)));
    }

    public function update (Request $request, $id)
    {
        try{
           
            Mypet::findOrFail($id)->update(
                [
                 'age'=>$request->age]);

            return response()->json(array(
                    'mypets' => Mypet::findOrFail($id)));
         
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }

    public function delete($id)
    {
        try{
            $record = Mypet::FindOrFail($id);
            $record -> delete();
            return response()->json(['status' => true, 'message'=>'Profile Deleted']);
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }    
}


