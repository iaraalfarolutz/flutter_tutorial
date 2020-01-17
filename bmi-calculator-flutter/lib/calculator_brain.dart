import 'dart:math';

class CalculatorBrain {
  int height;
  int weight;
  double _bmi;
  CalculatorBrain({this.weight, this.height});

  String calculateIBM() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25)
      return "Overweight";
    else {
      if (_bmi > 18.5)
        return "Normal";
      else
        return "Underweight";
    }
  }

  String getDescription() {
    if (_bmi >= 25)
      return "You have a higher than normal body weight. Try to excercise more!";
    else {
      if (_bmi > 18.5)
        return "You have a normal body weight. Good job!";
      else
        return "You have a lower than normal body weight. Try to eat a bit more!";
    }
  }
}
