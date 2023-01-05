import 'package:cloud_firestore/cloud_firestore.dart';

class User {

  String uid;
  String name;
  String email;

  User ({this.uid, this.name});

  User.fromSnapshot(DocumentSnapshot snapshot){
    this.uid = snapshot.documentID;
    this.name = snapshot['name'] ?? '';
    this.email = snapshot['email'] ?? '';
  }

}