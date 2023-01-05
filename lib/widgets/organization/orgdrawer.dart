import 'package:com/models/orginfo.dart';
import 'package:com/screens/organization/orgprofile.dart';
import 'package:com/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final org = Provider.of<OrgInfo>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(org != null ? org.name : 'Loading'),
            accountEmail: Text(org != null ? org.contact : 'Loading'),
            currentAccountPicture: (org != null && org.logoUrl.length > 1)
                ? CircleAvatar(
                    backgroundImage: NetworkImage(org.logoUrl),
                  )
                : CircleAvatar(
                    backgroundColor: Theme.of(context).platform ==
                            TargetPlatform
                                .iOS //This choose color depending on the platform
                        ? Colors.blue
                        : Colors.white,
                    child: Text('D', style: TextStyle(fontSize: 40.0))),
          ),
          ListTile(
              title: Text('Profile'),
              trailing: Icon(Icons.person),
              onTap: (){
                Navigator.pop(context);
                Route profileRoute = MaterialPageRoute(
                builder: (context)=>OrgProfile(org));
                Navigator.push(context, profileRoute);
                }
              ),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.power_settings_new),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        );
      }
    }
