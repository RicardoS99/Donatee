import 'package:com/utilities/alertdialogs/finishdialog.dart';
import 'package:com/utilities/pickdatetime.dart';
import 'package:com/widgets/common/donationfield.dart';
import 'package:com/widgets/organization/acceptedloading.dart';
import 'package:com/widgets/organization/declineddonation.dart';
import 'package:com/widgets/organization/picpreview.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:intl/intl.dart';

class AcceptedDonation extends StatefulWidget {
  final Donation donation;
  AcceptedDonation(this.donation);
  @override
  _AcceptedDonationState createState() => _AcceptedDonationState();
}

class _AcceptedDonationState extends State<AcceptedDonation> {
  bool isSending = false;

  //Function to edit Pick Up Time

  _setPickUpTime(BuildContext context) async {
    DateTime picked = await pickDateTime(context);
    if (picked != null) {
      setState(() {
        widget.donation.changePickUpTime(picked);
      });
    }
  }

  //Function to decline Donation
  _declineDonation() async {
    await DonationDatabaseService().declineDonation(widget.donation);
    Route route = MaterialPageRoute(
        builder: (context) => DeclinedDonation(widget.donation));
    Navigator.pushReplacement(context, route);
  }

  //Alert Dialogs
  declineDialog(BuildContext context) {
    AlertDialog _alert = AlertDialog(
      title: Text("Cancel confirmation"),
      actions: [
        FlatButton(
          child: Text("Return"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              isSending = true;
            });
            _declineDonation();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alert;
      },
    );
  }

  //Modal sheet that appears when "Edit" button is pressed

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: Text("Set pick up date"),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () {
                    Navigator.pop(context);
                    _setPickUpTime(context);
                  },
                ),
                ListTile(
                  title: Text("Cancel"),
                  trailing: Icon(Icons.cancel),
                  onTap: () {
                    Navigator.pop(context);
                    declineDialog(context);
                  },
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double dividerHeight = 30.0;
    return FutureBuilder(
        future: widget.donation.cachePics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return AcceptedLoading(widget.donation);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Accepted Donation"),
            ),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserDonationField(
                          header:"Item",
                          body: widget.donation.subject,
                        ),
                        Divider(height: dividerHeight,),
                        UserDonationField(
                          header:"Description",
                          body: widget.donation.description,),
                        Divider(height: dividerHeight,) ,
                        UserDonationField(
                          header:"Donor",
                          body: widget.donation.donorName,),
                        Divider(height: dividerHeight,) ,
                        UserDonationField(
                          header:"Address",
                          body: widget.donation.address,),
                        Divider(height: dividerHeight,) ,
                        UserDonationField(
                          header:"Phone Number",
                          body: widget.donation.mobileNumber,),
                        Divider(height: dividerHeight,),
                        UserDonationField(
                          header: "Pick Up Date",
                        body: DateFormat.yMMMd().format(widget.donation.pickUpTime),),

                        SizedBox(
                          height: 50,
                        ),
                        PicPreview(widget.donation),
                        Container(
                          height: 50.0,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FloatingActionButton.extended(
                        heroTag: "editbtn",
                        elevation: 30,
                        onPressed: _showModalSheet,
                        backgroundColor: Colors.white,
                        label: Text("Edit",
                            style: TextStyle(color: Colors.grey[800])),
                      ),
                      FloatingActionButton.extended(
                        heroTag: "completebtn",
                        onPressed: () {
                          finishDialog(context, widget.donation);
                        },
                        backgroundColor: Colors.cyan[800],
                        label: Text(
                          "Finish",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
