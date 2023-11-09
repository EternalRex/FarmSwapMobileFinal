import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/model/consumer_wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*CREATED A CLASS THAT CONTAINS AN ASYNC METHOD THAT WILL SAVE OUR PROPERTIES
FROM SIGN UP CLASS MODEL USING THE JSON FORMAT*/
class AddWalletConsumerDataQuery {
  /*WE CREATED A VARIABLE THAT IS AN INSTANCE TO THE FIREBASE FIRESTORE CLASS
  THIS INSTANCE WILL BE USED TO ACCESS ALL THE METHODS AND FUNCTIONS PROVIDED IN THE 
  FIREBASE FIRESTORE CLASS */
  final _db = FirebaseFirestore.instance;

/*WE CREATED A CREATE USER METHOD, IT HAS A PARAMETER OF wallet MODEL, THIS SIGN UP
MODEL TYPE OF PARAMETER  IS THE ONE WE CREATED IN A SEPARATE CLASS,  */
  createUser(ConsumerWalletModel user) async {
    /*IN THIS PART OF THE CODE, IT MEANS THAT USING THE INSTANCE OF FIREBASE WE 
    ACCESS THE COLLECTION METHOD, AND WE PULL OUT THE COLLECTION WHICH "USER" TO DETERMINE
    WHICH COLLECTION IN THE DATABASE WILL THE BE SAVED, WE USE THE ADD METHOD ALSO, TO
    SPECIFY THE PROPERTY THAT CARRIES THE DATAS TO BE SAVED AND CONVERT INTO A TOJSON FORMAT */
    await _db.collection("sample_ConsumerWallet").add(user.toMap());
  }
}

class RetrieveDocID {
  String docID = "";
  FirebaseFirestore firestoreDatabase = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<String> getDocsId() async {
    //This line queries the 'Users' collection in Firestore and retrieves documents
    //where the 'User Id' field is equal to the current user's UID (userId).
    await firestoreDatabase
        .collection('sample_ConsumerWallet')
        .where('userId', isEqualTo: userId)
        .get()
        //It iterates through the documents in the result using .docs.forEach
        .then((value) => value.docs.forEach((element) {
              docID = element.reference.id;
            }));
    return docID;
  }
}
