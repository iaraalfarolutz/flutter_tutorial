import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  @override
  int number;
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
                        builder: (context) => new Truco(players: number)),
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

class Truco extends StatefulWidget {
  int players = 2;
  Truco({Key key, this.players}) : super(key: key);
  @override
  _TrucoState createState() => _TrucoState();
}

class _TrucoState extends State<Truco> {
  int t1 = 0;
  int t2 = 0;
  int t3 = 0;
  List<Widget> t1_score = [];
  List<Widget> t2_score = [];
  List<Widget> t3_score = [];
  List<Widget> players_board = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truco',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Truco')),
          backgroundColor: Colors.blueAccent,
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Nosotros",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: t1_score,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        heroTag: "Nosotros",
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          setState(() {
                            t1++;
                            redrawScore(t1_score, t1);
                            checkForWinner(t1, "Nosotros");
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Ellos",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: t2_score,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        heroTag: "Ellos",
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          setState(() {
                            t2++;
                            redrawScore(t2_score, t2);
                            checkForWinner(t2, "Ellos");
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              if (widget.players == 3)
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Terceros",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: t3_score,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          heroTag: "Terceros",
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            setState(() {
                              t3++;
                              redrawScore(t3_score, t3);
                              checkForWinner(t3, "Terceros");
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
            ]),
      ),
    );
  }

  void redrawScore(List<Widget> score_list, int score) {
    String image_title = 'images/$score.png';
    if (score < 6) {
      score_list.clear();
    } else {
      int aux = score % 5;
      int level = (score / 5).ceil();
      if (level > 3) level++;
      if (aux == 0) aux = 5;
      image_title = 'images/$aux.png';

      if (score_list.length > level - 1 && score != 16)
        score_list.removeAt(level - 1);
    }

    Widget container = Expanded(
      child: Container(
        height: 50.0,
        width: 50.0,
        child: Image.asset(image_title),
        margin: const EdgeInsets.all(3.0),
      ),
    );

    score_list.add(container);

    if (score == 15) {
      Widget divider = new SizedBox(
        height: 30.0,
        width: 75.0,
        child: Divider(
          color: Colors.teal,
        ),
      );
      score_list.add(divider);
    }
  }

  void checkForWinner(int score, String winner) {
    if (score > 30) {
      Alert(
        context: context,
        title: '$winner WON!',
        desc: "Press clear to restart.",
        buttons: [
          DialogButton(
            child: Text(
              "CLEAR",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      clean_board();
    }
  }

  void clean_board() {
    t1 = 0;
    t2 = 0;
    t3 = 0;
    t1_score.clear();
    t2_score.clear();
    t3_score.clear();
  }
}
