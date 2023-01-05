import 'package:flutter/material.dart';


class LoginHereLink extends StatelessWidget {
  const LoginHereLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already have an Account?',
        ),
        SizedBox(width: 5.0),
        InkWell(
            onTap: () {Navigator.pop(context);},
            child: Text('Login here',
                style: TextStyle(
                    color: Colors.cyan[800],
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline))),
      ],
    );
  }
}
