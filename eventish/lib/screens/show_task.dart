import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/constants.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';

class ShowTask extends StatefulWidget {
  final Task task;
  final Function onPush;
  ShowTask({this.task, this.onPush});
  @override
  _ShowTaskState createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  Future<Task> completeTask;
  Event event;
  String title;
  @override
  void initState() {
    super.initState();
    completeTask = WebService.fetchTask(widget.task.id);
    WebService.fetchEvent(widget.task.eventId)
        .then((valueEvent) => event = valueEvent);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Task>(
      future: completeTask,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                  color: kCardColor,
                  margin: EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          snapshot.data.title,
                          style: TextStyle(
                              fontSize: 40.0,
                              letterSpacing: 2.0,
                              color: kButtonColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Divider(
                          color: kButtonColor,
                          height: 15.0,
                          thickness: 2.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          snapshot.data.description,
                          style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Event: " + event.name,
                          style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              RaisedButton(
                color: kButtonColor,
                child: Text('UPDATE'),
                onPressed: () {
                  User user;
                  WebService.fetchUser(widget.task.user).then((val) {
                    user = val;
                    widget
                        .onPush(
                            nextPage: TabNavigatorRoutes.addTask, newUser: user)
                        .then((val) {
                      widget.task.title = val.title;
                      widget.task.description = val.description;
                      WebService.updateTask(widget.task.id, widget.task);
                    });
                  });
                },
              )
            ],
          );
        }
        // By default, show a loading spinner.
        return Text(
          'Error while loading the data of the task',
          style: TextStyle(fontSize: 20.0),
        );
      },
    );
  }
}
