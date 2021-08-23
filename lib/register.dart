import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final ageController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                // icon:Icon(Icons.star) ,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name'),
            ),TextField(
              controller: ageController,
              decoration: InputDecoration(
                // icon:Icon(Icons.star) ,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Age'),
            ),TextField(
              controller: idController,
              decoration: InputDecoration(
                // icon:Icon(Icons.star) ,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'National Id'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                // icon:Icon(Icons.star) ,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                // icon:Icon(Icons.star) ,
                  prefixIcon: Icon(Icons.password),
                  // suffixIcon: IconButton(icon: Icon(Icons.menu),
                  // onPressed: (){
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => SecScreen()),
                  //   );
                  //
                  // },),
                  // hintText: 'dddd',
                  labelText: 'Password'),
            ),
            ElevatedButton(
                onPressed: ()async {

              try {
                 await auth.createUserWithEmailAndPassword(
                    email:emailController.text ,
                    password:passwordController.text
                ).then((value) {
                    firestore.collection('users').
                   doc(value.user.uid)
                       .set({
                     'name' :nameController.text,
                     'age': ageController.text,
                     'id': idController.text,
                     'email':emailController.text,
                     'image' :'.'
                   });
                 });
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            }, child: Text('Register'))
          ],
        ) ,
      ),

    );
  }
}
