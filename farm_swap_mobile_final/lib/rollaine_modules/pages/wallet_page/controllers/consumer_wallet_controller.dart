import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsumerTextEditingControllers {
  TextEditingController userRoleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController proofController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController requestController = TextEditingController();
  TextEditingController statusController =
      TextEditingController(text: "PENDING");
  TextEditingController profileController = TextEditingController();

  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();

  ConsumerTextEditingControllers() {
    // Initialize your controllers
    userIdController.text = FirebaseAuth.instance.currentUser!.uid;

    // Use await to get first name,  last name, user role and profile photo
    initializeConsumerFields();
  }

  Future<void> initializeConsumerFields() async {
    String firstName = await consumerDetails.getConsumerFirstname();
    String lastName = await consumerDetails.getConsumerLastName();
    String userrole = await consumerDetails.getConsumerUserRole();
    String profile = await consumerDetails.getConsumerProfilePhoto();

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    userRoleController.text = userrole;
    profileController.text = profile;
  }
}
