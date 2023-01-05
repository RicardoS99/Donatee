import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        color: Colors.white,
        child: Center(
          child: Text('Donatee', style:TextStyle(fontSize: 40.0, color:Colors.cyan[800])),
          ),
        
      ),
    );
  }
}