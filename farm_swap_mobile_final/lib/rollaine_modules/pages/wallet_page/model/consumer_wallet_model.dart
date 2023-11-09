class ConsumerWalletModel {
  ConsumerWalletModel({
    required this.role,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.address,
    required this.date,
    required this.amount,
    required this.proofPayment,
    required this.status,
    required this.requests,
    required this.profilePhoto,
  });

  String role;
  String userId;
  String firstName;
  String lastName;
  String contactNumber;
  String address;
  DateTime date;
  double amount;
  String proofPayment;
  String status;
  String requests;
  String profilePhoto;

  Map<String, dynamic> toMap() {
    return {
      'userRole': role,
      'userId': userId,
      'firstname': firstName,
      'lastname': lastName,
      'contactnum': contactNumber,
      'address': address,
      'dateTime': date,
      'amount': amount,
      'proofPhoto': proofPayment,
      'status': status,
      'request': requests,
      'profilePhoto': profilePhoto
    };
  }
}
