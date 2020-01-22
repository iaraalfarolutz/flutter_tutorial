import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  final User user;
  EventPage({this.user});
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Event list')),
    );
  }
}
