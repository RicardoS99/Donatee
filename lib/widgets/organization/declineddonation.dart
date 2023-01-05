import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/common/donationfield.dart';
import 'package:com/widgets/common/loading.dart';
import 'package:com/widgets/organization/picpreview.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';

class DeclinedDonation extends StatefulWidget {
  final Donation donation;
  DeclinedDonation(this.donation);
  @override
  _DeclinedDonationState createState() => _DeclinedDonationState();
}

class _DeclinedDonationState extends State<DeclinedDonation> {
  @override
  void initState() {
    super.initState();
    DonationDatabaseService().orgOpenDonation(widget.donation);
  }

  @override
  Widget build(BuildContext context) {
    double dividerHeight = 30.0;
    return FutureBuilder(
        future: widget.donation.cachePics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.donation.cancelled
                  ? "Cancelled Donation"
                  : "Declined Donation"),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
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
                              ],
                            ),
                    ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Center(
                                child: Text(
                                  widget.donation.cancelled ? "Cancelled" : "Declined",
                                  style: TextStyle(
                                      color: Colors.red[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ));});
  }
}
