import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/model/farmeruser_model.dart';

/*CREATED A CLASS THAT CONTAINS AN ASYNC METHOD THAT WILL SAVE OUR PROPERTIES
FROM SIGN UP CLASS MODEL USING THE JSON FORMAT*/
class AddFarmerDataQuery {
  /*WE CREATED A VARIABLE THAT IS AN INSTANCE TO THE FIREBASE FIRESTORE CLASS
  THIS INSTANCE WILL BE USED TO ACCESS ALL THE METHODS AND FUNCTIONS PROVIDED IN THE 
  FIREBASE FIRESTORE CLASS */
  final _db = FirebaseFirestore.instance;

/*WE CREATED A CREATE USER METHOD, IT HAS A PARAMETER OF SIGNUP MODEL, THIS SIGN UP
MODEL TYPE OF PARAMETER  IS THE ONE WE CREATED IN A SEPARATE CLASS,  */
  createUser(FarmerUserModel user) async {
    /*IN THIS PART OF THE CODE, IT MEANS THAT USING THE INSTANCE OF FIREBASE WE 
    ACCESS THE COLLECTION METHOD, AND WE PULL OUT THE COLLECTION WHICH "USER" TO DETERMINE
    WHICH COLLECTION IN THE DATABASE WILL THE BE SAVED, WE USE THE ADD METHOD ALSO, TO
    SPECIFY THE PROPERTY THAT CARRIES THE DATAS TO BE SAVED AND CONVERT INTO A TOJSON FORMAT */
    await _db.collection("sample_FarmerUsers").add(user.toMap());
  }
}