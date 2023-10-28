import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/controller/text_editing_controller.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../../common/green_btn.dart';

class UserPersonalDetailsRegistration2 extends StatefulWidget {
  const UserPersonalDetailsRegistration2({super.key});

  @override
  State<UserPersonalDetailsRegistration2> createState() => _UserPersonalDetailsRegistration2State();
}

class _UserPersonalDetailsRegistration2State extends State<UserPersonalDetailsRegistration2> {
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
            (userRole == "Farmer")
                ? SingleChildScrollView(
                    child: Positioned(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/karl_assets/images/farmer.png"),
                            /*Header text */
                            poppinsText(
                              "Farmer Registration",
                              farmSwapTitlegreen,
                              20,
                              FontWeight.w500,
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            /*User name txt field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.person,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.userNameController,
                              label: const Text("Enter username"),
                              isPassword: false,
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*First name text field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.person,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.firstNameController,
                              label: const Text("Enter firstname"),
                              isPassword: false,
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
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*birthplace text field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.place,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.birthplaceController,
                              label: const Text("Enter birthplace"),
                              isPassword: false,
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
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*Current address text field */
                            GestureDetector(
                              onTap: () {
                                /*Putting all the inputs in our provider fucntion */
                                _putProvider(
                                  controllers.userNameController.text,
                                  controllers.firstNameController.text,
                                  controllers.lastNameController.text,
                                  controllers.birthplaceController.text,
                                  controllers.contactNumberController.text,
                                );
                                Navigator.of(context).pushNamed(RouteManager.userDetailsRegister3);
                              },
                              child: const FarmSwapGreenBtn(
                                text: "Next",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Positioned(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/karl_assets/images/consumer.png", height: 270.sp),
                            /*Header text */
                            poppinsText(
                              "Consumer Registration",
                              farmSwapTitlegreen,
                              20,
                              FontWeight.w500,
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            /*User name txt field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.person,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.userNameController,
                              label: const Text("Enter username"),
                              isPassword: false,
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*First name text field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.person,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.firstNameController,
                              label: const Text("Enter firstname"),
                              isPassword: false,
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
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*birthplace text field */
                            FarmSwapTextField(
                              prefixIcon: Icon(
                                Icons.place,
                                color: farmSwapSmoothGreen,
                              ),
                              controller: controllers.birthplaceController,
                              label: const Text("Enter birthplace"),
                              isPassword: false,
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
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            /*Current address text field */
                            GestureDetector(
                              onTap: () {
                                /*Putting all the inputs in our provider fucntion */
                                _putProvider(
                                  controllers.userNameController.text,
                                  controllers.firstNameController.text,
                                  controllers.lastNameController.text,
                                  controllers.birthplaceController.text,
                                  controllers.contactNumberController.text,
                                );
                                Navigator.of(context).pushNamed(RouteManager.userDetailsRegister3);
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
    Provider.of<UserDetailsProvider>(context, listen: false).setUserId(firebaseAuthUid);
    Provider.of<UserDetailsProvider>(context, listen: false).setEmail(firebaseAuthEmail.toString());
    Provider.of<UserDetailsProvider>(context, listen: false).setUsername(username);
    Provider.of<UserDetailsProvider>(context, listen: false).setFirstname(firstname);
    Provider.of<UserDetailsProvider>(context, listen: false).setLastName(lastname);
    Provider.of<UserDetailsProvider>(context, listen: false).setBirthplace(birthplace);
    Provider.of<UserDetailsProvider>(context, listen: false).setContactNumber(contact);
  }
}
