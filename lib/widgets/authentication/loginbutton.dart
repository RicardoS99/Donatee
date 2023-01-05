import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.istapped,
  }) : super(key: key);

  final bool istapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        elevation: 1.0,
        textStyle: TextStyle(fontFamily: 'Montserrat'),
        color: istapped ? Colors.cyan[900] : Colors.cyan[800],
        child: Center(
            child: Text('Login',
                style: TextStyle(color: Colors.white)),
          ),
      ),
    );
  }
}