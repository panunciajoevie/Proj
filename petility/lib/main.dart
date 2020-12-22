import 'package:petility/register.dart';
import 'package:flutter/material.dart';
import 'package:petility/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    Register.tag: (context) => Register(),
    
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