import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petility/landingpage.dart';
import 'package:petility/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdatePet extends StatefulWidget {
  static String tag = 'profile';

  @override
  _UpdatePetState createState() => _UpdatePetState();
}

class _UpdatePetState extends State<UpdatePet> {
  var _ageController = new TextEditingController();

  bool _isLoading = false;

  var userData;

  @override
  void initState() {
    _getUserInfo();

    super.initState();
  }

  getUpdate(String age) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var response = await http.put(
        Uri.encodeFull(
            //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
            //laravel api

            "http://192.168.0.25:8000/api/mypets/update/${userData['id']}"),
        headers: {"Accept": "application/json"},
        body: {
          "age": _ageController.text,
        },
      );

      var status = response.body.contains('Fail');
      var data = json.decode(response.body);
      print(data['user']);
      print(data);
      if (status) {
        print('update fail');
        var alert = new AlertDialog(
          title: new Text("Update Fail"),
        );
        showDialog(context: context, child: alert);
      } else {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('mypets', json.encode(data['mypets']));
        localStorage.reload();

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

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('mypets');
    var user = json.decode(userJson);

    setState(() {
      userData = user;

      print(userData);
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        body: Container(
          child: profileView(context),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/UI.jpg"),
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }

  Widget profileView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  height: 40,
                  width: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Profiles details',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Caveat'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/petilityicon.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    height: 40,
                    width: 35,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
            child: Text(
              'Pet Name:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            width: 500.0,
            child: Text(
              userData != null ? '${userData['name']}' : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
            child: Text(
              'Pet',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            width: 500.0,
            child: Text(
              userData != null ? '${userData['pet']}' : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
            child: Text(
              'Breed',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            width: 500.0,
            child: Text(
              userData != null ? '${userData['breed']}' : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 5.0),
            child: Text(
              'Complete Address',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            alignment: Alignment.center,
            width: 500.0,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat'),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: userData != null ? '${userData['age']}' : '',
                hintStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Caveat'),
              ),
              controller: _ageController,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      _isLoading ? 'Saving...' : 'Save',
                    ),
                    onPressed: () {
                      print(
                          "http://192.168.0.25:8000/api/mypets/update/${userData['id']}");
                      getUpdate(_ageController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
