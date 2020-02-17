import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/home_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    User user = await widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        onSignIn:
            _updateUser, //don't need to pass FirebaseUser user because it's required on both
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    );
  }
}
