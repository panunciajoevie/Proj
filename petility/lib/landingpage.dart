import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:petility/register.dart';
//import 'package:pet_rescue/uploadt.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class UserProfile extends StatefulWidget {
  static String tag = 'landingpage';
  /* var id, fullname, username, completeaddress, contactnumber;
  UserProfile(this.id, this.fullname, this.username, this.completeaddress,
      this.contactnumber);
  
  factory UserProfile.fromJson(dynamic json) {
    return UserProfile(
        json['id'] as int,
        json['fullname'] as String,
        json['username'] as String,
        json['completeaddress'] as String,
        json['contactnumber'] as String);
  }
  */

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  /*   String toString() {
    return '{ ${this.id}, ${this.fullname}, ${this.username}, ${this.completeaddress}, ${this.contactnumber} }';
  }
  */

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff1565c0),
        title: Text(
          'Welcome!',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Varela',
              fontSize: 25.0),
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ////////////// 1st card///////////
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ////////////  first name ////////////
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Username',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                    userData != null
                                        ? '${userData['username']}'
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ////////////// last name //////////////
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Full Name',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                    userData != null
                                        ? '${userData['fullname']}'
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ////////////// last name //////////////
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Complete Address',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                    userData != null
                                        ? '${userData['completeaddress']}'
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ////////////// last name //////////////
                        Card(
                          elevation: 4.0,
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.account_circle,
                                        color: Color(0xFFFF835F),
                                      ),
                                    ),
                                    Text(
                                      'Contact Number',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 17.0,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text(
                                    userData != null
                                        ? '${userData['contactnumber']}'
                                        : '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      /////////// Edit Button /////////////
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 10),
                            child: Text(
                              'Edit',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Color(0xFFFF835F),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          onPressed: () {
                            /*  Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Edit()));
                          */
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
