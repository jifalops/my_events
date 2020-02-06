import 'package:flutter/material.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/events.dart';
import 'package:my_events/routes.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AllEvents extends StatelessWidget {
  static final format = DateFormat("EEE. MMM d, yyyy 'at' h:mma");
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: db.event.streamAllEvents(),
      child: Consumer<Map<String, Event>>(
        builder: (context, events, child) {
          return events == null
              ? Text('No events found.')
              : Column(children: <Widget>[
                  ...events.keys.map((id) => ListTile(
                        leading: Image.network(
                            events[id].attendees[events[id].creator].photoUrl,
                            height: 48,
                            width: 48),
                        title: Text(events[id].title),
                        subtitle: Text(format.format(events[id].start)),
                        trailing: Text(events[id].attendees.length.toString()),
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.eventDetails, arguments: id),
                      ))
                ]);
        },
      ),
    );
  }
}
