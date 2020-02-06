import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_events/controllers/auth_controller.dart';

const appName = 'My Events';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: auth.onAuthStateChanged,
      child: MaterialApp(
        title: appName,
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Due to some behind the scenes voodoo, by reading the value of a `Provider`
    /// here, Flutter will know to call this build method any time the provided
    /// `FirebaseUser` changes.
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: ListView(
        children: <Widget>[
          /// Dart 2.4ish added a few "UI as code" features, one of which is to
          /// allow `if` and `else` inside of list literals (`[]`). Before this,
          /// an inline-if thing called a ternary was required.
          /// ```
          /// user == null ? 'sign in button' : 'name and photo';
          /// ```
          if (user == null)
            RaisedButton(
              child: Text('Sign In with Google'),
              onPressed: signInWithGoogle,
            )
          else
            Column(
              children: <Widget>[
                Image.network(user.photoUrl),
                Text(user.displayName),
                FlatButton(
                  child: Text('Sign out'),
                  onPressed: signOut,
                )
              ],
            ),
        ],
      ),
    );
  }
}
