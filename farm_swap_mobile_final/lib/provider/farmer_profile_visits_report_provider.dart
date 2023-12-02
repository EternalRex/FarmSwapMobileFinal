import 'package:flutter/foundation.dart';

class FarmerProfileVisitsProvider extends ChangeNotifier {
  String consumerName = "";
  String consumerLname = "";
  String consumerUserName = "";
  String consumerUrl = "";
  String consumerBarangay = "";
  String consumerMunicipal = "";

  void setConsumerName(String consName) {
    consumerName = consName;
    notifyListeners();
  }

  String get getConsumerName {
    return consumerName;
  }

  void setConsumerLName(String consLName) {
    consumerLname = consLName;
    notifyListeners();
  }

  String get getConsumerLName {
    return consumerLname;
  }

  void setConsumerUName(String consUName) {
    consumerUserName = consUName;
    notifyListeners();
  }

  String get getConsumerUName {
    return consumerUserName;
  }

  void setConsumerUrl(String consUrl) {
    consumerUrl = consUrl;
    notifyListeners();
  }

  String get getConsumerUrl {
    return consumerUrl;
  }

  void setConsumerBarangay(String barangay) {
    consumerBarangay = barangay;
    notifyListeners();
  }

  String get getConsumerBarangay {
    return consumerBarangay;
  }

  void consumerMunicipality(String municipality) {
    consumerMunicipal = municipality;
    notifyListeners();
  }

  String get getConsMunicipality {
    return consumerMunicipal;
  }
}
