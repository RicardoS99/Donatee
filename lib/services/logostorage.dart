import 'dart:io';
import 'package:com/models/orginfo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LogoStorage {
  final OrgInfo org;
  LogoStorage({this.org});

  FirebaseStorage _storage = FirebaseStorage.instance;
  File _logo;
  String _filename;
  String _url;

  //Choose Logo From Gallery
  Future _chooseFile() async {
    _logo = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1280, maxWidth: 1280);
    if(_logo!=null){
      _filename = basename(_logo.path);
    }  
  }

  //Upload Logo to Firebase Storage
  Future _uploadFile() async {
    //Location to upload logo
    StorageReference storageReference =
        _storage.ref().child('logos/$_filename');
    //Uploading Logo
    StorageUploadTask uploadTask = storageReference.putFile(_logo);

    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    _url = (await downloadUrl.ref.getDownloadURL());
  }

  //Change Logo
  Future changeLogo() async {
    await _chooseFile();
    if(_filename!=null){
      await _uploadFile();
      await org.updateLogoUrl(_url);
      return "done";
    }
    return "cancelled";
  }
}
