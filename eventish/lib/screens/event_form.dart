import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/components/guest_list_singleton.dart';
import 'package:eventish/components/guest_list_form.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:eventish/models/Location.dart';

class EventForm extends StatefulWidget {
  final User user;
  final Event event;
  final String action;
  final Function request;
  final Function onPush;

  EventForm(
      {this.user,
      this.event,
      @required this.action,
      @required this.request,
      @required this.onPush});
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  Event event;
  Future<Event> myEvent;
  Location location;
  DateTime mydate;
  List<User> guestsList = new List<User>();
  GuestListSingleton singleton = new GuestListSingleton();

  @override
  void initState() {
    if (widget.event != null) {
      mydate = DateTime.parse(widget.event.date);
      event = widget.event;
      guestsList = widget.event.guests;
    } else {
      event = Event.createFromOrganizer(widget.user.username);
      event.complete = false;
      event.status = "waiting for guests to confirm";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event name',
                ),
                cursorColor: kButtonColor,
                initialValue: event.name,
                onChanged: (text) {
                  setState(() {
                    event.name = text;
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                color: kCardColor,
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5, 22, 15),
                      maxTime: DateTime(2019, 6, 7, 22, 1),
                      onChanged: (date) {}, onConfirm: (date) {
                    setState(() {
                      mydate = date;
                    });
                  },
                      currentTime: event.date != null
                          ? DateTime.parse(event.date)
                          : DateTime.now(),
                      locale: LocaleType.es);
                },
                child: Text(
                  'DATE',
                  style: TextStyle(color: kButtonColor),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                color: kCardColor,
                child: Text(
                  'LOCATION',
                  style: TextStyle(color: kButtonColor),
                ),
                onPressed: () {
                  setState(() {
                    widget
                        .onPush(
                            event: event, nextPage: TabNavigatorRoutes.location)
                        .then((val) {
                      location = val;
                    });
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                color: kButtonColor,
                height: 4.0,
                endIndent: 15.0,
                indent: 15.0,
                thickness: 2.0,
              ),
              GuestList(
                initialCount: (event.guests == null || event.guests.isEmpty)
                    ? 1
                    : event.guests.length,
                users: event.guests,
              ),
            ],
          ),
        ),
        RaisedButton(
          color: kButtonColor,
          child: Text(widget.action.toUpperCase()),
          onPressed: () {
            guestsList = singleton.guests;
            event.date = mydate == null ? event.date : mydate.toString();
            if (widget.action == "UPDATE") {
              myEvent = widget.request(event, location, guestsList);
            } else {
              event.guests = guestsList;
              myEvent = widget.request(this.event, this.location);
            }
          },
        ),
      ],
    );
  }
}
