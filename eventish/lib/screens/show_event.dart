import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Location.dart';
import 'package:eventish/components/web_service.dart';

class ShowEvent extends StatefulWidget {
  final Event event;
  final Function onPush;
  ShowEvent({this.event, this.onPush});
  @override
  _ShowEventState createState() => _ShowEventState();
}

class _ShowEventState extends State<ShowEvent> {
  Future<Location> location;

  @override
  void initState() {
    super.initState();
    location = WebService.getLocationOfEvent(widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Card(
              margin: EdgeInsets.all(15.0),
              color: kCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    widget.event.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: 40.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.event.date.substring(0, 16),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.event.status,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Divider(
                    height: 30.0,
                    color: kButtonColor,
                    thickness: 2.0,
                  ),
                  FutureBuilder<Location>(
                    future: location,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.name,
                          style: TextStyle(fontSize: 20.0),
                        );
                      }
                      // By default, show a loading spinner.
                      return Text(
                        'No location provided',
                        style: TextStyle(fontSize: 20.0),
                      );
                    },
                  ),
                  Divider(
                    height: 30.0,
                    color: kButtonColor,
                    thickness: 2.0,
                  ),
                  Flexible(
                      child: ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      child: Text(
                                          widget.event.guests
                                              .elementAt(index)
                                              .username,
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              color: kButtonColor))),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemCount: widget.event.guests.length)),
                  RaisedButton(
                    color: kButtonColor,
                    child: Text('DELETE'),
                    onPressed: () {
                      setState(() {
                        WebService.deleteEvent(widget.event.id);
                        Navigator.of(context).pop();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
