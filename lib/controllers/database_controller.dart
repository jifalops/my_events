import 'package:my_events/controllers/event_controller.dart';
import 'package:my_events/controllers/profile_controller.dart';
import 'package:my_events/firebase_helpers/realtime_database.dart';

final db = DatabaseController._();

class DatabaseController extends RealtimeDatabase {
  DatabaseController._();

  final profile = ProfileController();
  final event = EventController();
}
