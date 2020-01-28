import 'package:eventish/models/Event.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/Location.dart';

class AddEvent extends StatefulWidget {
  final User user;
  final Event event;
  final String action;
  final Function request;
  AddEvent(
      {this.user, this.event, @required this.action, @required this.request});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  Event event;
  Future<Event> myEvent;
  Location location;
  DateTime mydate;
  int guests;
  ListView guestsWidgets;
  List<User> guestsList = new List<User>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.event != null) {
      event = widget.event;
      guests = widget.event.guests.length > 1 ? widget.event.guests.length : 1;
      guestsList = widget.event.guests;
    } else {
      event = Event.createFromOrganizer(widget.user.username);
      event.complete = false;
      event.status = "waiting for guests to confirm";
      guests = 1;
    }
    updateGuestsWidgets(1);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationPage(
                                event: event,
                              )),
                    ).then((val) {
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
              Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Guests:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    NumberPicker.integer(
                        initialValue: guests,
                        minValue: 1,
                        maxValue: 15,
                        itemExtent: 30.0,
                        onChanged: (number) {
                          setState(() {
                            guests = number;
                            updateGuestsWidgets(guests);
                          });
                        }),
                  ]),
              Divider(
                color: kButtonColor,
                height: 4.0,
                endIndent: 15.0,
                indent: 15.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    guestsWidgets,
                  ],
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          color: kButtonColor,
          child: Text(widget.action.toUpperCase()),
          onPressed: () {
            setState(() {
              event.date = mydate.toString();
              if (widget.action == "UPDATE") {
                myEvent = widget.request(event, location, guestsList);
              } else {
                event.guests = guestsList;
                myEvent = widget.request(this.event, this.location);
              }
            });
          },
        ),
      ],
    );
  }

  void updateGuestsWidgets(int guests) {
    guestsWidgets = ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter yours guest username';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your guest\'s username',
              ),
              cursorColor: kButtonColor,
              textInputAction: TextInputAction.done,
              initialValue: guestsList.length > index
                  ? guestsList.elementAt(index).username
                  : "",
              onFieldSubmitted: (term) {
                WebService.fetchUser(term.trim()).then((result) {
                  if (result != null) {
                    guestsList.add(result);
                  }
                });
              });
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: guests);
  }
}
