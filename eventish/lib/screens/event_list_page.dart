import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/components/web_service.dart';

class EventListPage extends StatefulWidget {
  final User user;
  final Function onPush;
  EventListPage({this.user, this.onPush});

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = WebService.getEventsByOrganizer(widget.user.username);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FutureBuilder<List<Event>>(
          future: futureEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Flexible(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          color: kCardColor,
                          margin: EdgeInsets.all(5.0),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      child: Text(
                                          snapshot.data
                                              .elementAt(index)
                                              .name
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: kButtonColor))),
                                ),
                                Expanded(
                                  child: Container(
                                      color: kCardColor,
                                      child: Text(
                                          snapshot.data.elementAt(index).date)),
                                ),
                                Expanded(
                                  child: Container(
                                      color: kCardColor,
                                      child: Text(snapshot.data
                                          .elementAt(index)
                                          .status)),
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    color: kBackColor,
                                    child: Text("EDIT"),
                                    onPressed: () {
                                      setState(() {
                                        widget.onPush(
                                            event:
                                                snapshot.data.elementAt(index),
                                            newUser: widget.user,
                                            nextPage:
                                                TabNavigatorRoutes.editEvent);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          widget.onPush(
                              nextPage: TabNavigatorRoutes.showEvent,
                              event: snapshot.data.elementAt(index));
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: snapshot.data.length),
              );
            } else
              return Expanded(
                flex: 6,
                child: Center(child: Text("There is no events yet")),
              );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
          child: FloatingActionButton(
            child: Icon(Icons.refresh),
            backgroundColor: kButtonColor,
            onPressed: () {
              setState(() {
                futureEvents =
                    WebService.getEventsByOrganizer(widget.user.username);
              });
            },
          ),
        )
      ],
    );
  }
}
