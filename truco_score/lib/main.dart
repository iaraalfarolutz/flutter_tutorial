import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truco_score/truco_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truco',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Truco')),
            backgroundColor: Colors.blueAccent,
          ),
          backgroundColor: Colors.black,
          body: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int number = 2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Image.asset(
                'images/background.png',
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: DropdownButton<int>(
                  value: number,
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.blueAccent),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (int newValue) {
                    setState(() {
                      number = newValue;
                    });
                  },
                  items: <int>[2, 3].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text("Players : " + value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                color: Colors.blueAccent.shade400,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Truco(players: number)),
                  );
                },
                child: Text(
                  'START',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
