import 'package:flutter/material.dart';
import 'package:my_events/controllers/database_controller.dart';
import 'package:my_events/models/profiles.dart';
import 'package:my_events/views/components/profile_events_view.dart';
import 'package:provider/provider.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: db.profile.streamAllProfiles(),
      child: Consumer<Map<String, Profile>>(
        builder: (context, profiles, child) {
          return profiles == null
              ? Text('No profiles found.')
              : Column(children: <Widget>[
                  ...profiles.keys.map((id) => Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.network(profiles[id].photoUrl,
                                  height: 48, width: 48),
                              SizedBox(width: 16),
                              Text("${profiles[id].displayName}'s Events")
                            ],
                          ),
                          ProfileEventsView(profiles[id].events)
                        ],
                      ))
                ]);
        },
      ),
    );
  }
}
