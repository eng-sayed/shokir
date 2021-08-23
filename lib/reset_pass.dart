import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final resetController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: resetController,
            ),
            ElevatedButton(
                onPressed: () async {
                  await auth.sendPasswordResetEmail(
                      email: resetController.text);
                },
                child: Text('Rest'))
          ],
        ),
      ),
    );
  }
}
