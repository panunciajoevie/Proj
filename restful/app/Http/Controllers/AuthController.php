<?php

namespace App\Http\Controllers;
use Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Controller;
use App\User;
use Dotenv\Result\Success;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login','register','index','logout','update','delete']]);
    }

    /**
     * Get a JWT token via given credentials.
     *
     * @param  \Illuminate\Http\Request  $request
     *
     * @return \Illuminate\Http\JsonResponse
     */
 
      public function login(Request $request)
    {
        $credentials = $request->only('username', 'password');
    
        if ($token = Auth::guard('api')->attempt($credentials)) {
             return $this->respondWithToken($token);
        }
  
        return response()->json(['status'=> False, 'error' => 'Unauthorized']);
   }



    public function register(Request $request)
    {
        $record = new user;
        $record->fullname = $request->fullname;
        $record->username = $request->username;
        $record->completeaddress=$request->completeaddress;
        $record->contactnumber=$request->contactnumber;
        $record->password = Hash::make($request->password);
        $record->save();
        return response()->json(['status' => true, 'message'=>'User created']);
    }
    /**
     * Get the authenticated User
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json($this->guard()->user());
    }

    /**
     * Log the user out (Invalidate the token)
     *
     * @return \Illuminate\Http\JsonResponse
     */
   

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken($this->guard()->refresh());
    }

    public function index()
    {
        
       $record = user::all();
        return response()->json($record);
    }
    public function logout(Request $request)
    {
        if(!user::checkToken($request)){
            return response()->json([
             'message' => 'Token is required',
             'success' => false,
            ],);
        }
       
        try {
            Auth::invalidate(Auth::parseToken($request->access_token));
            return response()->json([
                'success' => true,
                'message' => 'User logged out successfully'
            ]);
        } catch (Auth $exception) {
            return response()->json([
                'success' => false,
                'message' => 'Sorry, the user cannot be logged out'
            ], 500);
        }
    }

    public function update (Request $request, $id)
    {
        try{
           
            User::findOrFail($id)->update(
                ['fullname'=>$request->fullname,
                 'completeaddress'=>$request->completeaddress,
                 'contactnumber'=>$request->contactnumber]);
           // $record -> save();



        /*
            $record->fullname = $request->fullname;
            $record->completeaddress=$request->completeaddress;
            $record->contactnumber=$request->contactnumber;
            $record -> $this.User::save();
          */  
          //  return response()->json(['status' => true, 'message'=>'Profile Updated']);
            return response()->json(array(
                'user' => User::findOrFail($id)));
          
       // return $this->respondWithToken($token);
            
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }
    public function delete($id)
    {
        try{
            $record = User::FindOrFail($id);
            $record -> delete();
            return response()->json(['status' => true, 'message'=>'Profile Deleted']);
        }catch(\Exception $e){
            return response()->json(['status'=>'Fail']);
        }
    }
   
    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60,
            'user' =>auth('api')->user()
        ]);
    }

    /**
     * Get the guard to be used during authentication.
     *
     * @return \Illuminate\Contracts\Auth\Guard
     */
    public function guard()
    {
        return Auth::guard();
    }
}   