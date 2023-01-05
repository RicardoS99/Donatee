import 'package:com/models/orginfo.dart';
import 'package:com/models/user.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/userdatabase.dart';
import 'package:com/widgets/common/loading.dart';
import 'package:com/widgets/user/orgslist.dart';
import 'package:com/widgets/user/userdrawer.dart';
import 'package:flutter/material.dart';
import 'package:com/services/orgsdatabase.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //Future Builder executes a future to be used in builder
    //In this case, we're retrieving the current uid logged in
    return FutureBuilder(
        future: this
            .auth
            .getCurrentUid(), // This result is available as snapshot.data
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          //This StreamProvider creates a Stream of the current user data as a User Class
          //This way, we just need to fetch the data once and not in multiple widgets
          //To access this stream in inherited widgets add this line in build: "final user = Provider.of<User>(context);"
          //Example to get user name: user.name
          return StreamProvider<User>.value(
            value: UserDatabaseService(uid: snapshot.data).user,
            //This StreamProvider creates a Stream of all organizations as List<OrgInfo>
            //To access this stream in inherited widgets add this line in build: "final orgs = Provider.of<List<OrgInfo>>(context);"
            child: StreamProvider<List<OrgInfo>>.value(
              value: OrgDatabaseService().orgs,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text('Donatee'),
                ),
                drawer: UserDrawer(),
                body: OrgsList(),
              ),
            ),
          );
        });
  }
}
