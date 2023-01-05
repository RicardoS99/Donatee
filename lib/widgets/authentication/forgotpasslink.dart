import 'package:flutter/material.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print('ForgotPassword link clicked!');
          Navigator.pushNamed(context, '/recovery');
        },
        child: Text('Forgot Password',
            style: TextStyle(
                color: Colors.cyan[800],
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)));
  }
}
