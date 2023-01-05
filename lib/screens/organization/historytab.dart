import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/organization/historydonationslist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com/models/donation.dart';

class HistoryTab extends StatelessWidget {
  final String orgUID;
  HistoryTab({this.orgUID});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Donation>>.value(
      value: DonationDatabaseService(uid: orgUID).historydonations,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: HistoryDonationList(),
      ),
    );
  }
}