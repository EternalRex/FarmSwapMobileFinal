class FarmerUserModel {
  FarmerUserModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthplace,
    required this.contactNumber,
    required this.cityMunicipality,
    required this.cityBaranngay,
    required this.accountStatus,
    required this.userRole,
    required this.userName,
    required this.documentPictureProof,
    required this.idPictureProof,
    required this.birthdate,
    required this.registrationDate,
    required this.swapCoins,
    required this.isOnline,
  });

  String userId;
  String email;
  String firstName;
  String lastName;
  String birthplace;
  String contactNumber;
  String cityMunicipality;
  String cityBaranngay;
  String accountStatus;
  String userRole;
  String userName;
  String documentPictureProof;
  String idPictureProof;
  DateTime birthdate;
  DateTime registrationDate;
  int swapCoins;
  bool isOnline;

  Map<String, dynamic> toMap() {
    return {
      'accountStatus': accountStatus,
      'birthdate': birthdate,
      'birthplace': birthplace,
      'city_municipality': cityMunicipality,
      'city_baranggay': cityBaranngay,
      'contactnum': contactNumber,
      'documentProof': documentPictureProof,
      'email': email,
      'firstname': firstName,
      'idProof': idPictureProof,
      'lastname': lastName,
      'registrationDate': registrationDate,
      'userId': userId,
      'userName': userName,
      'userRole': userRole,
      'swapcoins': swapCoins,
      'isOnline': isOnline,
    };
  }
}
