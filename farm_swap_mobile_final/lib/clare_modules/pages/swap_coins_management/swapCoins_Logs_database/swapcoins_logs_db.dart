import 'package:cloud_firestore/cloud_firestore.dart';

class SwapCoinsLogsInsertDataDb {
  SwapCoinsLogsSaving saving = SwapCoinsLogsSaving();

  Future<void> createSwapcoinsLogs(
    String? userId,
    String? userRole,
    String userFirstname,
    String userLastname,
    String address,
    String profilePhoto,
    DateTime activitydate,
    String status,
    double swapcoins,
  ) async {
    final swapcoinsLogs = SwapCoinsLogsModel(
      userId: userId,
      userRole: userRole,
      userFirstname: userFirstname,
      userLastname: userLastname,
      address: address,
      profilePhoto: profilePhoto,
      activitydate: activitydate,
      status: status,
      swapcoins: swapcoins,
    );
    saving.createSwapcoinsLogs(swapcoinsLogs);
  }
}

class SwapCoinsLogsSaving {
  final _db = FirebaseFirestore.instance;

  createSwapcoinsLogs(SwapCoinsLogsModel swapCoinsLogsModel) async {
    await _db
        .collection('sample_SwapCoinsLogs')
        .add(swapCoinsLogsModel.toJson());
  }
}

class SwapCoinsLogsModel {
  SwapCoinsLogsModel({
    required this.userId,
    required this.userRole,
    required this.userFirstname,
    required this.userLastname,
    required this.address,
    required this.profilePhoto,
    required this.activitydate,
    required this.status,
    required this.swapcoins,
  });

  String? userId;
  String? userRole;
  String userFirstname;
  String userLastname;
  String address;
  String profilePhoto;
  DateTime activitydate;
  String status;
  double swapcoins;

  toJson() {
    return {
      "userId": userId,
      "userRole": userRole,
      "firstname": userFirstname,
      "lastname": userLastname,
      "address": address,
      "profile": profilePhoto,
      "dateTime": activitydate,
      "status": status,
      "swapcoins": swapcoins,
    };
  }
}
