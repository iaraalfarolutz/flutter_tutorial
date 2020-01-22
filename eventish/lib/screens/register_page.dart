import 'package:eventish/constants.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final User user;
  @override
  _RegisterPageState createState() => _RegisterPageState();
  RegisterPage({this.user});
}

class _RegisterPageState extends State<RegisterPage> {
  User _myUser = User();
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
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.username = text.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.firstname = text.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.lastname = text.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.email = text.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.password = text.trim();
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
              cursorColor: kButtonColor,
              onChanged: (text) {
                setState(() {
                  _myUser.phone = text.trim();
                });
              },
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Register'),
                onPressed: () {
                  setState(() {
                    postUser(_myUser).then((status) {
                      if (status == 200 || status == 201) {
                        Navigator.pop(context, _myUser.username);
                      } else
                        Fluttertoast.showToast(
                            msg: "There was an error, please try again",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            fontSize: 16.0);
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<int> postUser(User user) async {
  String url = 'http://10.0.2.2:9000/users';
  Map<String, String> headers = {"Content-type": "application/json"};
  String body = user.getUserInfo();
  final response = await http.post(url, headers: headers, body: body);
  // this API passes back the id of the new item added to the body
  return response.statusCode;
}