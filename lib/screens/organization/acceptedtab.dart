import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/organization/accepteddonationslist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com/models/donation.dart';

class AcceptedTab extends StatelessWidget {
  final String orgUID;
  AcceptedTab({this.orgUID});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Donation>>.value(
      value: DonationDatabaseService(uid: orgUID).accepteddonations,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AcceptedDonationList(),
      ),
    );
  }
}