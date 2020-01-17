import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:bmi_calculator/input_page.dart';

class ResultsPage extends StatelessWidget {
  String bmi;
  String result;
  String description;

  ResultsPage(
      {@required this.bmi, @required this.result, @required this.description});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(15.0),
                child: Text('Your results',
                    style: kLargeButtonStyle.copyWith(
                      fontSize: 50.0,
                    )),
              ),
            ),
            Expanded(
              flex: 5,
              child: ReusableCard(
                colour: kActiveCardColor,
                cardChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      result.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xFF24D876),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      bmi,
                      style: kNumberStyle.copyWith(fontSize: 100.0),
                    ),
                    Text(
                      result + ' BMI range:',
                      style: kTextStyle.copyWith(fontSize: 22.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ],
                ),
              ),
            ),
            LargeBottomButton(
              title: 'RECALCULATE BMI',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
