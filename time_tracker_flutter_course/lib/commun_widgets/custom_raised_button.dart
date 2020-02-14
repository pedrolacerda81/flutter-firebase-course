import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;
  final Color splashColor;

  CustomRaisedButton({
    this.child,
    this.color,
    this.onPressed,
    this.splashColor,
    this.borderRadius: 8.0,
    this.height: 50.0,
  }) : assert(borderRadius != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: RaisedButton(
        splashColor: splashColor,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
