import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  int counter = 0;

  void setCounter() {
    counter++;
    notifyListeners();
  }

  String get getCounter {
    return counter.toString();
  }
}
