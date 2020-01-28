import 'package:flutter/material.dart';

import 'package:eventish/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/User.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile({this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String username;
  Future<User> user;
  Future<String> message;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    username = widget.user.username;
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
                    user = WebService.updateUser(username, widget.user);
                  }
                });
              },
            ),
            RaisedButton(
              color: kButtonColor,
              child: Text('Delete User'),
              onPressed: () {
                setState(() {
                  user = WebService.deleteUser(widget.user.username);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
