import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eventish/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Eventish());
  }
}

class Eventish extends StatefulWidget {
  @override
  _EventishState createState() => _EventishState();
}

class _EventishState extends State<Eventish> {
  Future<User> user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              child: Text('Press it'),
              onPressed: () {
                setState(() {
                  user = fetchUser();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<User>(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.username);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<User> fetchUser() async {
  final response = await http.get('http://127.0.0.1:9000/users/iara');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
