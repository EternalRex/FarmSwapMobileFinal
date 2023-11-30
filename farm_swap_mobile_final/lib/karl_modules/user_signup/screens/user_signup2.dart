// ignore_for_file: use_build_context_synchronously

import "package:farm_swap_mobile_final/authentication/user_authentication.dart";
import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/green_btn.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/controller/text_editing_controller.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart";
import "package:farm_swap_mobile_final/provider/user_type_provider.dart";
import "package:farm_swap_mobile_final/routes/routes.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

class UserPersonalDetailsRegistration extends StatefulWidget {
  const UserPersonalDetailsRegistration({super.key});

  @override
  State<UserPersonalDetailsRegistration> createState() =>
      _UserPersonalDetailsRegistrationState();
}

class _UserPersonalDetailsRegistrationState
    extends State<UserPersonalDetailsRegistration> {
/*Instance of the controller class*/
  static TextEditingControllers controllers = TextEditingControllers();

  //this is for the password visibility
  bool _isPasswordVisible = true; // Initialize it as true initially.

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<UserTypeProvider>(context, listen: false).getUserType;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (userRole == "Farmer") ...[
                          Image.asset(
                            "assets/karl_assets/images/farmer.png",
                            height: 270.sp,
                          ),
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
                        SizedBox(
                          height: 20.sp,
                        ),
                        /*Email text field */
                        FarmSwapTextField(
                          controller: controllers.emailController,
                          prefixIcon: Icon(
                            Icons.email,
                            color: farmSwapSmoothGreen,
                          ),
                          label: const Text("Enter email"),
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 17.sp,
                        ),
                        /*Password Text Field */
                        FarmSwapTextField(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: farmSwapSmoothGreen,
                          ),
                          controller: controllers.passwordController,
                          label: const Text("Enter Password"),
                          isPassword: _isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 46, 184, 76),
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        SizedBox(
                          height: 17.sp,
                        ),
                        /*Login btn with register email and password in authentication function */
                        GestureDetector(
                          child: const FarmSwapGreenBtnNew(
                            text: "Next",
                          ),
                          onTap: () {
                            _registerEmailPassword();
                          },
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final UserAuthentication _auth = UserAuthentication();
// Authentication registration function
  void _registerEmailPassword() async {
    String email = controllers.emailController.text;
    String password = controllers.passwordController.text;

    // Check if the email is valid
    if (!isValidEmail(email)) {
      // Invalid email, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email. Please enter a valid email address.'),
          backgroundColor: Colors.red,
        ),
      );

      // Navigate only if the email is invalid
      Navigator.of(context).pushNamed(RouteManager.userDetailsRegister);
      return; // Stop the registration process if the email is invalid
    }

    // Check if the email is available
    else if (await isEmailAvailable(email)) {
      // Check if the password meets the required criteria
      if (isPasswordValid(password)) {
        // Password is valid, proceed with registration
        await _auth.createEmailPassowrd(email, password);
        // After successful registration, this will show a success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your email and password have been successfully registered. You are now required to provide some additional information.',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushNamed(RouteManager.userDetailsRegister2);
      } else {
        // Password is not valid, this error message snackbar will show
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Invalid password. Please ensure it has at least 8 characters and includes a combination of letters and numbers.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pushNamed(RouteManager.userDetailsRegister);
      }
    } else {
      // Email is not available, this error message snackbar will show
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is already in use. Please choose another.'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pushNamed(RouteManager.userDetailsRegister);
    }
  }

// Function to check if the email is valid
  bool isValidEmail(String email) {
    // This is the email validation logic
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

// Function to check if the email is available
  Future<bool> isEmailAvailable(String email) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        // This is temporary just for checking email so provide a dummy password
        password: 'dummy password',
      );

      /*If the above line executes successfully, it means the email is available
       But we don't want to create an actual user, so we'll immediately delete the user.
      because are checking if the email has the same email*/
      await userCredential.user!.delete();

      return true;
    } catch (e) {
      // If there's an error, it means the email is not available
      return false;
    }
  }

// Function to check if the password is valid
  bool isPasswordValid(String password) {
    /*Password validation logic require at least 8 characters 
    and a combination of letters and numbers
    */
    return password.length >= 8 &&
        RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(password);
  }
}
