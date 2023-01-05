import 'package:com/screens/user/opendonation.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';

class UserDonationCard extends StatelessWidget {
  final Donation donation;
  UserDonationCard({this.donation});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.blue,
                    width: this.donation.message=='New Pick Up Date Set.'
                        ? 6.0 : 0),
              )
          ),
          child: ListTile(
            onTap: () {
              Route route = MaterialPageRoute(
                  builder: (context) => OpenDonation(this.donation));
              Navigator.push(context, route);
            },
            title: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  color: Colors.black
                ),
                children: <TextSpan>[
                  //TextSpan(text:  "Item: "),
                  TextSpan(text: this.donation.subject, style: TextStyle(fontSize: 16)),
                ]
              ),
          ),
            trailing: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: FittedBox(
              fit: BoxFit.scaleDown,
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
                          TextSpan(text: this.donation.orgName, style: TextStyle(fontSize: 16)),
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
    );
  }
}
