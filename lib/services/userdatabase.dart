import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/models/user.dart';

class UserDatabaseService {
  final String uid;
  UserDatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future getUserData() async {
    return await usersCollection.document(uid).get();
  }

  Future updateUserData(String name, String email) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'email': email,
    });
  }

  User _snapshotToUser(DocumentSnapshot snapshot) {
      return User.fromSnapshot(snapshot);
  }

  //get user stream
  Stream<User> get user {
    return usersCollection.document(uid).snapshots().map(_snapshotToUser);
  }
}
