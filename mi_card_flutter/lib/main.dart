import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('images/profile.jpg'),
                radius: 50.0,
              ),
              Text(
                'Iara Alfaro Lutz',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
              Text('JUNIOR DEVELOPER',
                  style: TextStyle(
                      color: Colors.teal.shade100,
                      fontSize: 20.0,
                      fontFamily: 'Source Sans Pro',
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.teal.shade900,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      title: Text(
                        '+542494240462',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro',
                            color: Colors.teal.shade900,
                            fontSize: 20.0),
                      )),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal.shade900,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      title: Center(
                        child: Text(
                          'iaraalfarolutz@gmail.com',
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              color: Colors.teal.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      )),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
