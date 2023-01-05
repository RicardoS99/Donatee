import 'package:com/widgets/user/userdonationcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com/models/donation.dart';

class MyDonationList extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final donations = Provider.of<List<Donation>>(context);

    if (donations != null) {
      //Attempt to resolve the 'was called on null' unsuccessful -> não faço a menor ideia do que seja xD
      return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          return UserDonationCard(donation: donations[donations.length-index-1]);
        },
      );
    }
    else{
      return(Text('No Donations yet.'));
    }
  }
}
