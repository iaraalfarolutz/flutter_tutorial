import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';

import '../constants.dart';

class LocationPage extends StatefulWidget {
  final Event event;
  LocationPage({this.event});
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Add Location'),
                ),
              ),
              RaisedButton(
                color: kButtonColor,
                child: Text('SAVE'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ));
  }
}
