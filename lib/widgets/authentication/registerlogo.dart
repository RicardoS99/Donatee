import 'package:flutter/material.dart';

class RegisterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0.0, 0.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Join',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          )),
      Container(
          padding: EdgeInsets.fromLTRB(0, 35.0, 0.0, 0.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Donatee',
              style: TextStyle(
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[800]),
            ),
          ))
    ]));
  }
}
