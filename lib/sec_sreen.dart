import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/main.dart';

class SecScreen extends StatefulWidget {

  @override
  _SecScreenState createState() => _SecScreenState();
}

class _SecScreenState extends State<SecScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar (
  leading: IconButton(
    icon: Icon(Icons.logout),
    onPressed: ()async{
      await FirebaseAuth.instance.signOut().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      });

    },
  ),
),


    );
  }
}
