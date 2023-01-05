import 'package:flutter/material.dart';

//Design of Text Input Boxes
const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
    hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan))
    /*fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0)
  ),*/
    );

//Design of Text Input Boxes in edit profile
InputDecoration editInputDecoration = InputDecoration(
  labelStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
  hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
  filled: true,
  fillColor: Colors.cyan[50],
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
    borderRadius: BorderRadius.circular(20.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.circular(20.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.circular(20.0),
  ),
);

TextStyle orgDonationsHeaderStyle = TextStyle(
    color: Colors.grey[600], fontWeight: FontWeight.bold, fontSize: 18);
TextStyle orgDonationsBodyStyle = TextStyle(color: Colors.black, fontSize: 22);

TextStyle userDonationsHeaderStyle =
    TextStyle(color: Colors.cyan[900], fontSize: 24);
TextStyle userDonationsBodyStyle = TextStyle(color: Colors.white, fontSize: 18);
