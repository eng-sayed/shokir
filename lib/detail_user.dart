import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailUser extends StatefulWidget {
 DocumentSnapshot dataUser ;
DetailUser({this.dataUser});
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.dataUser.data()['name']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.dataUser.data()['age']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.dataUser.data()['email']),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.dataUser.data()['id']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
