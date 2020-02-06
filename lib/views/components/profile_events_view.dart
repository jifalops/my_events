import 'package:flutter/material.dart';
import 'package:my_events/models/profiles.dart';
import 'package:intl/intl.dart';
import 'package:my_events/routes.dart';

class ProfileEventsView extends StatelessWidget {
  ProfileEventsView(this.events);
  final Map<String, ProfileEvent> events;
  static final format = DateFormat('MMM d, h:mm a');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...events.keys.map((id) => ListTile(
              title: Text(events[id].title),
              trailing: Text(format.format(events[id].start)),
              onTap: () => Navigator.of(context)
                  .pushNamed(Routes.eventDetails, arguments: id),
            ))
      ],
    );
  }
}
