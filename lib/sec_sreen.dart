import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/detail_user.dart';
import 'package:test_flutter/main.dart';




CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
DocumentReference user1Document = usersCollection.doc('1');
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
      await FirebaseAuth.instance.signOut()
          .then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      });

    },
  ),
),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:StreamBuilder(
stream: usersCollection.snapshots(),
       builder:(context , snapshot){
  if(snapshot.hasError){
    return Center(child: Text('error'));
  }
  if(snapshot.connectionState==ConnectionState.waiting){
    return CircularProgressIndicator();
  }
  if(snapshot.hasData){
    return ListView.builder(
        itemCount: snapshot.data.docs.length,
      itemBuilder: (context , i){
return Column(
  children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailUser(
               dataUser: snapshot.data.docs[i],
              )),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          Text(snapshot.data.docs[i].data()['name']),
          Text(snapshot.data.docs[i].data()['age']),

          //Text(),
      ],
    ),
        ),
    SizedBox(
      child: Divider(
        height: 30,
        thickness: 4,
        color: Colors.black,
      ),
    )
  ],
);
      },
    );


  }
  return Text('No Data');
       }

          ) ,
        ),
      ),


    );
  }
}
