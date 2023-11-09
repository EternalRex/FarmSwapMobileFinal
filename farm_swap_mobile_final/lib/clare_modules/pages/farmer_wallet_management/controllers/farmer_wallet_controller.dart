import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextEditingControllers {
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
      TextEditingController(text: "pending");
  TextEditingController profileController = TextEditingController();

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();

  TextEditingControllers() {
    // Initialize your controllers
    userIdController.text = FirebaseAuth.instance.currentUser!.uid;

    // Use await to get first name,  last name, user role and profile photo
    initializeFarmerFields();
  }

  Future<void> initializeFarmerFields() async {
    String firstName = await farmerDetails.getFarmerFirstname();
    String lastName = await farmerDetails.getLastName();
    String userrole = await farmerDetails.getFarmerUserRole();
    String profile = await farmerDetails.getFarmerUserProfilePhoto();

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    userRoleController.text = userrole;
    profileController.text = profile;
  }
}
