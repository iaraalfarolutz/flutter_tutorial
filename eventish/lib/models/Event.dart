import 'package:eventish/models/User.dart';

class Event {
  String organizer;
  String id;
  List<User> guests = new List<User>();
  String location;
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
    if (this.guests != null && this.guests.length > 1) {
      for (int i = 0; i < this.guests.length - 1; i++) {
        guests += this.guests.elementAt(i).getUserInfo() + ",";
      }
      guests += this.guests.elementAt(this.guests.length - 1).getUserInfo();
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

  String getGuests() {
    String guests = "[";
    if (this.guests != null && this.guests.length > 1) {
      for (int i = 0; i < this.guests.length - 1; i++) {
        guests += this.guests.elementAt(i).username + ",";
      }
    }
    guests += this.guests.elementAt(this.guests.length - 1).username + "]";
    return guests;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    List guestsFromJson = json['guests'];
    List<User> guests = new List<User>();
    for (int i = 0; i < guestsFromJson.length; i++) {
      guests.add(User.fromJson(guestsFromJson.elementAt(i)));
    }
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
