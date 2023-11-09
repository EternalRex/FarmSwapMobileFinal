import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/database/consumer_wallet_query.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/model/consumer_wallet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConsumerWalletDB {
/*Instance of the database querry class */
  AddWalletConsumerDataQuery walletConsumerQuery = AddWalletConsumerDataQuery();

  Future insertConsumerWalletData(
    String userole,
    String farmerId,
    String fname,
    String lname,
    String contactnum,
    String address,
    DateTime date,
    double amount,
    String proofPayment,
    String status,
    String request,
    String profilePhoto,
  ) async {
    String userRole = userole;
    String userid = FirebaseAuth.instance.currentUser!.uid;
    String firstName = fname;
    String lastName = lname;
    String contactnumber = contactnum;
    String farmeraddress = address;
    DateTime cashindate = date;
    double cashinamount = amount;
    String proof = proofPayment;
    String walletstatus = status;
    String walletrequest = request;
    String profile = profilePhoto;

    final addData = ConsumerWalletModel(
      role: userRole,
      userId: userid,
      firstName: firstName,
      lastName: lastName,
      contactNumber: contactnumber,
      address: farmeraddress,
      date: cashindate,
      amount: cashinamount,
      proofPayment: proof,
      status: walletstatus,
      requests: walletrequest,
      profilePhoto: profile,
    );

    await walletConsumerQuery.createUser(addData);
  }
}
