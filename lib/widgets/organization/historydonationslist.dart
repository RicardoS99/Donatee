import 'package:com/widgets/organization/orgdonationcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com/models/donation.dart';

class HistoryDonationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final donations = Provider.of<List<Donation>>(context);
    //print(donations);

    if (donations != null) {
      if (donations.length > 0) {
        return ListView.builder(
          itemCount: donations.length,
          itemBuilder: (context, index) {
            return OrgDonationCard(donation: donations[donations.length-index-1]);
          },
        );
      }
    }
    return 
      Center(
          child: Text(
              'No Inactive Donations yet.',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  color: Colors.grey[600])
          ),
      );
  }
}
