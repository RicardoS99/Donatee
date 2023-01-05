import 'package:com/widgets/common/donationfield.dart';
import 'package:com/utilities/pickdatetime.dart';
import 'package:com/widgets/organization/accepteddonation.dart';
import 'package:com/widgets/organization/declineddonation.dart';
import 'package:com/widgets/organization/pendingloading.dart';
import 'package:com/widgets/organization/picpreview.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:intl/intl.dart';
import 'package:com/widgets/organization/inputdropdown.dart';

class PendingDonation extends StatefulWidget {
  final Donation donation;
  PendingDonation(this.donation);
  @override
  _PendingDonationState createState() => _PendingDonationState();
}

class _PendingDonationState extends State<PendingDonation> {
  bool isSending = false;
  DateTime pickUpTime;

  //Function to accept Donation
  _acceptDonation() async {
    widget.donation.changePickUpTime(pickUpTime);
    await DonationDatabaseService().acceptDonation(widget.donation);
    Route route = MaterialPageRoute(
        builder: (context) => AcceptedDonation(widget.donation));
    Navigator.pushReplacement(context, route);
  }

  //Function to decline Donation
  _declineDonation() async {
    await DonationDatabaseService().declineDonation(widget.donation);
    Route route = MaterialPageRoute(
        builder: (context) => DeclinedDonation(widget.donation));
    Navigator.pushReplacement(context, route);
  }

  //Alert Dialogs

  acceptDialog(BuildContext context) {
    //Alert dialog to show when the pick up time wasn't set
    AlertDialog _alertNoPickUpTime = AlertDialog(
      title: Text("WARNING:Pick Up Date is required!"),
      content: Text("Please set Pick Up Date"),
      actions: [
        FlatButton(
          child: Text("Return"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    //Alert dialog to show when everything is fine
    AlertDialog _alert = AlertDialog(
      title: Text("Confirmation to Accept required"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Accept"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              isSending = true;
            });
            _acceptDonation();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return pickUpTime == null ? _alertNoPickUpTime : _alert;
      },
    );
  }

  declineDialog(BuildContext context) {
    AlertDialog _alert = AlertDialog(
      title: Text("Confirmation to Decline required"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Decline"),
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

  @override
  Widget build(BuildContext context) {
    double dividerHeight=30.0;
    return FutureBuilder(
        future: widget.donation.cachePics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return PendingLoading(widget.donation);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Pending Donation"),
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
                        SizedBox(
                          height: widget.donation.nPhotos > 0 ? 50 : 0,
                        ),
                        PicPreview(widget.donation),
                        SizedBox(
                          height: 20,
                        ),
                        InputDropdown(
                          labelText: 'Pick Up Date',
                          valueText: pickUpTime == null
                              ? 'Set Pick Up Date'
                              : DateFormat.yMMMd().format(pickUpTime),
                          onPressed: () async {
                            DateTime picked = await pickDateTime(context);
                            if (picked != null) {
                              setState(() {
                                pickUpTime = picked;
                              });
                            }
                          },
                        ),
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
                        heroTag: "declinebtn",
                        onPressed: () async {
                          if (!isSending) {
                            declineDialog(context);
                          }
                        },
                        backgroundColor: Colors.red[800],
                        label: Text(
                          "Decline",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      FloatingActionButton.extended(
                        heroTag: "acceptbtn",
                        onPressed: () async {
                          if (!isSending) {
                            acceptDialog(context);
                          }
                        },
                        backgroundColor: Colors.cyan[800],
                        label: Text("Accept",
                            style: TextStyle(color: Colors.white)),
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
