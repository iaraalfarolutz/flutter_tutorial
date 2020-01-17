import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class RoundedIconButton extends StatelessWidget {
  Widget child;
  Function onPressed;

  RoundedIconButton({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        onPressed();
      },
      child: child,
      shape: CircleBorder(),
      elevation: 6.0,
      fillColor: kFloattingIconButton,
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
    );
  }
}
