import 'package:flutter/material.dart';
import 'package:com/widgets/user/orgcard.dart';
import 'package:provider/provider.dart';
import 'package:com/models/orginfo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrgsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orgs = Provider.of<List<OrgInfo>>(context);

    if (orgs != null) {
      return ListView.builder(
        itemCount: orgs.length,
        itemBuilder: (context, index) {
          return OrgCard(orgs[index]);
        },
      );
    } else {
      return Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading Organizations',
              style: TextStyle(fontSize: 22.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 11, 0, 0),
              child: SpinKitThreeBounce(color: Colors.black, size: 10.0),
            ),
          ],
        ),
      );
    }
  }
}
