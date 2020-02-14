import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/commun_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    Color splashColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(assetName != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 16.0),
              ),
              Opacity(
                child: Image.asset(assetName),
                opacity: 0.0,
              ),
            ],
          ),
          splashColor: splashColor,
          color: color,
          onPressed: onPressed,
        );
}
