import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/commun_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;
  EmailSignInForm({@required this.auth});
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  String get _email => _emailEditingController.text;
  String get _password => _passwordEditingController.text;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailEditingController.clear();
    _passwordEditingController.clear();
  }

  List<Widget> _buildColumnChildren() {
    final String primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Creat an account';
    final String secondayText = _formType == EmailSignInFormType.signIn
        ? 'Need an accont? Register'
        : 'Have an accont? Sign In';

    return [
      TextField(
        controller: _emailEditingController,
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'test@test.com'),
      ),
      SizedBox(height: 8.0),
      TextField(
        controller: _passwordEditingController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submit,
      ),
      FlatButton(
        child: Text(secondayText),
        onPressed: _toggleFormType,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      ),
    );
  }
}
