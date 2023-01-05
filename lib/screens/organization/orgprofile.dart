import 'package:com/models/orginfo.dart';
import 'package:com/services/logostorage.dart';
import 'package:com/widgets/common/preferreditems.dart';
import 'package:com/widgets/organization/changeOrgInfo.dart';
import 'package:com/widgets/user/orginfoheader.dart';
import 'package:flutter/material.dart';

//Screen which lets the user see the organization he presses.

class OrgProfile extends StatefulWidget {
  final OrgInfo orgInfo;
  OrgProfile(this.orgInfo);

  @override
  _OrgProfileState createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  void refreshPage() async {
    await widget.orgInfo.refreshProfile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          OrgInfoPageHeader(widget.orgInfo), //Replace appBar by custom Header
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
                        widget.orgInfo.description,
                        style: TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    widget.orgInfo.preferredItems.isNotEmpty
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
                              children: preferredItemsList(
                                  widget.orgInfo.preferredItems),
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
                        widget.orgInfo.contact,
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      //heroTag: "editbtn",
                      //elevation: 30,
                      child: Icon(
                        Icons.photo,
                        color: Colors.cyan[800],
                      ),
                      backgroundColor: Colors.grey[100],
                      onPressed: () async {
                        LogoStorage logoStorage =
                            LogoStorage(org: widget.orgInfo);
                        await logoStorage.changeLogo();
                        refreshPage();
                      },
                      //backgroundColor: Colors.white,
                    ),
                    FloatingActionButton.extended(
                        heroTag: "completebtn",
                        onPressed: () {
                          Route editProfileRoute = MaterialPageRoute(
                              builder: (context) => ChangeOrgInfo(
                                  widget.orgInfo, this.refreshPage));
                          Navigator.push(context, editProfileRoute);
                        },
                        icon: Icon(
                          Icons.edit,
                        ),
                        label: Text("Edit")),
                  ],
                ),
              ),
            ) // Adds fade out effect to text when scrolling
          ],
        ),
      ),
    );
  }
}
