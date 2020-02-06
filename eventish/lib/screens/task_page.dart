import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TaskPage extends StatefulWidget {
  final User user;
  final Function onPush;
  TaskPage({this.user, this.onPush});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<List<Task>> futureTasks;
  @override
  void initState() {
    super.initState();
    futureTasks = WebService.getTasksByUser(widget.user.username);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FutureBuilder<List<Task>>(
          future: futureTasks,
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
                                              .title
                                              .toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: kButtonColor))),
                                ),
                                Expanded(
                                  child: Container(
                                      color: kCardColor,
                                      child: Text(snapshot.data
                                          .elementAt(index)
                                          .confirmed
                                          .toString())),
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    color: kBackColor,
                                    child: Text("EDIT"),
                                    onPressed: () {
//                                      setState(() {
//                                        widget.onPush(
//                                            event:
//                                                snapshot.data.elementAt(index),
//                                            nextPage:
//                                                TabNavigatorRoutes.editEvent);
//                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          widget.onPush(
                            nextPage: TabNavigatorRoutes.showTask,
                            task: snapshot.data.elementAt(index),
                          );
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
                child: Center(child: Text("There is no tasks yet")),
              );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
          child: FloatingActionButton(
            heroTag: "btn1",
            child: Icon(Icons.refresh),
            backgroundColor: kButtonColor,
            onPressed: () {
              setState(() {
                futureTasks = WebService.getTasksByUser(widget.user.username);
              });
            },
          ),
        )
      ],
    );
  }
}
