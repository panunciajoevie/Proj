import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:petility/login.dart';
import 'package:petility/mypet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePet extends StatefulWidget {
  static String tag = 'register';
  @override
  _CreatePetState createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  final _formKey = GlobalKey<FormState>();

  final ThemeData _CeTheme = _buildTheme();
  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();
  }

  bool _isLoading = false;

  var _nameController = new TextEditingController();
  var _petController = new TextEditingController();
  var _breedController = new TextEditingController();
  var _ageController = new TextEditingController();
  var _sexController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Fname = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name must be filled';
        }
      },
      autofocus: false,
      controller: _nameController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Uname = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pet must be filled';
        }
      },
      autofocus: false,
      controller: _petController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Pet',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Address = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Breed must be filled';
        }
      },
      autofocus: false,
      controller: _breedController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Breed',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Contact = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age must be filled';
        }
      },
      autofocus: false,
      controller: _ageController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Age',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

    final Password = TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Gender must be filled';
        }
      },
      autofocus: false,
      controller: _sexController,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15.0),
        labelText: 'Gender',
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );

////REGISTER BUTTON

    _addData() async {
      try {
        var response = await http.post(Uri.encodeFull(
            //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
            //laravel api

            "http://192.168.0.25:8000/api/mypets/create"), headers: {
          "Accept": "application/json"
        }, body: {
          "name": _nameController.text,
          "pet": _petController.text,
          "breed": _breedController.text,
          "age": _ageController.text,
          "sex": _sexController.text,
        });
        var status = response.body.contains('error');
        var data = json.decode(response.body);
        //    print(data);
        // print(data);
        if (status) {
          print(
              'data: data["Error: Incorrect Username or Password. Please try again."]');
          var alert = new AlertDialog(
            title: new Text("Error"),
            content: new Text("Pet Not Created"),
          );
          showDialog(context: context, child: alert);
        } else {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.setString('mypets', json.encode(data['mypets']));
          print(data['mypets']);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyPet();
              },
            ),
          );
          var alert = new AlertDialog(
            content: new Text("Pet Created"),
          );
          showDialog(context: context, child: alert);
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
      }

      setState(
        () {
          _isLoading = false;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1565c0),
        title: Text(
          'Create Pet',
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
              Padding(
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
                        _isLoading ? 'Creating Account...' : 'Create Account',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )))
            ],
          )),
    );
  }
}
