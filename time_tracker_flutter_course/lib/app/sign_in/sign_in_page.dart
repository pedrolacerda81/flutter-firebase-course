import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({
    @required this.auth,
  });
  final AuthBase auth;

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

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
          SizedBox(height: 48.0),
          SocialSignInButton(
            assetName: 'assets/images/google-logo.png',
            color: Colors.white,
            onPressed: _signInWithGoogle,
            text: 'Sign in with Google',
            textColor: Colors.black87,
            splashColor: Colors.grey[400],
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'assets/images/facebook-logo.png',
            color: Color(0xFF334D92),
            onPressed: () {},
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            splashColor: Colors.white,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            color: Colors.teal[700],
            text: 'Sign in with email',
            textColor: Colors.white,
            onPressed: () {},
            splashColor: Colors.teal,
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            color: Colors.lime[300],
            text: 'Go anonymous',
            textColor: Colors.black87,
            onPressed: _signInAnonymously,
            splashColor: Colors.lime,
          ),
        ],
      ),
    );
  }
}
