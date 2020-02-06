import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_events/controllers/database_controller.dart';
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
              ],
            ),
        ],
      ),
    );
  }
}

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final title = TextEditingController();
  final start = TextEditingController();
  final format = DateFormat("EEE. MMM d, yyyy 'at' h:mma");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: title,
          decoration: InputDecoration(labelText: 'Event title'),
        ),
        DateTimeField(
          controller: start,
          decoration: InputDecoration(labelText: 'Start time'),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                return DateTimeField.combine(date, time);
              }
            }
            return currentValue;
          },
        ),
        SizedBox(height: 24),
        RaisedButton(
          child: Text('Create event'),
          onPressed: () async {
            final time = DateTimeField.tryParse(start.text, format);
            if (title.text.isNotEmpty && time != null) {
              print('Creating "${title.text}" at $time');
              final id = await db.event.create(
                  Provider.of<FirebaseUser>(context, listen: false),
                  title.text,
                  time);
              print('Event $id created.');
              setState(() {
                title.clear();
                start.clear();
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Event created!')));
            } else {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Invalid event')));
            }
          },
        )
      ],
    );
  }
}
