import 'dart:io';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/commun_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/commun_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;
  EmailSignInForm({@required this.auth});
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _submitted = false;
  bool _isLoading = false;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  String get _email => _emailEditingController.text;
  String get _password => _passwordEditingController.text;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: 'Sign in failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailEditingController.clear();
    _passwordEditingController.clear();
  }

  TextField _buildEmailTextField() {
    bool showErroText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailEditingController,
      focusNode: _emailFocusNode,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErroText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (String value) => _updateState(),
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordEditingController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (String value) => _updateState(),
    );
  }

  List<Widget> _buildColumnChildren() {
    final String primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Creat an account';
    final String secondayText = _formType == EmailSignInFormType.signIn
        ? 'Need an accont? Register'
        : 'Have an accont? Sign In';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      FlatButton(
        child: Text(secondayText),
        onPressed: !_isLoading ? _toggleFormType : null,
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

  void _updateState() {
    setState(() {});
  }
}
