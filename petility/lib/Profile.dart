import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petility/landingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  static String tag = 'profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
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
    return Column(
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
            'User Name',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['username']}' : '',
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
            'FullName',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['fullname']}' : '',
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
            'Contact Number',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            userData != null ? '${userData['contactnumber']}' : '',
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
          alignment: Alignment.center,
          // decoration: Boxdecoration,

          child: Text(
            userData != null ? '${userData['completeaddress']}' : '',
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: 'Caveat'),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 50,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('Save'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
