import 'package:farm_swap_mobile_final/karl_modules/user_signup/database/add_consumerdata_querry.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/model/consumeruser_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNewConsumerUserDb {
/*Instance of the database querry class */
  AddConsumerDataQuery consumerQuery = AddConsumerDataQuery();

  Future<void> insertConsumerData(
    String fname,
    String lname,
    String bplace,
    String contact,
    String munisipyo,
    String baranggay,
    String userNames,
    String idUrl,
    String profileUrl,
    DateTime bday,
    DateTime rday,
    double balance,
    int rating,
  ) async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    String? email = FirebaseAuth.instance.currentUser!.email;
    String firstName = fname;
    String lastName = lname;
    String birthplace = bplace;
    String contactNumber = contact;
    String cityMunicipality = munisipyo;
    String cityBaranggay = baranggay.toUpperCase();
    String accountStatus = "PENDING";
    String userRole = "CONSUMER";
    String userName = userNames;
    String idPictureProof = idUrl;
    String profilePhoto = profileUrl;
    DateTime birthdate = bday;
    DateTime registrationDate = rday;
    int swapCoins = 5000;
    double balance = 0;
    int rating = 0;

    final addData = ConsumerUserModel(
      userId: userid,
      email: email.toString(),
      firstName: firstName,
      lastName: lastName,
      birthplace: birthplace,
      contactNumber: contactNumber,
      cityMunicipality: cityMunicipality,
      cityBaranngay: cityBaranggay,
      accountStatus: accountStatus,
      userRole: userRole,
      userName: userName,
      idPictureProof: idPictureProof,
      birthdate: birthdate,
      registrationDate: registrationDate,
      swapCoins: swapCoins,
      isOnline: true,
      profilePhoto: profilePhoto,
      balance: balance,
      rating: rating,
    );

    await consumerQuery.createUser(addData);
  }
}
