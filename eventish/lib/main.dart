import 'package:eventish/constants.dart';
import 'package:eventish/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eventish/models/User.dart';
import 'components/bottom_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF12173A),
        scaffoldBackgroundColor: Color(0xFF0A0D22),
      ),
      home: Eventish(),
      initialRoute: '/0',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/0': (context) => Eventish(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/1': (context) => FirstPage(),
      },
    );
  }
}

class Eventish extends StatefulWidget {
  @override
  _EventishState createState() => _EventishState();
}

class _EventishState extends State<Eventish> {
  int _selectedIndex = 0;

  Future<User> user;
  Future<String> message;

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Color(0xFF12173A),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  cursorColor: kButtonColor,
                  controller: myController,
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Get user'),
                onPressed: () {
                  setState(() {
                    user = fetchUser(myController.text);
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.getUserInfo());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container();
                },
              ),
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Post User'),
                onPressed: () {
                  setState(() {
                    message = postUser("Yaima");
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: message,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container();
                },
              ),
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Update User'),
                onPressed: () {
                  setState(() {
                    user = updateUser("Yaima");
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.getUserInfo());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container();
                },
              ),
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Delete User'),
                onPressed: () {
                  setState(() {
                    user = deleteUser("Yaima");
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.getUserInfo());
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<User> fetchUser(String username) async {
  final response = await http.get('http://10.0.2.2:9000/users/$username');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<String> postUser(String username) async {
  String url = 'http://10.0.2.2:9000/users';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body =
      '{"username": "Yaima", "lastname": "Alfaro", "firstName": "Yaima", "email": "iaraalfarolutz@gmail.com", "password": "password", "phone": "+542494240462"}';
  final response = await http.post(url, headers: headers, body: body);
  int statusCode = response.statusCode;
  // this API passes back the id of the new item added to the body
  String result = response.body;
  return result;
}

Future<User> updateUser(String username) async {
  String url = 'http://10.0.2.2:9000/users/$username';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body = '{"lastName": "ALFARITO", "firstName": "YAIMITA"}';
  final response = await http.put(url, headers: headers, body: body);
  // this API passes back the id of the new item added to the body
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<User> deleteUser(String username) async {
  String url = 'http://10.0.2.2:9000/users/$username';
  final response = await http.delete(url);
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
