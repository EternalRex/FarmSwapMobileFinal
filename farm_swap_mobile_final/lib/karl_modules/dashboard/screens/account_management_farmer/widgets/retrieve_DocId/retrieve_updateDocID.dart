// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

//para ni sa pagkuha sa doc ID sa update account
class UpdateRetriveDocId {
  String mydocid = "";

  Future<String> getUpdateDocId(String userid) async {
    String myuserid = userid;

    CollectionReference reference =
        FirebaseFirestore.instance.collection('sample_FarmerUsers');
    QuerySnapshot query =
        await reference.where('userId', isEqualTo: myuserid).get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = query.docs.first;
      mydocid = documentSnapshot.id;
    } else {
      throw ("Failed id retieval");
    }
    return mydocid;
  }
}
