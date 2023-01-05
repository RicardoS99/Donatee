import 'package:com/services/auth.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('Logout',
               style: TextStyle(color: Colors.white),
               ),
            );
  }
}