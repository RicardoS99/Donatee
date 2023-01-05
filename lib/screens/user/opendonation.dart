import 'package:com/widgets/common/donationfield.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:com/widgets/common/downloadingattach.dart';
import 'package:com/widgets/organization/picpreview.dart';
import 'package:flutter/material.dart';
import 'package:com/models/donation.dart';
import 'package:intl/intl.dart';

class OpenDonation extends StatefulWidget {
  final Donation donation;
  OpenDonation(this.donation);
  @override
  _OpenDonationState createState() => _OpenDonationState();
}

class _OpenDonationState extends State<OpenDonation> {
  String message;

  //Alert Dialogs

  cancelDialog(BuildContext context) {
    AlertDialog _alert = AlertDialog(
      title: Text("Are you sure you want to Cancel?"),
      actions: [
        FlatButton(
          child: Text("No"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Yes"),
          onPressed: () async {
            await widget.donation.cancel();
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.message = widget.donation.message;
    DonationDatabaseService().userOpenDonation(widget.donation);
  }

  @override
  Widget build(BuildContext context) {
    double dividerheight = 30;
    return FutureBuilder(
        future: widget.donation.cachePics(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         /* if (!snapshot.hasData) {
            return OpenLoading(widget.donation);
          }*/
          return Scaffold(
            appBar: widget.donation.active
                ? AppBar(
                    title: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(widget.donation.subject)),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.cyan[800],
                          ),
                          onPressed: () => cancelDialog(context))
                    ],
                  )
                : AppBar(title: Text(widget.donation.subject)),
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserDonationField(
                            header: 'Item', body: widget.donation.subject),
                        Divider(height: dividerheight),
                        UserDonationField(
                            header: 'Organization',
                            body: widget.donation.orgName),
                        Divider(height: dividerheight),
                        UserDonationField(
                            header: 'Status',
                            body: widget.donation.cancelled
                                ? 'Cancelled'
                                : widget.donation.status),
                        Divider(height: dividerheight),
                        UserDonationField(
                            header: 'Description',
                            body: widget.donation.description),
                        Divider(height: dividerheight),
                        UserDonationField(
                            header: 'Address', body: widget.donation.address),
                        widget.donation.status == 'Accepted'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Divider(height: dividerheight),
                                    UserDonationField(
                                        header: 'Pick Up Date',
                                        body: DateFormat.yMMMd().format(
                                            widget.donation.pickUpTime)),
                                    message != ''
                                        ? SizedBox(height: 3)
                                        : Container(),
                                    message != ''
                                        ? Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:15.0),
                                          child: Text(message,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16)),
                                        )
                                        : Container(),
                                    SizedBox(height: 5),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.info_outline),
                                        SizedBox(width: 10),
                                        Expanded(
                                            child: Text(
                                                'To change the pick up details contact the organization.'))
                                      ],
                                    ),
                                  ])
                            : Container(),
                        SizedBox(
                          height: 50,
                        ),
                        snapshot.hasData ? PicPreview(widget.donation) : DownloadingAttach(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

