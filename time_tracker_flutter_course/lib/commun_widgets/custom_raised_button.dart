import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;

  CustomRaisedButton({
    this.child,
    this.color,
    this.onPressed,
    this.borderRadius: 4.0,
    this.height: 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: RaisedButton(
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
