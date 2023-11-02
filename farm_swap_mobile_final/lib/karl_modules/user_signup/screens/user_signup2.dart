import "package:farm_swap_mobile_final/authentication/user_authentication.dart";
import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/green_btn.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/controller/text_editing_controller.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart";
import "package:farm_swap_mobile_final/provider/user_type_provider.dart";
import "package:farm_swap_mobile_final/routes/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

class UserPersonalDetailsRegistration extends StatefulWidget {
  const UserPersonalDetailsRegistration({super.key});

  @override
  State<UserPersonalDetailsRegistration> createState() => _UserPersonalDetailsRegistrationState();
}

class _UserPersonalDetailsRegistrationState extends State<UserPersonalDetailsRegistration> {
/*Instance of the controller class*/
  static TextEditingControllers controllers = TextEditingControllers();

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<UserTypeProvider>(context, listen: false).getUserType;

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
            /*If the farmer option is being pressed then display the registration for farmer */
            (userRole == "Farmer")
                ? Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
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
                              isPassword: false,
                            ),
                            SizedBox(
                              height: 17.sp,
                            ),
                            /*Login btn with register email and password in authentication function */
                            GestureDetector(
                              onTap: () {
                                _registerEmailPassword();
                                Navigator.of(context).pushNamed(RouteManager.userDetailsRegister2);
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
                /*If the consumer option is being pressed then display the registration for consumer */
                : SingleChildScrollView(
                    child: Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/karl_assets/images/consumer.png",
                                height: 270.sp,
                              ),
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
                                label: const Text("Enter password"),
                                isPassword: false,
                              ),
                              SizedBox(
                                height: 17.sp,
                              ),
                              /*Login btn with register email and password in authentication function */
                              GestureDetector(
                                onTap: () {
                                  _registerEmailPassword();
                                  Navigator.of(context)
                                      .pushNamed(RouteManager.userDetailsRegister2);
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
                  ),
          ],
        ),
      ),
    );
  }

  final UserAuthentication _auth = UserAuthentication();

  /*Authentication registration function */
  void _registerEmailPassword() async {
    String email = controllers.emailController.text;
    String password = controllers.passwordController.text;
    await _auth.createEmailPassowrd(email, password);
  }
}
