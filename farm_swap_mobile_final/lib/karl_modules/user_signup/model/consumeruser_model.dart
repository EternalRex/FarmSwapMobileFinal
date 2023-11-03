class ConsumerUserModel {
  ConsumerUserModel({
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
    required this.idPictureProof,
    required this.profilePhoto,
    required this.birthdate,
    required this.registrationDate,
    required this.swapCoins,
    required this.isOnline,
    required this.balance,
    required this.rating,
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
  String idPictureProof;
  String profilePhoto;
  DateTime birthdate;
  DateTime registrationDate;
  int swapCoins;
  bool isOnline;
  double balance;
  int rating;

  Map<String, dynamic> toMap() {
    return {
      'accountStatus': accountStatus,
      'baranggay': cityBaranngay,
      'birthdate': birthdate,
      'birthplace': birthplace,
      'city_municipality': cityMunicipality,
      'contactnum': contactNumber,
      'email': email,
      'firstname': firstName,
      'idProof': idPictureProof,
      'lastname': lastName,
      'profilePhoto': profilePhoto,
      'registrationDate': registrationDate,
      'userId': userId,
      'userName': userName,
      'userRole': userRole,
      'swapcoins': swapCoins,
      'isOnline': isOnline,
      'balance': balance,
      'rating': rating,
    };
  }
}
