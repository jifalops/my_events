import 'package:flutter/material.dart';
import 'package:my_events/controllers/auth_controller.dart';

const appName = 'My Events';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('Sign In with Google'),
            onPressed: signInWithGoogle,
          ),
        ],
      ),
    );
  }
}
