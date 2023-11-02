import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/account_management_farmer/widgets/retrieve_DocId/retrieve_updateDocID.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

UpdateRetriveDocId updateRetrieve = UpdateRetriveDocId();

//if this class will be called kay mo update ni siya sa each field sa drop down lists
class UpdateFields {
  //creating a function called updated firstname field to update the first name from the database
  Future<void> updateFirstNameField(
      BuildContext context, String? updatedata, String userid) async {
    //calling the getUpdateddocID function from the class UpdateRetrieve
    await updateRetrieve.getUpdateDocId(userid);

    /*Tapo didto gihapon sa  UpdateFirstNameRetriveDocId na clas ang kanang function na atong bag e gi call
    mo return nag string value which is ang documentid nga iyang gi butang sa variable nga mydocid*/
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"firstname": updatedata};

    /*So mag kuha ni siya sa admin logs nya iyang description kay ni first name */
    // adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //   "Update_Detail_First_Name", DateTime.now());

    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to admin user details of the specific admin
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function updateLastNameField is the same process as what the other function does
  Future<void> updateLastNameField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"lastname": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni last name */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Last_Name", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to admin user details of the specific admin
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update email address field is the same process as what the other function does
  Future<void> updateEmailField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"email": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update password field is the same process as what the other function does
  Future<void> updatePasswordField(
      BuildContext context, String? updatedata, String userid) async {
    User? user = FirebaseAuth.instance.currentUser;

    // this line will update the password in Firebase Authentication
    await user?.updatePassword(updatedata!);
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"password": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update contact address field is the same process as what the other function does
  Future<void> updateContactNumField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"contactnum": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update birth place field is the same process as what the other function does
  Future<void> updateBirthPlaceField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"birthplace": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update birth date field is the same process as what the other function does
  Future<void> updateBirthdateField(
      BuildContext context, DateTime updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);
    final updateFiled = {"birthdate": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni update birthdate */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Birthdate", DateTime.now());
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update baranggay field is the same process as what the other function does
  Future<void> updateBaranggayField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"city_baranggay": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update municipality field is the same process as what the other function does
  Future<void> updateMunicipalityField(
      BuildContext context, String? updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);

    final updateFiled = {"city_municipality": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni email */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Email", DateTime.now());
    /*
    after the updated data is being naay sud ma update na na siya adtu sa database 
    then navigate to farmer details of the specific farmer
    */
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }

  //the function update registration date field is the same process as what the other function does
  Future<void> updateRegDateField(
      BuildContext context, DateTime updatedata, String userid) async {
    await updateRetrieve.getUpdateDocId(userid);
    final documentref = FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .doc(updateRetrieve.mydocid);
    final updateFiled = {"registrationDate": updatedata};
    /*So mag kuha ni siya sa admin logs nya iyang description kay ni update birthdate */
    //adminLogs.createAdminLogs(email, FirebaseAuth.instance.currentUser!.uid,
    //  "Update_Detail_Birthdate", DateTime.now());
    await documentref.update(updateFiled);
    Navigator.of(context).pushNamed(RouteManager.farmeraccountmanagement);
  }
}
