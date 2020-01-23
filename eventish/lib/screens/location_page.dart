import 'package:eventish/models/Location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class LocationPage extends StatefulWidget {
  final Event event;
  LocationPage({this.event});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Location location;

  @override
  void initState() {
    location = Location.createFromOwner(widget.event.organizer);
    location.confirmed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kCardColor,
          scaffoldBackgroundColor: kBackColor,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Add Location')),
            backgroundColor: kButtonColor,
          ),
          body: ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Event name',
                ),
                cursorColor: kButtonColor,
                onChanged: (text) {
                  setState(() {
                    location.name = text;
                  });
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Latitud',
                      ),
                      cursorColor: kButtonColor,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [
                        BlacklistingTextInputFormatter(new RegExp('[\\ ]'))
                      ],
                      onChanged: (text) {
                        setState(() {
                          location.latitud = double.parse(text);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Longitud',
                      ),
                      cursorColor: kButtonColor,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [
                        BlacklistingTextInputFormatter(new RegExp('[\\ ]'))
                      ],
                      onChanged: (text) {
                        setState(() {
                          location.longitud = double.parse(text);
                        });
                      },
                    ),
                  )
                ],
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
              CheckboxListTile(
                title: Text(
                  'Confirmed: ',
                  style: TextStyle(fontSize: 20.0),
                ),
                checkColor: kButtonColor,
                activeColor: Colors.white,
                value: location.confirmed,
                onChanged: (value) {
                  setState(() {
                    location.confirmed = value;
                  });
                },
              ),
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
              RaisedButton(
                color: kButtonColor,
                child: Text('SAVE'),
                onPressed: () {
                  Navigator.pop(context, location);
                },
              )
            ],
          ),
        ));
  }
}
