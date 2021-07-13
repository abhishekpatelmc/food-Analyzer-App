import 'package:flutter/material.dart';

void main() => runApp((MyApp()));
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('FOOD ANALYZER'),
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
