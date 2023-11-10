import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerSwapCoinsLogsDb {
  ConsumerSwapCoinsLogsSaving saving = ConsumerSwapCoinsLogsSaving();

  Future<void> createConsumerSwapcoinsLogs(
    String? userId,
    String? userRole,
    DateTime activitydate,
    String status,
    double swapcoins,
  ) async {
    final consumerswapcoinslogs = ConsumerSwapCoinsLogsModel(
      userId: userId,
      userRole: userRole,
      activitydate: activitydate,
      status: status,
      swapcoins: swapcoins,
    );
    saving.createConsumerSwapCoinsLogs(consumerswapcoinslogs);
  }
}

class ConsumerSwapCoinsLogsSaving {
  final _db = FirebaseFirestore.instance;

  createConsumerSwapCoinsLogs(ConsumerSwapCoinsLogsModel consumerSwapCoinsLogsModel) async {
    await _db
        .collection('sample_SwapCoinsLogs')
        .add(consumerSwapCoinsLogsModel.toJson());
  }
}

class ConsumerSwapCoinsLogsModel {
  ConsumerSwapCoinsLogsModel({
    required this.userId,
    required this.userRole,
    required this.activitydate,
    required this.status,
    required this.swapcoins,
  });

  String? userId;
  String? userRole;
  DateTime activitydate;
  String status;
  double swapcoins;

  toJson() {
    return {
      "userId": userId,
      "userRole": userRole,
      "dateTime": activitydate,
      "status": status,
      "swapcoins": swapcoins,
    };
  }
}
