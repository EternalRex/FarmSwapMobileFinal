import 'package:farm_swap_mobile_final/karl_modules/user_signup/database/add_farmerdata_querry.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/model/farmeruser_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNewFarmerUserDb {
/*Instance of the database querry class */
  AddFarmerDataQuery farmerQuery = AddFarmerDataQuery();

  Future<void> insertFarmerData(
    String fname,
    String lname,
    String bplace,
    String contact,
    String munisipyo,
    String baranggay,
    String userNames,
    String docUrl,
    String idUrl,
    DateTime bday,
    DateTime rday,
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
    String userRole = "FARMER";
    String userName = userNames;
    String documentPictureProof = docUrl;
    String idPictureProof = idUrl;
    DateTime birthdate = bday;
    DateTime registrationDate = rday;
    int swapCoins = 5000;

    final addData = FarmerUserModel(
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
      documentPictureProof: documentPictureProof,
      idPictureProof: idPictureProof,
      birthdate: birthdate,
      registrationDate: registrationDate,
      swapCoins: swapCoins,
      isOnline: true,
    );

    await farmerQuery.createUser(addData);
  }
}
