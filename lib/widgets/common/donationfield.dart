import 'package:com/shared/constants.dart';
import 'package:flutter/material.dart';

class UserDonationField extends StatelessWidget {
  const UserDonationField({
    Key key,
    @required this.header,
    @required this.body,
  }) : super(key: key);

  final String header;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserDonationHeader(header: this.header),
        UserDonationBody(body: this.body),
      ],
    );
  }
}

class UserDonationBody extends StatelessWidget {
  final String body;
  const UserDonationBody({
    Key key,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
          child: Material(
                    borderRadius: BorderRadius.circular(15.0),
                    elevation: 4.0,
                    color: Colors.cyan[800],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
        body,
        style: userDonationsBodyStyle,
        textAlign: TextAlign.justify,
      ),),)
    );
  }
}

class UserDonationHeader extends StatelessWidget {
  final String header;
  const UserDonationHeader({Key key, @required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:15.0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        this.header,
        style: userDonationsHeaderStyle,
        textAlign: TextAlign.right,
      ),
    );
  }
}
