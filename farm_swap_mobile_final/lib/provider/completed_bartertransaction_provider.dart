import 'package:flutter/cupertino.dart';

class CompletedTransactionProvider extends ChangeNotifier {
  bool completionStatus = false;

  void setCompletedStatus(bool status) {
    completionStatus = status;
  }

  bool get getCompletedStatus {
    return completionStatus;
  }
}
