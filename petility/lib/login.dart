import 'package:flutter/material.dart';
import 'package:petility/register.dart';
import 'package:petility/landingpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static String tag = 'login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _pseudoController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var data;
  var _isSecured = true;

  @override
  Widget build(BuildContext context) {
    getLogin(
      String pseudo,
      String password,
    ) async {
      //    SharedPreferences sharedPreferences =
      //       await SharedPreferences.getInstance();
      var response = await http.post(Uri.encodeFull(
          //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
          //laravel api
          "http://192.168.0.25:8000/api/auth/login"), headers: {
        "Accept": "application/json"
      }, body: {
        "username": _pseudoController.text,
        "password": _passwordController.text,
      });

      var status = response.body.contains('error');
      var data = json.decode(response.body);
      // print(data);
      if (status) {
        print(
            'data: data["Error: Incorrect Username or Password. Please try again."]');
        var alert = new AlertDialog(
          title: new Text("Error"),
          content:
              new Text("Incorrect Username or Password. Please try again."),
        );
        showDialog(context: context, child: alert);
      } else {
        print(data['user']);
        print("Token: "+data['access_token']);
        // _save(data['access_token']);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LandingPage();
        }));
      }
    }

    var pseudo = new ListTile(
      leading: const Icon(Icons.person),
      title: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter your username';
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
          labelText: "Username",
          filled: true,
          hintText: "Write your Username please",
          contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        controller: _pseudoController,
      ),
    );

    var password = new ListTile(
      leading: const Icon(Icons.remove_red_eye),
      title: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter your password';
          }
        },
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
          labelText: "   Password",
          hintText: "Write your Password please",
          contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        obscureText: _isSecured,
        controller: _passwordController,
      ),
    );

    final loginBtn = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                getLogin(_pseudoController.text, _passwordController.text);
              }
            },
            padding: EdgeInsets.all(15),
            color: Color(0xff1565c0),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )));

    final Signup = Padding(
        padding: EdgeInsets.symmetric(vertical: 1.0),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Register();
              }));
            },
            padding: EdgeInsets.all(15),
            color: Color(0xff1565c0),
            child: Text(
              'Create Account',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )));

    return Scaffold (
   
      
          body:Form(
          key: _formKey,
          child: 
          ListView(
            
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 24.0, left: 24.0),
            children: <Widget>[
               
              SizedBox(height: 20.0),
              MainLogo(),
              SizedBox(height: 20.0),
              //Username,
              pseudo,
              SizedBox(
                height: 8.0,
              ),
              password,
              SizedBox(height: 24.0),
              loginBtn,
              Signup,
            ],
          )),
    );
  }
}
/*_save(String token) async {
  .  final prefs = await SharedPreferences.getInstance();
  .  final key = 'token';
  .  final value = token;
  .. prefs.setString(key, value);
   }
  */

class MainLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/petilityicon.png');
    var image = Image(
      image: assetsImage,
      width: 250,
      height: 250,
    );
    return Container(child: image);
  }
}