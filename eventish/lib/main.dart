import 'package:eventish/constants.dart';
import 'package:eventish/screens/first_page.dart';
import 'package:eventish/screens/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kCardColor,
          scaffoldBackgroundColor: kBackColor,
        ),
        home: Eventish(username: ""));
  }
}

class Eventish extends StatefulWidget {
  final String username;

  Eventish({this.username});
  @override
  _EventishState createState() => _EventishState();
}

class _EventishState extends State<Eventish> {
  Future<User> user;
  User _myUser;
  String password;
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Center(
              child: Text(
                'Eventish',
                style: TextStyle(
                    color: kButtonColor,
                    fontFamily: 'Pacifico',
                    fontSize: 100.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: kCardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      username = text;
                    });
                  },
                  initialValue: widget.username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  cursorColor: kButtonColor,
                ),
              ),
            ),
            Container(
              color: kCardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (text) {
                    password = text;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  cursorColor: kButtonColor,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: RaisedButton(
                color: kButtonColor,
                child: Text('Sign in'),
                onPressed: () {
                  setState(() {
                    WebService.fetchUser(username.trim()).then((result) {
                      _myUser = result;
                      if (password != null) {
                        if (password == _myUser.password) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FirstPage(user: _myUser)));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Wrong password, please correct",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              fontSize: 16.0);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter your password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            fontSize: 16.0);
                      }
                    });
                  });
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              textBaseline: TextBaseline.ideographic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Text('If you dont have an account please,',
                    style: TextStyle(
                      fontSize: 15.0,
                    )),
                Container(
                  child: RaisedButton(
                    color: kBackColor,
                    child: Text(
                      'Sign up!',
                      style: TextStyle(color: kButtonColor, fontSize: 20.0),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        ).then((val) {
                          username = val;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
