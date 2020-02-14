import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Tracker'), elevation: 2.0),
      body: _buildBodyContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Padding _buildBodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          SignInButton(
            color: Colors.white,
            text: 'Sign in with Google',
            textColor: Colors.black87,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
