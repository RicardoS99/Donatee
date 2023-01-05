import 'dart:io';
import 'package:com/widgets/user/picthumbnaillist.dart';
import 'package:com/models/user.dart';
import 'package:flutter/material.dart';
import 'package:com/models/orginfo.dart';
import 'package:com/models/donation.dart';
import 'package:com/services/donationsdatabase.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/constants.dart';

bool isPhoneNumber(String val) {
  bool allNumbers = true;
  bool result = false;
  try{int.parse(val);}
  catch(e){
      allNumbers=false;
  }
  (val.length ==9 && allNumbers==true) ? result = true : result = false;
  return result;
}

class NewDonation extends StatefulWidget {
  final OrgInfo orgInfo;
  final User user;
  NewDonation(this.orgInfo, this.user);

  @override
  _NewDonationState createState() => _NewDonationState();
}

class _NewDonationState extends State<NewDonation> {
  final _formKey = GlobalKey<FormState>();

  bool isSending = false;

  int maxPhotos = 3;
  int nPhotos = 0;

  //Form Fields
  String subject = '';
  String description = '';
  String address = ''; //later this will have a default value
  String mobile = '';
  var photos = new List<File>();

  //Function do delete pictures
  void deletePic(String pathDel) {
    setState(() {
      this.photos.removeWhere((pic) => pic.path == pathDel);
      this.nPhotos -= 1;
    });
  }

  //Function to send Donation
  sendDonation() async {
    print('----------------Starting new donation');
    Donation donation = Donation(
        donorUID: widget.user.uid,
        organizationUID: widget.orgInfo.organizationUID,
        donorName: widget.user.name,
        orgName: widget.orgInfo.name,
        description: description,
        mobileNumber: mobile,
        subject: subject,
        address: address,
        pics: photos,
        nPhotos: nPhotos);
    await donation.updateURLs();
    await DonationDatabaseService().createdDonation(donation);
    Navigator.pushReplacementNamed(context, '/success');
  }

  //Alert Dialog
  sendDialog(BuildContext context) {
    //Alert dialog to show when there are no attachments
    AlertDialog alertNoPic = AlertDialog(
      title: Text("Are you ready to send?"),
      content: Text(
          "WARNING: Attaching pictures of your donation will increase the chances of being Accepted!"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Send"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              isSending = true;
            });
            sendDonation();
          },
        ),
      ],
    );

    //Alert dialog to show when everything is fine
    AlertDialog alert = AlertDialog(
      title: Text("Are you ready to send?"),
      actions: [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Send"),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              isSending = true;
            });
            sendDonation();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return nPhotos == 0 ? alertNoPic : alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Donation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(32.0, 15.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        text:'Organization : ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.0)
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.orgInfo.name,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    !isSending
                        ? TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Item',
                                prefixIcon: Icon(Icons.card_giftcard)),
                            validator: (val) =>
                                val.isEmpty ? 'Item required' : null,
                            onChanged: (val) {
                              setState(() => subject = val);
                            })
                        : Row(
                            children: <Widget>[
                              SizedBox(width: 12.0),
                              Icon(
                                Icons.assignment_ind,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  subject,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 20.0),
                    !isSending
                        ? TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Description',
                                prefixIcon: Icon(Icons.description)),
                            validator: (val) => val.isEmpty
                                ? 'Please write a short description.'
                                : null,
                            onChanged: (val) {
                              setState(() => description = val);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          )
                        : Row(
                            children: <Widget>[
                              SizedBox(width: 12.0),
                              Icon(
                                Icons.description,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  description,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 20.0),
                    !isSending
                        ? TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Address',
                                prefixIcon: Icon(Icons.location_on)),
                            validator: (val) =>
                                val.length < 1 ? 'Address required' : null,
                            onChanged: (val) {
                              setState(() => address = val);
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          )
                        : Row(
                            children: <Widget>[
                              SizedBox(width: 12.0),
                              Icon(
                                Icons.location_on,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  address,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 20.0),
                    !isSending
                        ? TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Mobile Phone',
                                prefixIcon: Icon(Icons.phone)),
                            validator: (val) =>
                            !isPhoneNumber(val) ? 'Please enter valid phone number' : null,
                            onChanged: (val) {
                              setState(() => mobile = val);
                            })
                        : Row(
                            children: <Widget>[
                              SizedBox(width: 12.0),
                              Icon(
                                Icons.phone,
                                color: Colors.grey[600],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  mobile,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        nPhotos < maxPhotos && !isSending
                            ? FloatingActionButton(
                                heroTag: 'addpic',
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                                backgroundColor: Colors.white,
                                elevation: 0,
                                onPressed: () async {
                                  print('Add picture Pressed');
                                  if (nPhotos < maxPhotos) {
                                    File logo = await ImagePicker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 1280,
                                        maxWidth: 1280);
                                    if (logo != null) {
                                      setState(() {
                                        photos.add(logo);
                                        nPhotos += 1;
                                      });
                                    }
                                  }
                                })
                            : Container(),
                        SizedBox(width: 10.0),
                        PicThumbnailList(nPhotos, photos, this.deletePic, !isSending),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    FloatingActionButton.extended(
                      heroTag: 'send',
                      label: Text(!isSending ? "Send" : "Sending"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!isSending) {
                            sendDialog(context);
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
