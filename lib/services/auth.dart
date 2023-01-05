import 'package:firebase_auth/firebase_auth.dart';
import 'package:com/models/user.dart';
import 'package:com/models/org.dart';
import 'package:com/services/userdatabase.dart';
import 'package:com/services/orgsdatabase.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
/*
  //create user obj from current user login
  Future userFromCurrentUser() async {
    dynamic result = await _auth.currentUser();
    return result != null ? _userFromFirebaseUser(result.uid) : null;
  }*/

  //get current user uid

  Future getCurrentUid() async {
    try{
      FirebaseUser user = await _auth.currentUser();
      return user.uid;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Org _orgFromFirebaseUser(FirebaseUser org){
    return org != null ? Org(uid: org.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //enter as organization
   Future signInOrg(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseorg = result.user;
      Org org = _orgFromFirebaseUser(firebaseorg);
      dynamic docresult = await OrgDatabaseService(uid: org.uid).getOrgData();
      if(result!=null && (docresult==null || !docresult.exists)){
        signOut();
        return null;
      }
      return docresult;

    }catch(e){
      print(e.toString());
      return null;
    }
  }



  //login with email & password

  Future signInEmail(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseuser = result.user;
      User user = _userFromFirebaseUser(firebaseuser);
      dynamic docresult = await UserDatabaseService(uid: user.uid).getUserData();
      if(result!=null && (docresult==null || !docresult.exists)){
        signOut();
        return null;
      }
      return docresult;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign up with email & password

  Future registerEmail(String email, String password, String name) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await UserDatabaseService(uid: user.uid).updateUserData(name, email);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //login with facebook

  //sign up with facebook

  //login with google

  //sign up with google

  //logout

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //forgot password

  Future<void> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
    
}

  
}