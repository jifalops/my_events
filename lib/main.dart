import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/profiles.dart';
import 'package:my_events/routes.dart';
import 'package:my_events/views/components/event_form.dart';
import 'package:my_events/views/components/profile_events_view.dart';
import 'package:my_events/views/components/users_list.dart';
import 'package:my_events/views/screens/event_details_screen.dart';
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
        routes: {
          Routes.home: (context) => HomeScreen(),
          Routes.eventDetails: (context) =>
              EventDetailsScreen(ModalRoute.of(context).settings.arguments),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
          SizedBox(height: 48),

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
                ),
                Container(
                  padding: EdgeInsets.all(48),
                  child: EventForm(),
                ),
                Text('All users\' events',
                    style: Theme.of(context).textTheme.headline),
                UsersList(),
              ],
            ),
        ],
      ),
    );
  }
}
