import 'package:eventish/models/Event.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eventish/models/Location.dart';

class AddEvent extends StatefulWidget {
  final User user;
  AddEvent({this.user});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  Event event;
  Future<Event> myEvent;
  Location location;
  DateTime mydate;
  int guests = 1;
  ListView guestsWidgets;
  List<User> guestsList = new List<User>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    event = Event.createFromOrganizer(widget.user.username);
    event.complete = false;
    event.status = "waiting for guests to confirm";
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
                  }, currentTime: DateTime.now(), locale: LocaleType.es);
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
          child: Text('SAVE'),
          onPressed: () {
            setState(() {
              event.date = mydate.toString();
              myEvent = postEvent(event, location);
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
            onChanged: (text) {
              setState(() {
                //setchanges[index](widget, text);
              });
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: guests);
  }
}

Future<Event> postLocation(String eventId, Location location) async {
  String url = 'http://10.0.2.2:9000/events/$eventId/location';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body = location.getInfo();
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 201) {
    Fluttertoast.showToast(
        msg: "Location added!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
    return Event.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<Event> postEvent(Event event, Location location) async {
  String url = 'http://10.0.2.2:9000/events';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body = event.getInfo();
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 201) {
    Fluttertoast.showToast(
        msg: "Event added!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
    if (location != null) {
      return postLocation(
          Event.fromJson(json.decode(response.body)).id, location);
    } else {
      return Event.fromJson(json.decode(response.body));
    }
  } else {
    throw Exception('Failed to load post');
  }
}
