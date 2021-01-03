//import 'package:flutter/foundation.dart';
//import 'package:petility/login.dart';
//import 'package:pet_rescue/uploadt.dart';

import 'package:flutter/material.dart';

import 'package:petility/settings.dart';

class LandingPage extends StatefulWidget {
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
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Settings(),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/UI.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Petility',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Caveat'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Mating Place',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Caveat'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 500));
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset('assets/images.jpg',
                                    width: 150.0, height: 150.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 500));
                              _scaffoldKey.currentState.openDrawer();
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset('assets/images.jpg',
                                    width: 150.0, height: 150.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 60, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'My Pet',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Caveat'),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Settings',
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
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 500));
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset('assets/images.jpg',
                                    width: 150.0, height: 150.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Material(
                          child: InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 500));
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80.0),
                                child: Image.asset('assets/images.jpg',
                                    width: 150.0, height: 150.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 60, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Messages',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Caveat'),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          'Mating',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Caveat'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
