import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id='homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Details"),
        backgroundColor: Colors.teal[300],
        //automaticallyImplyLeading: false,
        actions: [
          IconButton (
            icon: Icon(Icons.logout),
            onPressed: () async{
              try {
                await FirebaseAuth.instance.signOut();
                errorMessage = '';
              } on FirebaseAuthException catch (error) {
                errorMessage = error.message!;
              }
              Navigator.pop(context);
              setState(() {});
              /** Do something */
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is the environment for Food Analyzer')
          ],
        ),
      ),
    );
  }
}
