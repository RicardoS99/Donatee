import 'package:com/models/user.dart';
import 'package:com/screens/user/mydonations.dart';
import 'package:com/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text(user.name, style: TextStyle(fontFamily: 'Montserrat')),
            accountEmail:
                Text(user.email, style: TextStyle(fontFamily: 'Montserrat')),
          ),
          ListTile(
            title: Text(
              "My Donations",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            trailing: Icon(Icons.assignment),
            onTap: () {
              Route route =
                  MaterialPageRoute(builder: (context) => MyDonations(user));
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: Text(
              "Logout",
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            trailing: Icon(Icons.person),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
          )
        ],
      ),
    );
  }
}
