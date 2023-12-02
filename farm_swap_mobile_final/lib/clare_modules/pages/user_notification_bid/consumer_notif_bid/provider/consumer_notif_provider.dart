//It's a provider class that can notify its listeners when its data changes.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsumerNotificationProvider extends ChangeNotifier {
  int incrementor = 0;
  List<String> receiverId = [];

/*This will increment the notification count of a user */
  void setIncrement(String receiverid) {
    receiverId = [receiverid];
    incrementor++;
    notifyListeners();
  }

/*This will be the one to return the number of notifications, so this will look every element of an array
which is the different receiverid's and check if that receiver id is simillar to the id of the user who logged in
if it is then it will return the specific number of notification for that user*/
  String getNotifNum() {
    for (String element in receiverId) {
      if (element == FirebaseAuth.instance.currentUser!.uid) {
        return incrementor.toString();
      } else {
        return "";
      }
    }
    return "";
  }

  /*This method will erase the number of notifications once the user clicks on the bell icon*/
  /*This method will erase the number of notifications once the user clicks on the bell icon*/
  String decrementNotif() {
    for (String element in receiverId) {
      if (element == FirebaseAuth.instance.currentUser!.uid) {
        incrementor = 0; // Set the count to 0 directly
        notifyListeners();
        return "0";
      }
    }
    return "0";
  }
}
