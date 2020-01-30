import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eventish/components/web_service.dart';

class RegisterPage extends StatefulWidget {
  final User user;
  @override
  _RegisterPageState createState() => _RegisterPageState();
  RegisterPage({this.user});
}

class _RegisterPageState extends State<RegisterPage> {
  static User _myUser = User();
  final _formKey = GlobalKey<FormState>();

  final List<String> entries = <String>[
    'Username',
    'First name',
    'Last name',
    'Email',
    'Password',
    'Phone'
  ];
  final List<Function> setchanges = <Function>[
    (text) {
      _myUser.username = text.trim();
    },
    (text) {
      _myUser.firstname = text;
    },
    (text) {
      _myUser.lastname = text;
    },
    (text) {
      _myUser.email = text.trim();
    },
    (text) {
      _myUser.password = text.trim();
    },
    (text) {
      _myUser.phone = text.trim();
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackColor,
      appBar: AppBar(
        backgroundColor: kButtonColor,
        title: Center(
          child: Text(
            'Eventish',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
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
                            setchanges[index](text);
                          });
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider()),
              ),
              Container(
                child: RaisedButton(
                    color: kButtonColor,
                    child: Text('REGISTER'),
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate()) {
                          WebService.postUser(_myUser).then((status) {
                            if (status == 201) {
                              Navigator.of(context).pop(_myUser.username);
                              Fluttertoast.showToast(
                                  msg: "User registrated correctly",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1,
                                  fontSize: 16.0);
                            } else
                              Fluttertoast.showToast(
                                  msg: "There was an error, please try again",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1,
                                  fontSize: 16.0);
                          });
                        }
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
