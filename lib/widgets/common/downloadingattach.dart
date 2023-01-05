import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DownloadingAttach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Downloading Attachments',
              style: TextStyle(fontSize: 22.0),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 11, 0, 0),
              child: SpinKitThreeBounce(color: Colors.black, size: 10.0),
            ),
          ],
        ),
      );
  }
}