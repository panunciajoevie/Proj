import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petility/landingpage.dart';
import 'package:petility/updatePet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'createPet.dart';

class MyPet extends StatefulWidget {
  static String tag = 'landingpage';

  /* var idUser, fullname, username, completeaddress, contactno;
  LandingPage(
      {Key key,
      this.idUser,
      this.fullname,
      this.username,
      this.completeaddress,
      this.contactno})
      : super(key: key);
  */
  @override
  _MyPetState createState() => _MyPetState();
}

class _MyPetState extends State<MyPet> {
  var _nameController = new TextEditingController();
  var _petController = new TextEditingController();
  var _breedController = new TextEditingController();
  var _ageController = new TextEditingController();
  var _sexController = new TextEditingController();

  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  getDelete() async {
    try {
      var response = await http.delete(
        Uri.encodeFull(
            //  "https://petility.000webhostapp.com/Login.php?PSEUDO=${pseudo}"),
            //laravel api

            "http://192.168.0.25:8000/api/mypets/delete/${userData['id']}"),
        headers: {"Accept": "application/json"},
      );

      var status = response.body.contains('Fail');
      var data = json.decode(response.body);
      print(data['user']);
      print(data);
      if (status) {
        print('delete fail');
      } else {
        print(data['user']);
      }
    } catch (e) {
      print('connection Error');
    }
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.reload();
    var userJson = localStorage.getString('mypets');
    print(userJson);
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      print(userData);
    });
  }

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LandingPage();
                              },
                            ),
                          );
                        },
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 24,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CreatePet();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return UpdatePet();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.black54,
                        ),
                        onPressed: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          localStorage.remove('mypets');
                          getDelete();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyPet();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        'My Pets',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Caveat'),
                      ),
                    ),
                  ],
                ),
              ),
              mypet(),
            ],
          ),
        ),
      ),
    );
  }

  Widget mypet() {
    return Column(
      children: <Widget>[
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
            'Name',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['name']}' : '',
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
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['pet']}' : '',
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
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['breed']}' : '',
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
            'Age',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          // decoration: Boxdecoration,

          child: Text(
            userData != null ? '${userData['age']}' : '',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
      ],
    );
  }
}
