import 'package:com/services/auth.dart';
import 'package:com/shared/constants.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool sending = false;
  bool done = false;

  //text field state
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                'Write your email and we\'ll send you an email to reset your password.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              )),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) =>
                      val.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(height: 20.0),
              done
                  ? FloatingActionButton.extended(
                      onPressed: () => Navigator.pop(context),
                      label: Text('Email was sent'))
                  : FloatingActionButton.extended(
                      onPressed: () async {
                        if (!sending) {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              sending = true;
                            });
                            await _auth.resetPassword(email);
                            setState(() {
                              done = true;
                            });
                          }
                        }
                      },
                      label: sending ? Text('Sending') : Text('Send'))
            ],
          ),
        ),
      ),
    );
  }
}
