import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
        child: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0.0, 0.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Welcome to',
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
