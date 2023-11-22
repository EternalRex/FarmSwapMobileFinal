import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/controller/text_editing_controller.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../../common/green_btn.dart';

class UserPersonalDetailsRegistration2 extends StatefulWidget {
  const UserPersonalDetailsRegistration2({super.key});

  @override
  State<UserPersonalDetailsRegistration2> createState() =>
      _UserPersonalDetailsRegistration2State();
}

class _UserPersonalDetailsRegistration2State
    extends State<UserPersonalDetailsRegistration2> {
  TextEditingControllers controllers = TextEditingControllers();

  @override
  void dispose() {
    controllers.userNameController.dispose();
    controllers.firstNameController.dispose();
    controllers.lastNameController.dispose();
    controllers.birthplaceController.dispose();
    controllers.contactNumberController.dispose();
    super.dispose();
  }

  // Declare a variable to track the availability status
  bool isUsernameAvailable = false;
  // Track if the user has inputted text
  bool hasUserInput = false;
// Track the validity of the contact number
  bool isContactNumberValid = true;
  // Track if the user has inputted a contact number
  bool hasContactNumberInput = false;

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<UserTypeProvider>(context).getUserType;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: -450.sp,
              bottom: 0.sp,
              child: SvgPicture.asset(
                "assets/karl_assets/icons/Pattern.svg",
                height: 100,
                width: 400,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  height: 800.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (userRole == "Farmer") ...[
                        Image.asset("assets/karl_assets/images/farmer.png"),
                        /*Header text */
                        poppinsText(
                          "Farmer Registration",
                          farmSwapTitlegreen,
                          20,
                          FontWeight.w500,
                        ),
                      ],
                      if (userRole != "Farmer") ...[
                        Image.asset(
                          "assets/karl_assets/images/consumer.png",
                          height: 270.sp,
                        ),
                        poppinsText(
                          "Consumer Registration",
                          farmSwapTitlegreen,
                          20,
                          FontWeight.w500,
                        ),
                      ],
                      SizedBox(height: 20.sp),

                      /*User name txt field */
                      FarmSwapTextField(
                        prefixIcon: Icon(
                          Icons.person,
                          color: farmSwapSmoothGreen,
                        ),
                        controller: controllers.userNameController,
                        label: const Text("Enter username"),
                        isPassword: false,
                        onChanged: (userNameController) async {
                          // Check for minimum length at least 4 letters // Check for minimum length atleast 4 letters
                          if (userNameController.length < 4) {
                            setState(() {
                              isUsernameAvailable = false;
                              hasUserInput = userNameController.isNotEmpty;
                            });
                            return;
                          }
                          // Call the function to check username availability
                          bool isAvailable = await checkUsernameAvailability(
                            userNameController,
                            userRole == 'Farmer'
                                ? 'sample_FarmerUsers'
                                : 'sample_ConsumerUsers',
                          );

                          // Update the UI based on the availability status
                          setState(() {
                            isUsernameAvailable = isAvailable;
                          });
                        },
                      ),

// Display a message based on the availability status and user input
                      Text(
                        hasUserInput
                            ? (isUsernameAvailable
                                ? 'Username is available.'
                                : 'This username is already in use or \ndoes not meet the minimum length requirement.')
                            : '', // Display nothing if no user input
                        style: TextStyle(
                          color:
                              isUsernameAvailable ? Colors.green : Colors.red,
                        ),
                      ),

                      SizedBox(height: 15.sp),
                      /*First name text field */
                      FarmSwapTextField(
                        prefixIcon: Icon(
                          Icons.person,
                          color: farmSwapSmoothGreen,
                        ),
                        controller: controllers.firstNameController,
                        label: const Text("Enter firstname"),
                        isPassword: false,
                        onChanged: (text) {
                          // Capitalize the first letter of each word
                          controllers.firstNameController.text =
                              toTitleCase(text);
                        },
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      /*Last name text field */
                      FarmSwapTextField(
                        prefixIcon: Icon(
                          Icons.person,
                          color: farmSwapSmoothGreen,
                        ),
                        controller: controllers.lastNameController,
                        label: const Text("Enter lastname"),
                        isPassword: false,
                        onChanged: (text) {
                          // Capitalize the first letter of each word
                          controllers.lastNameController.text =
                              toTitleCase(text);
                        },
                      ),

                      SizedBox(
                        height: 15.sp,
                      ),
                      /*birthplace text field */
                      FarmSwapTextField(
                        prefixIcon: Icon(
                          Icons.person,
                          color: farmSwapSmoothGreen,
                        ),
                        controller: controllers.birthplaceController,
                        label: const Text("Enter birthplace"),
                        isPassword: false,
                        onChanged: (text) {
                          // Capitalize the first letter of each word
                          controllers.birthplaceController.text =
                              toTitleCase(text);
                        },
                      ),

                      SizedBox(
                        height: 15.sp,
                      ),
                      /*Contact number text field */
                      FarmSwapTextField(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: farmSwapSmoothGreen,
                        ),
                        controller: controllers.contactNumberController,
                        label: const Text("Enter contact number"),
                        isPassword: false,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                              11), // Set the length limit to 11
                        ],
                        onChanged: (contactNumberController) {
                          setState(() {
                            hasContactNumberInput =
                                contactNumberController.isNotEmpty;
                            isContactNumberValid =
                                contactNumberController.length == 11;
                          });
                        },
                      ),

                      // Display a message based on the contact number validity and user input
                      Text(
                        hasContactNumberInput
                            ? (isContactNumberValid
                                ? 'Contact number is valid.'
                                : 'Please enter exactly 11 digits.')
                            : '', // Display nothing if no user input
                        style: TextStyle(
                          color:
                              isContactNumberValid ? Colors.green : Colors.red,
                        ),
                      ),

                      SizedBox(
                        height: 15.sp,
                      ),

                      GestureDetector(
                        onTap: () {
                          if (_validateFields()) {
                            /*Putting all the inputs in our provider function */
                            _putProvider(
                              controllers.userNameController.text,
                              controllers.firstNameController.text,
                              controllers.lastNameController.text,
                              controllers.birthplaceController.text,
                              controllers.contactNumberController.text,
                            );
                            Navigator.of(context).pushNamed(
                              RouteManager.userDetailsRegister3,
                            );
                          } else {
                            // Display an error message or take appropriate action
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please make sure that all fields are filled out.',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const FarmSwapGreenBtn(
                          text: "Next",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to capitalize the first letter of each word used in firstname, lastname and birthplace
  String toTitleCase(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text
        .split(' ')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }

  //this will check if the new username has the same username in the prev users
  Future<bool> checkUsernameAvailability(
    String userNameController,
    String collectionName,
  ) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('userName', isEqualTo: userNameController)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (e) {
      // Handle errors, e.g., connection issues, etc.
      print('Error checking username availability: $e');
      return false;
    }
  }

  //to make sure that the fields are filled in
  bool _validateFields() {
    // Add your validation logic here
    return controllers.userNameController.text.isNotEmpty &&
        controllers.firstNameController.text.isNotEmpty &&
        controllers.lastNameController.text.isNotEmpty &&
        controllers.birthplaceController.text.isNotEmpty &&
        controllers.contactNumberController.text.isNotEmpty;
  }

  void _putProvider(
    String username,
    String firstname,
    String lastname,
    String birthplace,
    String contact,
  ) {
    /*Getting the email and user id of the user */
    String firebaseAuthUid = FirebaseAuth.instance.currentUser!.uid;
    String? firebaseAuthEmail = FirebaseAuth.instance.currentUser!.email;
    /*Actual transfer of data to User Details Provider */
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setUserId(firebaseAuthUid);
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setEmail(firebaseAuthEmail.toString());
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setUsername(username);
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setFirstname(firstname);
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setLastName(lastname);
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setBirthplace(birthplace);
    Provider.of<UserDetailsProvider>(context, listen: false)
        .setContactNumber(contact);
  }
}
