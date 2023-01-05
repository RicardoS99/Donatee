import 'dart:io';
import 'package:com/services/donationsdatabase.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Donation {
  String donationUID;
  String donorUID;
  String organizationUID;
  String donorName;
  String orgName;
  String subject;
  String mobileNumber;
  String description;
  String address;
  String status;
  List<String> urls;
  int nPhotos;
  List<File> pics;
  DateTime pickUpTime;
  String message;
  bool statusChanged;
  bool cancelled;
  bool active;

  Donation(
      {this.donationUID,
      this.donorUID,
      this.organizationUID,
      this.donorName,
      this.orgName,
      this.description,
      this.mobileNumber,
      this.subject,
      this.address,
      this.status,
      this.urls,
      this.nPhotos,
      this.pics,
      this.pickUpTime,
      this.message,
      this.statusChanged,
      this.cancelled,
      this.active});

  Future updateURLs() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    var temp = new List<String>();
    for (var pic in pics) {
      //Filename of picture
      String filename = basename(pic.path);
      //Location to upload picture
      print('Setting location attachments/$filename');
      StorageReference storageReference =
          storage.ref().child('attachments/$filename');
      //Uploading Picture
      print('uploading photo $filename');
      StorageUploadTask uploadTask = storageReference.putFile(pic);

      StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      temp.add(await downloadUrl.ref.getDownloadURL());
      print('Photo uploaded: $url');
    }
    this.urls = temp;
  }

  Future cachePics() async {
    if (nPhotos > 0) {
      print('Caching pics...');
      var temp = new List<File>();
      for (var url in urls) {
        print(url);
        temp.add(await DefaultCacheManager().getSingleFile(url));
        print('pic cached');
      }
      this.pics = temp;
      String done = 'Caching completed'; //Done Indicator
      print(done);
      return done;
    }
    return 'empty';
  }

  Future changePickUpTime(DateTime newPickUpTime) async {
    this.pickUpTime = newPickUpTime;
    await DonationDatabaseService().setPickUpTime(this);
  }

  Future cancel() async {
    this.status = 'Declined';
    this.cancelled = true;
    this.active = false;
    await DonationDatabaseService().cancelDonation(this);
  }
}
