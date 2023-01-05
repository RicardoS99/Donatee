import 'package:com/widgets/organization/accepteddonation.dart';
import 'package:com/widgets/organization/completeddonation.dart';
import 'package:com/widgets/organization/pendingdonation.dart';
import 'package:com/widgets/organization/declineddonation.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';



class OrgDonationCard extends StatelessWidget {
  final Donation donation;
  OrgDonationCard({this.donation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                width: this.donation.message=='Cancelled'
                ? 6 : 0,
                color: Colors.red),
          )
        ),
        child: ListTile(
          onTap: () {
            print(this.donation.status);
            if (this.donation.status == "Pending") {
              Route route = MaterialPageRoute(
                  builder: (context) => PendingDonation(this.donation));
              Navigator.push(context, route);
            }
            else if (this.donation.status == "Accepted") {
              Route route = MaterialPageRoute(
                  builder: (context) => AcceptedDonation(this.donation));
              Navigator.push(context, route);
            }
            else if (this.donation.status == "Declined") {
              Route route = MaterialPageRoute(
                  builder: (context) => DeclinedDonation(this.donation));
              Navigator.push(context, route);
            }
            else if (this.donation.status == "Completed") {
              Route route = MaterialPageRoute(
                  builder: (context) => CompletedDonation(this.donation));
              Navigator.push(context, route);
            }
          },
          title: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  color: Colors.black
                ),
                children: <TextSpan>[
                  TextSpan(text:  "Item: "),
                  TextSpan(text: this.donation.subject, style: TextStyle(fontWeight: FontWeight.bold)),
                ]
              ),
          ),
          //trailing: Text(this.donation.donorName),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Align(
              alignment: Alignment.centerRight,
                          child: FittedBox(
                fit:BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: Colors.black
                          ),
                          children: <TextSpan>[
                            //TextSpan(text:  "Donor: "),
                            TextSpan(text: this.donation.donorName),
                          ]
                      ),
                    ),
                    SizedBox(width: 10,),
                    this.donation.status=="Declined"
                      ? Icon(
                      Icons.clear,
                      color: Colors.red,
                    )
                        :this.donation.status=="Completed" ? Icon(
                      Icons.done_all,
                      color: Colors.blue,
                    )
                        :this.donation.status=="Accepted" ?Icon(
                      Icons.done,
                      color:Colors.green,
                    )
                        :this.donation.status=="Pending"?Icon(
                      Icons.schedule,
                      color: Colors.amber[300],
                    ):Container(),

                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
