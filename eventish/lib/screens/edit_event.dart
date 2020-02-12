import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/event_form.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';

class EditEvent extends StatefulWidget {
  final Function onPush;
  final Event event;
  final User user;
  EditEvent({this.event, this.onPush, this.user});
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  Function req = (event, location, guestsList) {
    return WebService.updateEvent(event, location, guestsList);
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0A0D22),
        body: EventForm(
          onPush: widget.onPush,
          event: widget.event,
          action: "UPDATE",
          request: req,
          user: widget.user,
        ));
  }
}
