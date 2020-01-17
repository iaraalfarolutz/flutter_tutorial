import 'package:uuid/uuid.dart';

class Task {
  final String title;
  final Uuid id;
  final Uuid eventId;
  final String user;
  final bool confirmed;
  final String description;

  Task(
      {this.id,
      this.title,
      this.eventId,
      this.user,
      this.confirmed,
      this.description});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      id: json['_id'],
      eventId: json['event'],
      user: json['user'],
      description: json['description'],
      confirmed: json['confirmed'],
    );
  }
}
