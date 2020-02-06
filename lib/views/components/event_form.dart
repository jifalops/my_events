import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_events/controllers/auth_controller.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
