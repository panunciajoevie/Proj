import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petility/landingpage.dart';

class Register extends StatefulWidget {
  static String tag = 'register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final ThemeData _CeTheme = _buildTheme();
  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();
  }
   bool _isLoading = false;
  void onCreatedAccount() {
    var alert = new AlertDialog(
      backgroundColor: Color(0xffF57F17),
      title: new Text(
        'Success!',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30.0),
      ),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('You have created a new Account.'),
          ],
        ),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: new Text(
            'Okay',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserProfile();
        }));
          },
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

  var _fullnameController = new TextEditingController();
  var _usernameController = new TextEditingController();
  var _completeaddressController = new TextEditingController();
  var _contactnumberController = new TextEditingController();
  var _passwordController = new TextEditingController();
  void _addData()  {
    var url = //"https://petility.000webhostapp.com/NewUser.php";
        "http://192.168.0.25:8000/api/auth/register";
     http.post(url, headers: {
      'Accept': 'application/json'
    }, body: {
      "fullname": _fullnameController.text,
      "username": _usernameController.text,
      "completeaddress": _completeaddressController.text,
      "contactnumber": _contactnumberController.text,
      "password": _passwordController.text,
    });
    onCreatedAccount();
  }

  @override
  Widget build(BuildContext context) {
    final Fname = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Full name must be filled';
        }
      },
      autofocus: false,
      controller: _fullnameController,
      //initialValue: 'joeviepanuncia@gmail.com',
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Full Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Uname = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Username must be filled';
        }
      },
      autofocus: false,
      controller: _usernameController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Address = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address must be filled';
        }
      },
      autofocus: false,
      controller: _completeaddressController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Complete Address',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Contact = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Contact Number must be filled';
        }
      },
      autofocus: false,
      controller: _contactnumberController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Contact Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Password = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password must be filled';
        }
      },
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

////REGISTER BUTTON
    final registerBtn = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _addData();
              }
            },
            padding: EdgeInsets.all(15),
            color: Color(0xff1565c0),
            child: Text(
              _isLoading ? 'Login...' : 'Login',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1565c0),
        title: Text(
          'Signup',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(right: 24.0, left: 24.0),
            children: <Widget>[
              SizedBox(height: 30.0),
              Fname,
              SizedBox(height: 8.0),
              Uname,
              SizedBox(
                height: 8.0,
              ),
              Address,
              SizedBox(height: 8.0),
              Contact,
              SizedBox(height: 8.0),
              Password,
              SizedBox(height: 50.0),
              registerBtn,
            ],
          )),
    );
  }
}