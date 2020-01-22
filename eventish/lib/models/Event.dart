import 'package:eventish/models/User.dart';
import 'package:uuid/uuid.dart';

class Event {
  String organizer;
  Uuid id;
  List<User> guests;
  Uuid location;
  String date;
  String status;
  bool complete;
  String name;
  Event(
      {this.id,
      this.organizer,
      this.guests,
      this.location,
      this.date,
      this.status,
      this.complete,
      this.name});

  factory Event.createFromOrganizer(String organizer) {
    return Event(organizer: organizer);
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        organizer: json['organizer'],
        id: json['_id'],
        guests: json['guests'],
        location: json['location'],
        date: json['date'],
        status: json['status'],
        complete: json['complete'],
        name: json['name']);
  }
}
