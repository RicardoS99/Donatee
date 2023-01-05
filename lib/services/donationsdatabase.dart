import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/models/donation.dart';

class DonationDatabaseService {
  final String uid;
  DonationDatabaseService({this.uid});

  //Donation collection reference
  final CollectionReference donationCollection =
      Firestore.instance.collection('donations');

  Future getDonData() async {
    return await donationCollection.document(uid).get();
  }

  List<Donation> _snapshotToDonation(QuerySnapshot data) {
    return data.documents.map((doc) {
      //where we fetch the organizations to be displayed (userhome) we only use the class
      //OrgInfo to fetch the organization info from firebase. Here the class Donations is
      //used both to store information in firebase and to get that information back.
      try {
        return Donation(
          donationUID: doc.documentID,
          status: doc.data['Status'] ?? '',
          organizationUID: doc.data['Organization UID'] ?? '',
          donorUID: doc.data['Donor UID'] ?? '',
          orgName: doc.data['Organization Name'] ?? '',
          donorName: doc.data['Donor Name'] ?? '',
          subject: doc.data['Subject'] ?? '',
          description: doc.data['Description'] ?? '',
          mobileNumber: doc.data['Donor Contact'] ?? '',
          address: doc.data['Address'] ?? '',
          nPhotos: doc.data['Number Attachments'] ?? 0,
          urls: doc.data['URLs'] != null
              ? new List<String>.from(doc.data['URLs'])
              : null, //Converting List<Dynamic> to List<String>

          pickUpTime: doc.data['PickUpTime'] != null
              ? doc.data['PickUpTime'].toDate()
              : null,
          message: doc.data['Message'] ?? '',
          statusChanged: doc.data['StatusChanged'] ?? false,
          cancelled: doc.data['Cancelled'] ?? false,
          active: doc.data['Active'] ?? false,
        );
      } catch (error) {
        print(error.toString());
        return Donation(
          donationUID: doc.documentID,
          status: doc.data['Status'] ?? '',
          organizationUID: doc.data['Organization UID'] ?? '',
          donorUID: doc.data['Donor UID'] ?? '',
          orgName: doc.data['Organization Name'] ?? '',
          donorName: doc.data['Donor Name'] ?? '',
          subject: doc.data['Subject'] ?? '',
          description: doc.data['Description'] ?? '',
          mobileNumber: doc.data['Donor Contact'] ?? '',
          address: doc.data['Address'] ?? '',
          nPhotos: doc.data['Number Attachments'] ?? 0,
          urls: doc.data['URLs'] != null
              ? new List<String>.from(doc.data['URLs'])
              : null, //Converting List<Dynamic> to List<String>
          message: doc.data['Message'] ?? '',
          statusChanged: doc.data['StatusChanged'] ?? false,
          cancelled: doc.data['Cancelled'] ?? false,
          active: doc.data['Active'] ?? false,
        );
      }
    }).toList();
  }

  //this function takes in a Donation (/models/donation)
  //which is created in the /screens/user/newdonation screen and
  //from that donation creates a firebase document containing the information.
  Future createdDonation(Donation donation) async {
    print("Creating Donation...");
    await donationCollection.document().setData({
      "Donor UID": donation.donorUID, //User UID
      "Donor Contact": donation.mobileNumber, //User Contact
      "Donor Name": donation.donorName, //User Name
      "Organization Name": donation.orgName, //Organization Name
      "Organization UID": donation.organizationUID, //Organization UID
      "Description": donation.description, //Donation's Description
      "Subject": donation.subject, //Subject of Donation
      "Address": donation.address, //Pick Up address
      "URLs": donation.urls, //Attachments URLs
      "Number Attachments": donation.nPhotos, //Number of attachments
      "Status": "Pending", //Current Donation's status
      "CreatedAt": FieldValue.serverTimestamp(), //Timestamp of creation
      "FinishedAt": null,
      "PickUpTime": null, //Time that organization will pick up the donation
      "Active":
          true, //Boolean translating if the current status of the donation is active (Pending or Accepted)
      "StatusChanged":
          false, //Boolean used to notify user about changes in donations' status
      "Message":
          "", //Notification message regarding non-status'changes (Ex: "$org.name set Pick Up Time"). When set to "", there is no notification.
      "Cancelled":
          false, //Boolean used to notify organization that the donor (user) cancelled the donation
    });
  }

  //Streams to retrieve donations
  //When combining multiple where() and orderBy() firebase can throw an error with a link to create the corresponding index
  //Just click the link and follow the instructions to create the index

  Stream<List<Donation>> get mydonations {
    return donationCollection
        .where("Donor UID", isEqualTo: uid)
        .orderBy("CreatedAt")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get pendingdonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Status", isEqualTo: "Pending")
        .orderBy("CreatedAt")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get accepteddonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Status", isEqualTo: "Accepted")
        .orderBy("PickUpTime")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get declineddonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Status", isEqualTo: "Declined")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get completeddonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Status", isEqualTo: "Completed")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get historydonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Active", isEqualTo: false)
        .orderBy("FinishedAt")
        .snapshots()
        .map(_snapshotToDonation);
  }

  Stream<List<Donation>> get activedonations {
    return donationCollection
        .where("Organization UID", isEqualTo: uid)
        .where("Active", isEqualTo: true)
        .snapshots()
        .map(_snapshotToDonation);
  }

  //Methods to update Donations' Fields

  //Accept Donation
  Future acceptDonation(Donation donation) async {
    await donationCollection
        .document(donation.donationUID)
        .updateData({"Status": "Accepted", "StatusChanged": true});
  }

  //Decline Donation
  Future declineDonation(Donation donation) async {
    await donationCollection.document(donation.donationUID).updateData({
      "Status": "Declined",
      "Active": false,
      "StatusChanged": true,
      "FinishedAt": FieldValue.serverTimestamp()
    });
  }

  //Complete Donation
  Future completeDonation(Donation donation) async {
    await donationCollection.document(donation.donationUID).updateData({
      "Status": "Completed",
      "Active": false,
      "StatusChanged": true,
      "FinishedAt": FieldValue.serverTimestamp()
    });
  }

  //Cancel Donation
  Future cancelDonation(Donation donation) async {
    await donationCollection.document(donation.donationUID).updateData({
      "Status": "Declined",
      "Active": false,
      "Cancelled": true,
      "FinishedAt": FieldValue.serverTimestamp(),
      'Message': 'Cancelled'
    });
  }

  //Set Pick Up Time
  Future setPickUpTime(Donation donation) async {
    await donationCollection.document(donation.donationUID).updateData({
      "PickUpTime": Timestamp.fromMillisecondsSinceEpoch(
          donation.pickUpTime.millisecondsSinceEpoch),
      "Message": 'New Pick Up Date Set.'
    });
  }

  //Set Donation as read by User
  Future userOpenDonation(Donation donation) async {
    await donationCollection
        .document(donation.donationUID)
        .updateData({"StatusChanged": false, "Message": ""});
  }

  //Set Donation as read by Org
  Future orgOpenDonation(Donation donation) async {
    await donationCollection
        .document(donation.donationUID)
        .updateData({"Message": ''});
  }
}
