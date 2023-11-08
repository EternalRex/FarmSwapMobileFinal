import 'package:flutter/material.dart';

class DashboardTypeProvider extends ChangeNotifier {
  String type = "";

  void setDashboardType(String dashType) {
    type = dashType;
    notifyListeners();
  }

  String get getDashboardType {
    return type;
  }
}
