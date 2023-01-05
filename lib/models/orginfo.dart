import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/services/orgsdatabase.dart';

class OrgInfo{
  String name;
  List <String> preferredItems;
  String description;
  String contact;
  String logoUrl;
  String organizationUID;

  OrgInfo({this.name, this.description, this.contact, this.logoUrl, this.organizationUID, this.preferredItems});

  OrgInfo.fromSnapshot(DocumentSnapshot snapshot){
    List<String> preferredItems = ['This organization has no preferred Item'];
    try {
      preferredItems = List.from(snapshot.data['preferredItems']);
    } catch(e){}

    this.organizationUID = snapshot.documentID;
    this.name = snapshot['Name'] ?? '';
    this.contact = snapshot['Contact'] ?? '';
    this.description = snapshot['Description'] ?? '';
    this.logoUrl = snapshot['LogoUrl'] ?? '';
    this.preferredItems=preferredItems;
  }

  Future updateLogoUrl(String url) async {
    logoUrl = url;
    OrgDatabaseService database = OrgDatabaseService();
    await database.updateUrl(this);
  }

  Future refreshProfile() async {
    OrgDatabaseService database = OrgDatabaseService(uid: this.organizationUID);
    DocumentSnapshot doc = await database.getOrgData();
    this.description = doc['Description'];
    this.contact = doc['Contact'];
    this.logoUrl = doc['LogoUrl'];
    this.preferredItems = new List<String>.from(doc.data['preferredItems']);
  }
}