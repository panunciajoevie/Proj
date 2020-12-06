import 'package:flutter/material.dart';
import 'package:petility/register.dart';
import 'package:petility/landingpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

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
    Future<String> getLogin(String pseudo) async {
      var response = await http.get(
          Uri.encodeFull(
              "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
          //"http://192.168.137.1/petility/Login.php?PSEUDO=${pseudo}"),
          headers: {"Accept": "application/json"});

      print(response.body);
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson['result'];
      });
    }

    void onSignedInErrorPassword() {
      var alert = new AlertDialog(
        title: new Text("Error"),
        content: new Text(
            "There was an Password error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }

    void onSignedInErrorPseudo() {
      var alert = new AlertDialog(
        title: new Text("Error"),
        content:
            new Text("There was an Pseudo error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }

    VerifData(String pseudo, String password, var datadb) {
      if (data[0]['username'] == pseudo) {
        if (data[0]['password'] == password) {
          // Navigator.of(context).pushNamed("/seconds");

          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new LandingPage(
              idUser: data[0]['user_id'],
              fullname: data[0]['fullname'],
              username: data[0]['username'],
              completeaddress: data[0]['completeaddress'],
              contactno: data[0]['contact'],
            ),
          );
          Navigator.of(context).push(route);
        } else {
          onSignedInErrorPassword();
        }
      } else {
        onSignedInErrorPseudo();
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
                getLogin(_pseudoController.text);
                VerifData(
                    _pseudoController.text, _passwordController.text, data);
                //Navigator.push(context, MaterialPageRoute(
                //builder: (context){
                //return LandingPage();
                //}
                //));
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: ListView(
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
