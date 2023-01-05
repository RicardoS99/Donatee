import 'package:flutter/material.dart';

List<Widget> preferredItemsList (List<String> preferredItems){
  int nItems = preferredItems.length;
  List<Widget> returnList = [];
  int i=1;
  while(i<=nItems){
    returnList.add(
        Chip(
          label: Text(
              preferredItems[i-1],
            style: TextStyle(color: Colors.cyan[800]),
          ),
          backgroundColor: Colors.grey[100],
          elevation: 4,
    ));
    i++;
  }
  return returnList;
}