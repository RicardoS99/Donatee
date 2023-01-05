import 'package:com/models/donation.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/organization/completeddonation.dart';
import 'package:flutter/material.dart';

//Alert Dialog that appears when "Finish button is pressed".
  
finishDialog(BuildContext context, Donation donation) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Confirm"),
    onPressed: () async {
      await DonationDatabaseService()
                          .completeDonation(donation);
                      Route route = MaterialPageRoute(
                          builder: (context) =>
                              CompletedDonation(donation));
                      Navigator.pushAndRemoveUntil(context, route, ModalRoute.withName("/orghome"));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Completed?"),
    content:
        Text("Confirm that donation was received."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}