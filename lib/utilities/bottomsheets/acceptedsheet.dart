import 'package:com/models/donation.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/organization/declineddonation.dart';
import 'package:flutter/material.dart';

//NOT WORKING

//Modal sheet that appears when "Edit" button is pressed

acceptedSheet(BuildContext context, Donation donation) {
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
                ),
                ListTile(
                  title: Text("Cancel"),
                  trailing: Icon(Icons.cancel),
                  onTap: () async {
                    await DonationDatabaseService()
                        .declineDonation(donation);
                    Route route = MaterialPageRoute(
                        builder: (context) =>
                            DeclinedDonation(donation));
                    Navigator.pushAndRemoveUntil(
                        context, route, ModalRoute.withName("/orghome"));
                  },
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          );
        });
  }