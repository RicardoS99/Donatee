import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:com/widgets/common/splashlogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  //Function to check if any type of user is logged in
  Future<void> _checkAuthStatus() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      print('ACCOUNT STATUS: UNDEFINED');
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      _checkUserType(user);
    }
  }

  //Function to check what is the user's type (USER/ORG)
  Future<void> _checkUserType(FirebaseUser user) async {
    DocumentSnapshot userDoc = await Firestore.instance.collection('users').document(user.uid).get();
    if(userDoc.exists){
      print('ACCOUNT STATUS: USER');
      Navigator.pushReplacementNamed(context, "/userhome");
    } else {
      DocumentSnapshot orgDoc = await Firestore.instance.collection('orgs').document(user.uid).get();
      if(orgDoc.exists){
        print('ACCOUNT STATUS: ORG');
        Navigator.pushReplacementNamed(context, "/orghome");
      } else {
        print('ACCOUNT STATUS: UNDEFINED');
        print('ERROR: MISSING DOCUMENT!'); //If this messages appears something is seriously wrong!
        Navigator.pushReplacementNamed(context, "/login");
      }
    }
  }

  @override
  initState() {
    super.initState();
    _checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SplashLogo();
  }
}
