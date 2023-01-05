import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/organization/pendingdonationslist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com/models/donation.dart';

class PendingTab extends StatelessWidget {
  final String orgUID;
  PendingTab({this.orgUID});


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Donation>>.value(
      value: DonationDatabaseService(uid: orgUID).pendingdonations,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PendingDonationList(),
      ),
    );
  }
}