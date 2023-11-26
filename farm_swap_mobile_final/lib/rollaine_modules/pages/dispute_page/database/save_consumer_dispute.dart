import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/consumer/barter_dispute_model.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/model/consumer/sale_dispute_model.dart';

class SaveCBarterDispute {
  Future<void> addCBarterDispute(
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
    String listingQuan,
    String listingStatus,
    String listingUrl,
    bool isResolved,
    String farmerDisputeStatus,
    String farmerDisputeText,
    String farmerDisputeUrl,
  ) async {
    final cBarterDispute = BarterDisputeModel(
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
        listingQuan: listingQuan,
        listingStatus: listingStatus,
        listingUrl: listingUrl);

    String disputeId = 'DISPUTE';
    String finalId = '$disputeId$consumerId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_ConsumerBarterDispute')
        .doc(finalId)
        .collection('cBarterDispute')
        .add(cBarterDispute.toMap());
  }
}

class SaveCSaleDispute {
  Future<void> addCSaleDispute(
    double addedAmnt,
    String cBarangay,
    String cLname,
    String cMunicipality,
    String cName,
    String cUrl,
    String cUname,
    String cId,
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
    final cSaleDispute = SaleDisputeModel(
        addedAmnt: addedAmnt,
        cBarangay: cBarangay,
        cLname: cLname,
        cMunicipality: cMunicipality,
        cName: cName,
        cUrl: cUrl,
        cUname: cUname,
        cId: cId,
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
    String finalId = '$disputeId$cId';

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection('sample_ConsumerSaleDispute')
        .doc(finalId)
        .collection('cSaleDispute')
        .add(cSaleDispute.toMap());
  }
}
