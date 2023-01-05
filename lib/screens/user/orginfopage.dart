import 'package:com/models/orginfo.dart';
import 'package:com/models/user.dart';
import 'package:com/widgets/common/preferreditems.dart';
import 'package:com/widgets/user/orginfoheader.dart';
import 'package:flutter/material.dart';
import 'newdonation.dart';

//Screen which lets the user see the organization he presses.

class OrgInfoPage extends StatelessWidget {
  final OrgInfo orgInfo;
  final User user;
  OrgInfoPage(this.orgInfo, this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrgInfoPageHeader(orgInfo), //Replace appBar by custom Header
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        orgInfo.description,
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    orgInfo.preferredItems.isNotEmpty
                        ? Column(children: <Widget>[
                            Divider(
                              indent: 20,
                              endIndent: 20,
                            ),
                            Text(
                              "Preferred Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: -5.0,
                              children:
                                  preferredItemsList(orgInfo.preferredItems),
                            ),
                          ])
                        : Container(),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        orgInfo.contact,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    SizedBox(
                        height:
                            80), //Makes sure the last thing isn't covered by button
                  ]),
            ), // Makes area scrollable
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: [0.1, 1.0],
                ),
              ),
            ), // Adds fade out effect to text when scrolling
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => NewDonation(orgInfo, user));
            Navigator.push(context, route);
          },
          icon: Icon(
            Icons.add,
            //size: 40,
          ),
          label: Text("Donate")),
    );
  }
}
