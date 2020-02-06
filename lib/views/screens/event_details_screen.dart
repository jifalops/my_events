import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/events.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen(this.id);

  final String id;

  static final format = DateFormat("EEEE MMMM d, yyyy 'at' h:mm a");

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Event Details')),
        body: StreamProvider.value(
          value: db.event.stream(id),
          child: Consumer<Event>(
            builder: (context, event, child) {
              return event == null
                  ? Text('Event not found.')
                  : Column(
                      children: <Widget>[
                        SizedBox(height: 24),
                        Text('${event.title}',
                            style: Theme.of(context).textTheme.display1),
                        SizedBox(height: 24),
                        Text(format.format(event.start),
                            style: Theme.of(context).textTheme.title),
                        SizedBox(height: 24),
                        Text(
                            'Created by ${event.attendees[event.creator].displayName}'),
                        SizedBox(height: 24),
                        if (user !=
                            null /*&& !event.attendees.containsKey(user.uid)*/)
                          RaisedButton(
                              child: Text('JOIN EVENT'),
                              onPressed: () => db.event.join(event, user)),
                        SizedBox(height: 24),
                        Text('Attendees'),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              ...event.attendees.keys.map((id) => ListTile(
                                    leading: Image.network(
                                        event.attendees[id].photoUrl),
                                    title:
                                        Text(event.attendees[id].displayName),
                                    trailing: Text(timeago
                                        .format(event.attendees[id].joined)),
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
            },
          ),
        ));
  }
}
