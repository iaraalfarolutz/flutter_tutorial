import 'package:eventish/components/web_service.dart';
import 'package:eventish/screens/add_event.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';

class EditEvent extends StatefulWidget {
  final Event event;
  EditEvent({this.event});
  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  Function req = (event, location, guestsList) {
    return WebService.updateEvent(event, location, guestsList);
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF12173A),
        scaffoldBackgroundColor: Color(0xFF0A0D22),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Eventish')),
          ),
          body: AddEvent(
            event: widget.event,
            action: "UPDATE",
            request: req,
          )),
    );
  }
}
