import 'package:petility/landingpage.dart';
import 'package:petility/register.dart';
import 'package:flutter/material.dart';
import 'package:petility/login.dart';
import 'package:petility/settings.dart';

import 'Profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    Register.tag: (context) => Register(),
    Settings.tag: (context) => Settings(),
    LandingPage.tag: (context) => LandingPage(),
    Profile.tag: (context) => Profile(),
    
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petility',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Login(),
    );
  }
}
