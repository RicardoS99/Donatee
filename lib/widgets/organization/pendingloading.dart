import 'package:com/models/donation.dart';
import 'package:com/widgets/common/donationfield.dart';
import 'package:com/widgets/common/downloadingattach.dart';
import 'package:flutter/material.dart';

class PendingLoading extends StatelessWidget {
  final Donation donation;
  PendingLoading(this.donation);

  @override
  Widget build(BuildContext context) {
    double dividerHeight=30.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Donation"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserDonationField(
                    header:"Item",
                    body: this.donation.subject,
                  ),
                  Divider(height: dividerHeight,),
                  UserDonationField(
                    header:"Description",
                    body: this.donation.description,),
                  Divider(height: dividerHeight,) ,
                  UserDonationField(
                    header:"Donor",
                    body: this.donation.donorName,),
                  Divider(height: dividerHeight,) ,
                  UserDonationField(
                    header:"Address",
                    body: this.donation.address,),
                  Divider(height: dividerHeight,) ,
                  UserDonationField(
                    header:"Phone Number",
                    body: this.donation.mobileNumber,),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  DownloadingAttach(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
