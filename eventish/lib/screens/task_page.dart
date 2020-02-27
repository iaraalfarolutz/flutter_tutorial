import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class TaskPage extends StatefulWidget {
  final User user;
  final Function onPush;
  final Event event;
  TaskPage({this.user, this.onPush, this.event});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Future<List<Task>> futureTasks;
  bool isEvent = false;
  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      //Deberia poder agregar tasks y asignar solo a invitados
      isEvent = true;
      futureTasks = WebService.getTasksByEvent(widget.event.id);
    } else
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
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
                                      child: Text(
                                        snapshot.data.elementAt(index).confirmed
                                            ? "Confirmed"
                                            : "Waiting for confirmation",
                                        style: TextStyle(fontSize: 18.0),
                                      )),
                                ),
                                Expanded(
                                  child: Container(
                                      color: kCardColor,
                                      child: Text(
                                        snapshot.data.elementAt(index).user,
                                        style: TextStyle(fontSize: 18.0),
                                      )),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
              child: FloatingActionButton(
                heroTag: "btn1",
                child: Icon(Icons.refresh),
                backgroundColor: kButtonColor,
                onPressed: () {
                  setState(() {
                    if (widget.event != null)
                      futureTasks = WebService.getTasksByEvent(widget.event.id);
                    else
                      futureTasks =
                          WebService.getTasksByUser(widget.user.username);
                  });
                },
              ),
            ),
            Container(
              child: isEvent
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        child: Icon(Icons.add),
                        backgroundColor: kButtonColor,
                        onPressed: () {
                          widget
                              .onPush(
                                  nextPage: TabNavigatorRoutes.addTask,
                                  event: widget.event,
                                  newUser: widget.user)
                              .then((val) {
                            WebService.postTask(val);
                          });
                        },
                      ),
                    )
                  : Container(height: 0),
            )
          ],
        )
      ],
    );
  }
}
