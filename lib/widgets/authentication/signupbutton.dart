import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
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
        elevation: 0.0,
        color: istapped ? Colors.cyan[900] : Colors.cyan[800],
        child: Center(
            child: Text('Sign up',
                style: TextStyle(color: Colors.white)),
          ),
      ),
    );
  }
}
