import 'dart:io';

import 'package:flutter/material.dart';

class PicFullScreen extends StatelessWidget {
  final File pic;
  PicFullScreen(this.pic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Image.file(
        pic,
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      backgroundColor: Colors.black,
    );
  }
}
