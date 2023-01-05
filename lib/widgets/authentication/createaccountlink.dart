import 'package:flutter/material.dart';

class CreateAccountPack extends StatelessWidget {
  const CreateAccountPack({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'New to Donatee?',
        ),
        SizedBox(width: 5.0),
        CreateAccountLink(),
      ],
    );
  }
}

class CreateAccountLink extends StatelessWidget {
  const CreateAccountLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {Navigator.pushNamed(context, "/register");},
        child: Text('Create an Account',
            style: TextStyle(
                color: Colors.cyan[800],
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline)));
  }
}


