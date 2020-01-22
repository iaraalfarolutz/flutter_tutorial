import 'package:flutter/material.dart';

import 'package:eventish/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eventish/models/User.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile({this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future<User> user;
  Future<String> message;

  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  final List<String> entries = <String>[
    'Username',
    'First name',
    'Last name',
    'Email',
    'Password',
    'Phone'
  ];
  final List<Function> setchanges = <Function>[
    (widget, text) {
      widget.user.username = text.trim();
    },
    (widget, text) {
      widget.user.firstname = text;
    },
    (widget, text) {
      widget.user.lastname = text;
    },
    (widget, text) {
      widget.user.email = text.trim();
    },
    (widget, text) {
      widget.user.password = text.trim();
    },
    (widget, text) {
      widget.user.phone = text.trim();
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your ${entries[index]}';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: entries[index],
                      ),
                      cursorColor: kButtonColor,
                      onChanged: (text) {
                        setState(() {
                          setchanges[index](widget, text);
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider()),
            ),
            RaisedButton(
              color: kButtonColor,
              child: Text('Update User'),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    user = updateUser(widget.user);
                  }
                });
              },
            ),
            RaisedButton(
              color: kButtonColor,
              child: Text('Delete User'),
              onPressed: () {
                setState(() {
                  user = deleteUser(widget.user.username);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<User> updateUser(User user) async {
  String username = user.username;
  String url = 'http://10.0.2.2:9000/users/$username';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body = user.getUserInfo();
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
    Fluttertoast.showToast(
        msg: "User deleted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
    return User.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
