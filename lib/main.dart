import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/register.dart';
import 'package:test_flutter/reset_pass.dart';
import 'package:test_flutter/sec_sreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      // home: Center(
      //   child: Container(
      //     child: Text('sayed'),
      //   ),
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    firebaseAuth
        .userChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecScreen()),
        );
      }
    });    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: Image.asset(
                  'images/icon.png',
                  width: 100,
                  height: 300,
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    // icon:Icon(Icons.star) ,
                    prefixIcon: Icon(Icons.person),
                    // suffixIcon: IconButton(icon: Icon(Icons.menu),
                    // onPressed: (){
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => SecScreen()),
                    //   );
                    //
                    // },),
                    // hintText: 'dddd',
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
              ElevatedButton(onPressed: ()async {

                try {
                  await firebaseAuth.signInWithEmailAndPassword(
                      email:emailController.text ,
                      password: passwordController.text
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }



                //
                // try {
                //  await firebaseAuth.signInWithEmailAndPassword(
                //       email: emailController.text,
                //       password: passwordController.text
                //   );
                //  Navigator.push(
                //    context,
                //    MaterialPageRoute(builder: (context) => SecScreen()),
                //  );
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'user-not-found') {
                //     print('No user found for that email.');
                //   } else if (e.code == 'wrong-password') {
                //     print('Wrong password provided for that user.');
                //   }
                // }
              }, child: Text('Login')),
              ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPassword()),
                );
              }, child: Text('Reset'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward_outlined,
          color: Colors.tealAccent,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
      ),
    );
  }
}
