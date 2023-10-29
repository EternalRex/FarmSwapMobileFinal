/*kani na provider is mag carry ni siya sa value nga e return sa usa ka bottom 
sa listing bottom navbar nya gamiton nato iya value para mag switch2 og display
solod sa listing main page*/

import 'package:flutter/material.dart';

class ListingPageProvider extends ChangeNotifier {
  String listingPage = "";

  void setListingPage(String page) {
    listingPage = page;
    notifyListeners();
  }

  String get getListingPage {
    return listingPage;
  }
}
