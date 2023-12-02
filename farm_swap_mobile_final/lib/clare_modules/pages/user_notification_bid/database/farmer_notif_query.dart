import 'package:cloud_firestore/cloud_firestore.dart';

//si consumer mo notify ni farmer which is kani na mga data kay ma add sa FarmerNotification
//if ang bid ma click
class FarmerNotificationQuerry {
  final String notifiAddId = "myNotif";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*Saving to the database*/
  Future<void> sendNotification(
      String senderId,
      String receiverId,
      String notifContent,
      String senderFName,
      String senderLName,
      notifDate,
      notifType) async {
    //creating a new notif
    FarmerNotificationModel farmerNotif = FarmerNotificationModel(
      notifSenderId: senderId,
      notifReceiverId: receiverId,
      notifMessage: notifContent,
      notifSenderFirstName: senderFName,
      notifSenderLastName: senderLName,
      notifDate: notifDate,
      notifCategory: notifType,
    );

    /*Diri na part is ang id sa collection is ang id sa receiver, since siya may makadawat sa notif therefore
    adto ma save sa iyahang collection ni receiver */

    //constructing the id of the collection
    String finalNotifId = "$notifiAddId$receiverId";

    //adding the new notification to the AdminNotificationCollection
    _firestore
        .collection("FarmerNotification")
        .doc(finalNotifId)
        .collection("farmernotifications")
        .add(
          farmerNotif.toMap(),
        );
  }

  Stream<QuerySnapshot> getFarmerNotifications(String userid) {
    /*Sa diri na part is ang userid atong gamit since mag pull out man ta sa mga notifications nga
    nadawat therefore, ang uid ni user atong gamiton, so same gihapon siya pagka construct ang id
    sa method sa ibabaw, kay ang kanang sendnotif gamiton na sa sender side, unya kaning getnotif 
    gamiton ni sa receiver side */

    //reconstructing the id to make sure it is simillar to the previously saved
    String finalNotifId = "$userid$notifiAddId";
    //pullouting the data using the reconstructed id because it is  surely the same to the saved one
    return _firestore
        .collection("FarmerNotification")
        .doc(finalNotifId)
        .collection("farmernotifications")
        .orderBy('notifDate', descending: true)
        .snapshots();
  }
}

//model for notifications consumer
class FarmerNotificationModel {
  FarmerNotificationModel({
    required this.notifSenderId,
    required this.notifReceiverId,
    required this.notifMessage,
    required this.notifSenderFirstName,
    required this.notifSenderLastName,
    required this.notifDate,
    required this.notifCategory,
  });

/*Notification model properties */
  String notifSenderId;
  String notifReceiverId;
  String notifMessage;
  String notifSenderFirstName;
  String notifSenderLastName;
  String notifCategory;
  DateTime notifDate;

/*Notification Model json mapping */
  Map<String, dynamic> toMap() {
    return {
      'notifSenderId': notifSenderId,
      'notifReceiverId': notifReceiverId,
      'notifMessage': notifMessage,
      'senderFName': notifSenderFirstName,
      'senderLName': notifSenderLastName,
      'notifDate': notifDate,
      'notifCateogry': notifCategory
    };
  }
}
