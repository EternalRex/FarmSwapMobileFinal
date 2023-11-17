import 'package:cloud_firestore/cloud_firestore.dart';

class BarterPromotionInsertDataDb {
  BarterPromotionSaving savingDb = BarterPromotionSaving();

  Future<void> createBarterPromotionLists(
    String profilePhoto,
    String? userId,
    String userFirstname,
    String userLastname,
    String address,
    String listingCategory,
    String listingPicture,
    String listingName,
    double listingPrice,
    String listingDescription,
    double listingQuantity,
    DateTime listingStartDate,
    DateTime listingEndDate,
    String prefferedItem,
    String status,
    double promotionfee,
  ) async {
    final barterpromotionlists = BarterPromotionListsModel(
      profilePhoto: profilePhoto,
      userId: userId,
      userFirstname: userFirstname,
      userLastname: userLastname,
      address: address,
      listingCategory: listingCategory,
      listingPicture: listingPicture,
      listingName: listingName,
      listingPrice: listingPrice,
      listingDescription: listingDescription,
      listingQuantity: listingQuantity,
      listingStartDate: listingStartDate,
      listingEndDate: listingEndDate,
      prefferedItem: prefferedItem,
      status: status,
      promotionfee: promotionfee,
    );
    savingDb.createBarterPromotionLists(barterpromotionlists);
  }
}

//for saving into the sample_PromotionListings in Database
class BarterPromotionSaving {
  final _db = FirebaseFirestore.instance;

  createBarterPromotionLists(
      BarterPromotionListsModel barterPromotionListsModel) async {
    await _db
        .collection('sample_PromotionListings')
        .add(barterPromotionListsModel.toJson());
  }
}

class BarterPromotionListsModel {
  BarterPromotionListsModel({
    required this.profilePhoto,
    required this.userId,
    required this.userFirstname,
    required this.userLastname,
    required this.address,
    required this.listingCategory,
    required this.listingPicture,
    required this.listingName,
    required this.listingPrice,
    required this.listingDescription,
    required this.listingQuantity,
    required this.listingStartDate,
    required this.listingEndDate,
    required this.prefferedItem,
    required this.status,
    required this.promotionfee,
  });

  String profilePhoto;
  String? userId;
  String userFirstname;
  String userLastname;
  String address;
  String listingCategory;
  String listingPicture;
  String listingName;
  double listingPrice;
  String listingDescription;
  double listingQuantity;
  DateTime listingStartDate;
  DateTime listingEndDate;
  String prefferedItem;
  String status;
  double promotionfee;

  toJson() {
    return {
      "profilePhoto": profilePhoto,
      "userId": userId,
      "firstname": userFirstname,
      "lastname": userLastname,
      "address": address,
      "listingCategory": listingCategory,
      "listingPicture": listingPicture,
      "listingName": listingName,
      "listingPrice": listingPrice,
      "listingDescription": listingDescription,
      "listingQuantity": listingQuantity,
      "listingStartDate": listingStartDate,
      "listingEndDate": listingEndDate,
      "preferredItem": prefferedItem,
      "status": status,
      "fee": promotionfee,
    };
  }
}
