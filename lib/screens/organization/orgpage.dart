import 'package:com/models/orginfo.dart';
import 'package:com/services/auth.dart';
import 'package:com/services/orgsdatabase.dart';
import 'package:com/widgets/common/loading.dart';
import 'package:com/widgets/organization/orgdrawer.dart';
import 'package:flutter/material.dart';
import 'package:com/screens/organization/acceptedtab.dart';
import 'package:com/screens/organization/pendingtab.dart';
import 'package:com/screens/organization/historytab.dart';
import 'package:provider/provider.dart';

//page that pops whenever someone signs in as an organization

class OrgPage extends StatefulWidget {
  final AuthService auth = AuthService();
  @override
  _OrgPageState createState() => _OrgPageState();
}

class _OrgPageState extends State<OrgPage> {
  @override
  Widget build(BuildContext context) {
    //This builds the screen depending if the future function is completed or not.
    return FutureBuilder<dynamic>(
      future: widget.auth
          .getCurrentUid(), // This result is available as snapshot.data
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Loading();
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');

            //This StreamProvider creates a Stream of the current org data as a OrgInfo Class
            //This way, we just need to fetch the data once and not in multiple widgets
            //To access this stream in inherited widgets add this line in build: "final org = Provider.of<OrgInfo>(context);"
            //Example to get organization name: org.name

            return StreamProvider<OrgInfo>.value(
              value: OrgDatabaseService(uid: snapshot.data).org,
              //DefaultTabController is what manages the whole one screen to another thing
              //Initial index sets the default tab shown (if == 1, then the 2nd screen on TabBarView is presented).

              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Scaffold(
                  drawer: OrgDrawer(),
                  appBar: AppBar(
                    title: Text("Donatee"),
                    bottom: TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.cyan[800],
                      tabs: <Widget>[
                        Tab(text: "Accepted"),
                        Tab(text: "Pending"),
                        Tab(text: "History"),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      AcceptedTab(orgUID: snapshot.data),
                      PendingTab(orgUID: snapshot.data),
                      HistoryTab(orgUID: snapshot.data),
                    ],
                  ),
                ),
              ),
            );
        }
        return null; // unreachable
      },
    );
  }
}
