import 'package:flutter/foundation.dart';
import 'package:petility/login.dart';
//import 'package:pet_rescue/uploadt.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  static String tag = 'landingpage';

  var idUser, fullname, username, completeaddress, contactno;
  LandingPage(
      {Key key,
      this.idUser,
      this.fullname,
      this.username,
      this.completeaddress,
      this.contactno})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo2 = AssetImage('assets/landinglogo.png');
    var image = Image(
      image: logo2,
      width: 250,
      height: 250,
    );

    final btns = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );

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
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 24.0, left: 24.0),
        children: <Widget>[
          Container(child: image),
          SizedBox(height: 25.0),
          btns,
        ],
      )),
    );
  }
}

class MainLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/landinglogo.png');
    var image = Image(
      image: assetsImage,
      width: 250,
      height: 250,
    );
    return Container(
      child: image,
    );
  }
}
