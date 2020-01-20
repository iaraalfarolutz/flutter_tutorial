import 'package:eventish/models/User.dart';
import 'package:uuid/uuid.dart';

class Event {
  final String organizer;
  final Uuid id;
  List<User> guests;
  final Uuid location;
  final String date;
  final String status;
  final bool complete;
  final String name;
  Event(
      {this.id,
      this.organizer,
      this.guests,
      this.location,
      this.date,
      this.status,
      this.complete,
      this.name});

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
