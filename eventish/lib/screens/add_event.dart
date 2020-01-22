import 'package:eventish/models/Event.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class AddEvent extends StatefulWidget {
  final User user;
  AddEvent({this.user});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  Event event;
  DateTime mydate;
  int guests = 1;

  @override
  void initState() {
    event = Event.createFromOrganizer(widget.user.username);
    event.complete = false;
    event.status = "waiting for guests to confirm";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        RaisedButton(
          color: kButtonColor,
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
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 20.0,
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
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              NumberPicker.integer(
                  initialValue: guests,
                  minValue: 1,
                  maxValue: 15,
                  itemExtent: 30.0,
                  onChanged: (number) {
                    setState(() {
                      guests = number;
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
          height: 20.0,
        ),
        RaisedButton(
          color: kButtonColor,
          child: Text('Add Location'),
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationPage(
                          event: event,
                        )),
              ).then((val) {
                event.location = val;
              });
            });
          },
        ),
      ],
    );
  }
}
