import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'homepage.dart';
import 'signpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Signpage(),
        initialRoute: Signpage.id,
        routes: {
          Signpage.id: (context) => Signpage(),
          //SignInScreen.id: (context) => SignInScreen(),
          HomePage.id: (context) => HomePage(),
        }
    );
  }
}
