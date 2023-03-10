import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitRipple(
            color: Colors.cyan[700],
            size: MediaQuery.of(context).size.width * 0.3),
      ),
    );
  }
}
