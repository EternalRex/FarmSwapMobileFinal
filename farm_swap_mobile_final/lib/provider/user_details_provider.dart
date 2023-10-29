import 'package:flutter/material.dart';

/*Ang kani na provider is ato gigamit para mag karga sa data sa usser registration aron
ig abot sa kinalasan nga page sa registration , ma usa ra og save sa database tanan didto
sa last page sa  registration */

class UserDetailsProvider extends ChangeNotifier {
  /*Properties*/
  String userId = "";
  String email = "";
  String firstName = "";
  String lastName = "";
  String birthplace = "";
  String contactNumber = "";
  String cityMunicipality = "";
  String cityBaranggay = "";
  String accountStatus = "";
  String userRole = "";
  String userName = "";
  String documentPictureProof = "";
  String idPictureProof = "";
  String profilePhoto = "";
  DateTime birthdate = DateTime.now();
  DateTime registrationDate = DateTime.now();
  int swapCoins = 0;

  /*Setter and getter methods for userid*/
  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }

  String get getUserId {
    return userId;
  }

  /*Setter and getter for email */
  void setEmail(String emails) {
    email = emails;
    notifyListeners();
  }

  String get getUserEmail {
    return email;
  }

  /*Setter and getter for firstname*/
  void setFirstname(String fname) {
    firstName = fname;
    notifyListeners();
  }

  String get getFirstname {
    return firstName;
  }

  /*Setter and getter for lastname */
  void setLastName(String lname) {
    lastName = lname;
    notifyListeners();
  }

  String get getLastName {
    return lastName;
  }

/*Setter and getter for birthplace*/
  void setBirthplace(String birthplaces) {
    birthplace = birthplaces;
    notifyListeners();
  }

  String get getBirthplace {
    return birthplace;
  }

  /*Setter and getter for contact number */

  void setContactNumber(String num) {
    contactNumber = num;
    notifyListeners();
  }

  String get getContactNum {
    return contactNumber;
  }

  /*Setter and getter for city/municipality */
  void setCityMunicipality(String municipality) {
    cityMunicipality = municipality;
    notifyListeners();
  }

  String get getCityMunicipality {
    return cityMunicipality;
  }

  /*Setters and getter for city barranggay*/
  void setBaranggay(String baranggay) {
    cityBaranggay = baranggay;
    notifyListeners();
  }

  String get getBaranggy {
    return cityBaranggay;
  }

  /*Setter and getter for account status*/
  void setAccountStataus(String status) {
    accountStatus = status;
    notifyListeners();
  }

  String get getAccountStatus {
    return accountStatus;
  }

  /*Setter and getter for userRolev */
  void setUserRole(String role) {
    userRole = role;
    notifyListeners();
  }

  String get getUserRole {
    return userRole;
  }

  /*Setter and getter for username*/
  void setUsername(String uname) {
    userName = uname;
    notifyListeners();
  }

  String get getUsername {
    return userName;
  }

  /*Setter and getter for document picture */
  void setDocumentPicture(String docUrl) {
    documentPictureProof = docUrl;
    notifyListeners();
  }

  String get getDocUrl {
    return documentPictureProof;
  }

  /*Setter and getter for the id picture */
  void setIdPicture(String idUrl) {
    idPictureProof = idUrl;
    notifyListeners();
  }

  String get getPictureUrl {
    return idPictureProof;
  }

  /*Setter and getter for the profile */
  void setProfilPicture(String idUrl) {
    profilePhoto = idUrl;
    notifyListeners();
  }

  String get getProfilePhoto {
    return profilePhoto;
  }

  /*Setter and getter for birthdate */
  void setBirthdate(DateTime bday) {
    birthdate = bday;
    notifyListeners();
  }

  DateTime get getBirthdate {
    return birthdate;
  }

  /*Setter and getter for registration date */
  void setRegisterDate(DateTime regday) {
    registrationDate = regday;
    notifyListeners();
  }

  DateTime get getRegistrationDay {
    return registrationDate;
  }

  /*Setter and getter for swapcoins*/
  void setSwapCoins(int swapc) {
    swapCoins = swapc;
    notifyListeners();
  }

  int get getSwapCoins {
    return swapCoins;
  }
}
