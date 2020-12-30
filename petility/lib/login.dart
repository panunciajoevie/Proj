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
  @override
  final _formKey = GlobalKey<FormState>();
  var _pseudoController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var data;
  var _isSecured = true;
  bool _isLoading = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/UI.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(right: 24.0, left: 24.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                MainLogo(),
                SizedBox(height: 20.0),

                Text("User Name",
                    style: TextStyle(fontSize: 25, fontFamily: 'Caveat')),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your username';
                      }
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      filled: true,
                      hintText: "Write your Username",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                    controller: _pseudoController,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("Password",
                    style: TextStyle(fontSize: 25, fontFamily: 'Caveat')),
                Container(
                  child: TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.remove_red_eye),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hintText: "Enter Password"),
                    controller: _passwordController,
                  ),
                ),
                //   pseudo,
                SizedBox(
                  height: 8.0,
                ),

                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        getLogin(
                            _pseudoController.text, _passwordController.text);
                      }
                    },
                    padding: EdgeInsets.all(15),
                    color: Color(0xff1565c0),
                    child: Text(
                      _isLoading ? 'logging-in...' : 'Login',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Register();
                          },
                        ),
                      );
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getLogin(
    String pseudo,
    String password,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await http.post(
        Uri.encodeFull(
            //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
            //laravel api

            "http://192.168.0.25:8000/api/auth/login"),
        headers: {"Accept": "application/json"},
        body: {
          "username": _pseudoController.text,
          "password": _passwordController.text,
        },
      );

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
        print("Token: " + data['access_token']);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', data['access_token']);
        localStorage.setString('user', json.encode(data['user']));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LandingPage();
            },
          ),
        );
        setState(
          () {
            _isLoading = false;
          },
        );
      }
    } catch (e) {
      setState(
        () {
          _isLoading = false;
        },
      );
      var alert = new AlertDialog(
        title: new Text("Error!"),
        content: new Text("Error Connecting to Host. Please try again."),
      );
      showDialog(context: context, child: alert);
      return 'connection error';
    }

    setState(
      () {
        _isLoading = false;
      },
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
