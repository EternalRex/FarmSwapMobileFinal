import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/model/sell_transaction_model.dart';

class UpdateConfirmedOrder {
/*Querry ni para e update ang confirmed field into true kung e hit ni farmer ang confirmed button */
  Future<void> updateOrderConfirmed(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'confirmed': true, 'selected': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Querry that will update the decline field to false */
  Future<void> updateOrderDeclined(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'decline': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*updates the consumer completed field when the consumer marks the transaction as done */
  Future<void> updateOrderCompletedFarmer(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'purchaseIsComplete': true, 'completeDate': DateTime.now()});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*updates the consumer completed field when the consumer marks the transaction as done */
  Future<void> updateOrderCompletedConsumer(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'consumerCompleted': true, 'ConsumerCompletedDate': DateTime.now()});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*MO update sa field nga denied*/
  Future<void> updateOrderDenied(String listid, String consumerId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sellbuy')
        .where('listingId', isEqualTo: listid)
        .where('consumerId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'declined': true});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Mo update sa swapcoins field sa farmer*/
  /*Function para mo update kung pila nalay value sa swap coins ni farmer */
  Future<void> updateFarmerSwapCoins(String farmerId, double newSwapCoinBalance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: farmerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'swapcoins': newSwapCoinBalance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  /*Function na mo update sa wallet ni farmer na naaddan siya*/
  Future<void> updateFarmerWalletBalance(String farmerId, double balance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_FarmerUsers')
        .where('userId', isEqualTo: farmerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'balance': balance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*Function na mo update sa wallet ni consumer */
  Future<void> updateConsumerWalletBalance(String consumerId, double balance) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('sample_ConsumerUsers')
        .where('userId', isEqualTo: consumerId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'balance': balance});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

/*Function na m */
  Future<void> updateRemainingListingQuantity(String url, double quantity) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collectionGroup('sell')
        .where('listingpictureUrl', isEqualTo: url)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      try {
        await docRef.update({'listingQuantity': quantity});
      } catch (e) {
        print("Empty document para ma update ang selected property$e");
      }
    } else {
      throw Exception("Indexing Problem");
    }
  }

  Future<void> addSellingTransaction(
//Consumer Details
    String consProfileUrl,
    String consName,
    String consLName,
    String consUname,
    String consId,
    String consBarangay,
    String consMunicipality,

    /*Farmer Details */
    String farmerProfileUrl,
    String farmerName,
    String farmerLName,
    String farmerUname,
    String farmerId,
    String farmerBarangay,
    String farmerMunicipality,

    /*listing details*/
    String listingName,
    String listingId,
    String listingPrice,
    String listingQuantity,
    String listingUrl,

    /*Purchase details*/
    double purchaseQuantity,
    double purchaseTotalPrice,
    DateTime purchaseTime,
    bool isConfirmed,
    DateTime confirmedDate,
    String listingStatus,
    bool selected,

/*Computations*/
    double addedFarmerWalletAmount,
    double decutedFarmerSwapCoins,
    DateTime tranasctinDate,
  ) async {
    final sellTransaction = SellTransactionModel(
      consProfileUrl: consProfileUrl,
      consName: consName,
      consLName: consLName,
      consUname: consUname,
      consId: consId,
      consBarangay: consBarangay,
      consMunicipality: consMunicipality,
      farmerProfileUrl: farmerProfileUrl,
      farmerName: farmerName,
      farmerLName: farmerLName,
      farmerUname: farmerUname,
      farmerId: farmerId,
      farmerBarangay: farmerBarangay,
      farmerMunicipality: farmerMunicipality,
      listingName: listingName,
      listingId: listingId,
      listingPrice: listingPrice,
      listingQuantity: listingQuantity,
      listingUrl: listingUrl,
      purchaseQuantity: purchaseQuantity,
      purchaseTotalPrice: purchaseTotalPrice,
      purchaseTime: purchaseTime,
      isConfirmed: isConfirmed,
      selected: selected,
      confirmedDate: confirmedDate,
      listingStatus: listingStatus,
      addedFarmerWalletAmount: addedFarmerWalletAmount,
      decutedFarmerSwapCoins: decutedFarmerSwapCoins,
      tranasctinDate: tranasctinDate,
      isDisputed: false,
      isConsumerDisputed: false,
    );

    FirebaseFirestore.instance
        .collection('sample_SellingTransactions')
        .add(sellTransaction.toMap());
  }
}
