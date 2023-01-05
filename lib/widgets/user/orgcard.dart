import 'package:com/models/orginfo.dart';
import 'package:com/models/user.dart';
import 'package:flutter/material.dart';
import 'package:com/screens/user/orginfopage.dart';
import 'package:provider/provider.dart';

//Organizations Cards displayed on the User Home Page

class OrgCard extends StatelessWidget {
  final OrgInfo info;
  OrgCard(this.info);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    int maxchar = 70;
    String txtpreview = info.description.length <= maxchar
        ? info.description
        : info.description.substring(0, maxchar - 3) + '...';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
      elevation: 1.0,
      child: ListTile(
        onTap: () {
          Route route =
              MaterialPageRoute(builder: (context) => OrgInfoPage(info, user));
          Navigator.push(context, route);
        },
        leading: info.logoUrl != ""
            ? CircleAvatar(
                radius: 28.0,
                backgroundImage: NetworkImage(info.logoUrl),
              )
            : CircleAvatar(
                radius: 28.0,
              ),
        title: Text(info.name),
        subtitle: Text(
          txtpreview,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
