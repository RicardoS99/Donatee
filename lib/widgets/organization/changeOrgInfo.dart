import 'package:com/models/orginfo.dart';
import 'package:com/services/orgsdatabase.dart';
import 'package:com/shared/constants.dart';
import 'package:flutter/material.dart';

//page where organizations can edit their description and contact

class ChangeOrgInfo extends StatefulWidget {
  final OrgInfo org;
  final Function refreshPage;
  ChangeOrgInfo(this.org, this.refreshPage);
  @override
  _ChangeOrgInfoState createState() => _ChangeOrgInfoState();
}

class _ChangeOrgInfoState extends State<ChangeOrgInfo> {
  final _formKey = GlobalKey<FormState>();
  bool isUpdating = false;
  String newDescription = '';
  String newContact = '';
  List<String> newPreferredItems = [];
  List<String> oldPreferredItems = [];

  //Set default values to current values
  //This way, when something is left unchanged, we make sure it doesn't appear blank.
  //Validator thinks that the field has something when it's not changed because of initialvalue, but val is actually blank
  int nPreferredItems;
  initState() {
    super.initState();
    newDescription = widget.org.description;
    newContact = widget.org.contact;
    newPreferredItems = new List<String>.from(widget.org.preferredItems);
    nPreferredItems = newPreferredItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                    width: 0.9 *
                        MediaQuery.of(context)
                            .size
                            .width, //With the rounded box, set a width = 170
                    height: 30,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Description',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(height: 8),
                Container(
                  width: 0.9 * MediaQuery.of(context).size.width,
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    child: TextFormField(
                      decoration: editInputDecoration.copyWith(
                          hintText: "Edit Description",
                          prefixIcon:
                              Icon(Icons.description, color: Colors.cyan[800])),
                      validator: (val) => val.isEmpty
                          ? 'Please update your description.'
                          : null,
                      initialValue: widget.org.description,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (val) {
                        setState(() => newDescription = val);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: 0.9 *
                        MediaQuery.of(context)
                            .size
                            .width, //With the rounded box, set a width = 170
                    height: 30,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Contact',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                      textAlign: TextAlign.left,
                    )),
                SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 0.9 * MediaQuery.of(context).size.width,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: TextFormField(
                        decoration: editInputDecoration.copyWith(
                            hintText: "Edit Contact",
                            prefixIcon:
                                Icon(Icons.email, color: Colors.cyan[800])),
                        validator: (val) =>
                            val.isEmpty ? 'Please update your contact.' : null,
                        initialValue: widget.org.contact,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (val) {
                          setState(() => newContact = val);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          /*width: MediaQuery.of(context)
                              .size
                              .width-100, */ //With the rounded box, set a width = 170
                          height: 30,
                          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Text(
                            'Preferred Items',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.black),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                      onPressed: () {
                        setState(() {
                          nPreferredItems += 1;
                          newPreferredItems.add('');
                          print(nPreferredItems);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        onPressed: () {
                          setState(() {
                            newPreferredItems.removeAt(nPreferredItems - 1);
                            nPreferredItems -= 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: nPreferredItems,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal:20),
                      height: 70,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        child: TextFormField(
                          decoration: editInputDecoration.copyWith(
                              hintText: "Edit Preferred Item",
                              prefixIcon: Icon(Icons.card_giftcard,
                                  color: Colors.cyan[800])),
                          validator: (val) => val.isEmpty
                              ? 'Please fill this field or erase it.'
                              : null,
                          initialValue: newPreferredItems[index],
                          onChanged: (val) {
                            setState(() {
                              newPreferredItems[index] = val;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(!isUpdating ? "Update" : "Updating"),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              if (!isUpdating) {
                setState(() {
                  isUpdating = true;
                });
                if (newDescription != widget.org.description) {
                  await OrgDatabaseService()
                      .updateDescription(widget.org, newDescription);
                }
                if (newContact != widget.org.contact) {
                  await OrgDatabaseService()
                      .updateContact(widget.org, newContact);
                }
                print(newPreferredItems);
                print(widget.org.preferredItems);
                if (newPreferredItems != widget.org.preferredItems) {
                  await OrgDatabaseService()
                      .updatePreferredItems(widget.org, newPreferredItems);
                }
                await widget.refreshPage();
                Navigator.pop(context);
              }
            }
          }),
    );
  }
}
