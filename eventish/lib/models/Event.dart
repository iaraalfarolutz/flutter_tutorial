import 'package:eventish/models/User.dart';
import 'package:uuid/uuid.dart';

class Event {
  String organizer;
  String id;
  List<User> guests = new List<User>();
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

  String getInfo() {
    String guests = "[";
    if (this.guests != null) {
      for (int i = 0; i < this.guests.length; i++) {
        guests += this.guests.elementAt(i).getUserInfo() + ",";
      }
    }
    guests += "]";
    String info = "{ \"name\": \"" +
        this.name.trim() +
        "\", " +
        "\"location\": " +
        this.location.toString() +
        ", " +
        "\"guests\": " +
        guests +
        ", " +
        "\"complete\": " +
        this.complete.toString() +
        ", " +
        "\"organizer\": \"" +
        this.organizer +
        "\", " +
        "\"status\": \"" +
        this.status.trim() +
        "\" , " +
        "\"date\": \"" +
        this.date +
        "\" }";

    return info;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    var guestsFromJson = json['guests'];
    List<User> guests = guestsFromJson.cast<User>();
    return Event(
        organizer: json['organizer'],
        id: json['_id'],
        guests: guests,
        location: json['location'],
        date: json['date'],
        status: json['status'],
        complete: json['complete'],
        name: json['name']);
  }
}
