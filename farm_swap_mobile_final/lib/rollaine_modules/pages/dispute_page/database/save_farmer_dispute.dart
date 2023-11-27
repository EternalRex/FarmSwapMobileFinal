import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/farmer/sale_dispute_model.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/farmer/barter_dispute_model.dart';

class SaveFBarterDispute {
  /*Method that save the barter dispute to the database */
  Future<void> addFBarterDispute(
    /*Farmer Details */
    String farmerName,
    String farmerId,
    String farmerLastName,
    String farmerUname,
    String farmerBarangay,
    String farmerMunicipality,

    /*Consumer Details */
    String consumerName,
    String consumerId,
    String consumerUname,
    String consumserLastName,
    String consumerBarangay,
    String consumerMunicipality,

    /*Item details */
    String itemName,
    double itemValue,
    String itemUrl,
    String listingName,
    String listingId,
    String listingPrice,
    String listingUrl,
    bool isResolved,
    String farmerDisputeStatus,
    String farmerDisputeText,
    String farmerDisputeUrl,
    double deductedFSwapCoins,
    double deductedCSwapCoins,
    double average,
    String percentage,
    DateTime transactionTime,
  ) async {
    final fBarterDispute = BarterDisputeModel(
      farmerName: farmerName,
      farmerId: farmerId,
      farmerLastName: farmerLastName,
      farmerUname: farmerUname,
      farmerBarangay: farmerBarangay,
      farmerMunicipality: farmerMunicipality,
      consumerName: consumerName,
      consumerId: consumerId,
      consumerUname: consumerUname,
      consumserLastName: consumserLastName,
      consumerBarangay: consumerBarangay,
      consumerMunicipality: consumerMunicipality,
      itemName: itemName,
      itemValue: itemValue,
      itemUrl: itemUrl,
      farmerDisputeStatus: 'PENDING',
      isResolved: isResolved,
      disputeDateFile: DateTime.now(),
      farmerDisputeText: farmerDisputeText,
      farmerDisputeUrl: farmerDisputeUrl,
      listingId: listingId,
      listingName: listingName,
      listingPrice: listingPrice,
      listingUrl: listingUrl,
      deductedFarmerCoins: deductedFSwapCoins,
      deductedConsumerCoins: deductedCSwapCoins,
      averageValue: average,
      percentage: percentage,
      transactionDate: transactionTime,
    );

    String disputeId = 'DISPUTE';
    String finalId = '$disputeId$farmerId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_FarmerBarterDispute')
        .doc(finalId)
        .collection('fBarterDispute')
        .add(fBarterDispute.toMap());
  }

  /*Querry that will update the decline field to false */
  Future<void> updateDisputed(String listid, String itemUrl, farmerId, consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_BarterTransactions')
        .where('listingid', isEqualTo: listid)
        .where('itemUrl', isEqualTo: itemUrl)
        .where('farmerid', isEqualTo: farmerId)
        .where('consumerid', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'isDisputed': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }
}

class SaveFSaleDispute {
  Future<void> addFSaleDispute(
    double addedAmnt,
    String cBarangay,
    String cLname,
    String cMunicipality,
    String cName,
    String cUrl,
    String cUname,
    String deductFarm,
    String fBarangay,
    String fLname,
    String fMunicipality,
    String fName,
    String fUrl,
    String fUname,
    String fId,
    String lName,
    String lId,
    String lPrice,
    String lQuan,
    String lStatus,
    String lUrl,
    double pPrice,
    double pQuan,
    bool isResolved,
    String consumerDisputeStatus,
    String consumerDisputeText,
    String consumerDisputeUrl,
  ) async {
    final fSaleDispute = SaleDisputeModel(
        addedAmnt: addedAmnt,
        cBarangay: cBarangay,
        cLname: cLname,
        cMunicipality: cMunicipality,
        cName: cName,
        cUrl: cUrl,
        cUname: cUname,
        deductFarm: deductFarm,
        fBarangay: fBarangay,
        fLname: fLname,
        fMunicipality: fMunicipality,
        fName: fName,
        fUrl: fUrl,
        fUname: fUname,
        fId: fId,
        lName: lName,
        lId: lId,
        lPrice: lPrice,
        lQuan: lQuan,
        lStatus: lStatus,
        lUrl: lUrl,
        pPrice: pPrice,
        pQuan: pQuan,
        disputeDateFile: DateTime.now(),
        isResolved: isResolved,
        consumerDisputeStatus: 'PENDING',
        consumerDisputeText: consumerDisputeText,
        consumerDisputeUrl: consumerDisputeUrl);

    String disputeId = 'DISPUTE';
    String finalId = '$disputeId$fId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_FarmerSaleDispute')
        .doc(finalId)
        .collection('fSaleDispute')
        .add(fSaleDispute.toMap());
  }
}
