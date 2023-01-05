import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/models/orginfo.dart';

class OrgDatabaseService{

  final String uid;
  OrgDatabaseService({ this.uid });

  //collection reference
  final CollectionReference orgsCollection = Firestore.instance.collection('orgs');

  Future getOrgData() async {
    return await orgsCollection.document(uid).get();
  }

  //function transforming a QuerySnapshot (firebase variable) to an OrganizationInfo (our class, defined in the models folder)
  List<OrgInfo> _snapshotToOrganization(QuerySnapshot data){
    return data.documents.map((doc){
      List<String> preferredItems = [];
      try {
        preferredItems = List.from(doc.data['preferredItems']);
      } catch(e){}

      return OrgInfo(
        organizationUID: doc.documentID,
        name: doc.data['Name'] ?? '',
        description: doc.data['Description'] ?? '',
        contact: doc.data['Contact'] ?? '',
        logoUrl: doc.data['LogoUrl'] ?? '',
        preferredItems: preferredItems,
      );
    }).toList();
  }

  //get org(a)s(m) stream
  //returns a stream of Lists of OrganizationInformation:
  //Anytime the database changes, the stream notices it and sends a new list of OrganizationInformation to be displayed to the user.
  Stream<List<OrgInfo>> get orgs {
    return orgsCollection.snapshots()
    .map(_snapshotToOrganization);
  }

  OrgInfo _snapshotToOrgInfo(DocumentSnapshot snapshot) {
      return OrgInfo.fromSnapshot(snapshot);
  }

  //get user stream
  Stream<OrgInfo> get org {
    //print("trying to get data");
    return orgsCollection.document(uid).snapshots().map(_snapshotToOrgInfo);
  }

  Future updateUrl(OrgInfo org) async {
    await orgsCollection
        .document(org.organizationUID)
        .updateData({"LogoUrl": org.logoUrl});
  }

  Future updateDescription(OrgInfo org, String newDescription) async{
    await orgsCollection
        .document(org.organizationUID)
        .updateData({"Description": newDescription});
  }

  Future updateContact(OrgInfo org, String contact) async{
    await orgsCollection
        .document(org.organizationUID)
        .updateData({"Contact": contact});
  }
  Future updatePreferredItems(OrgInfo org, List<String> newPreferredItems) async {
    await orgsCollection
        .document(org.organizationUID)
        .updateData({'preferredItems' : newPreferredItems});
  }
}