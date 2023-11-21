import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/controller/text_editing_controller.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/select_city_btn.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/select_city_container.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserPersonalDetailsRegistration3 extends StatefulWidget {
  const UserPersonalDetailsRegistration3({super.key});

  @override
  State<UserPersonalDetailsRegistration3> createState() =>
      _UserPersonalDetailsRegistration3State();
}

class _UserPersonalDetailsRegistration3State
    extends State<UserPersonalDetailsRegistration3> {
  TextEditingControllers controllers = TextEditingControllers();

  @override
  void dispose() {
    controllers.baranggayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedMunicipality;

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
            (userRole == "Farmer")
                ? Center(
                    child: SingleChildScrollView(
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
                          /*Dropd down button for selectin a municipality */
                          SelectCityDropDownBtn(
                            botton: Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: SelectCityBtn(
                                  onMunicipalitySelected: (municipality) {
                                    // Set the selected municipality
                                    selectedMunicipality = municipality;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Text box for entering a baranggay */
                          FarmSwapTextField(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: farmSwapSmoothGreen,
                            ),
                            controller: controllers.baranggayController,
                            label: const Text("Enter baranggay"),
                            isPassword: false,
                            onChanged: (text) {
                              // Capitalize the first letter of each word
                              controllers.baranggayController.text =
                                  toTitleCase(text);
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          // GestureDetector for the Next button
                          GestureDetector(
                            onTap: () {
                              // Check if a municipality is selected
                              if (selectedMunicipality != null &&
                                  controllers
                                      .baranggayController.text.isNotEmpty) {
                                // Set the selected municipality in your provider
                                Provider.of<UserDetailsProvider>(context,
                                        listen: false)
                                    .setBaranggay(
                                        controllers.baranggayController.text);
                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegister4);

                                // Navigate to the next screen
                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegister4);
                              } else {
                                // Show an error message or handle it in a way that makes sense for your app
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please make sure select a city/municipality and enter baranggay.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const FarmSwapGreenBtn(text: "Next"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/karl_assets/images/consumer.png"),
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
                          /*Dropd down button for selectin a municipality */
                          SelectCityDropDownBtn(
                            botton: Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: SelectCityBtn(
                                  onMunicipalitySelected: (municipality) {
                                    // Set the selected municipality
                                    selectedMunicipality = municipality;
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*Text box for entering a baranggay */
                          FarmSwapTextField(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: farmSwapSmoothGreen,
                            ),
                            controller: controllers.baranggayController,
                            label: const Text("Enter baranggay"),
                            isPassword: false,
                            onChanged: (text) {
                              // Capitalize the first letter of each word
                              controllers.baranggayController.text =
                                  toTitleCase(text);
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Check if a municipality is selected
                              if (selectedMunicipality != null &&
                                  controllers
                                      .baranggayController.text.isNotEmpty) {
                                // Set the selected municipality in your provider
                                Provider.of<UserDetailsProvider>(context,
                                        listen: false)
                                    .setBaranggay(
                                        controllers.baranggayController.text);
                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegister6);

                                // Navigate to the next screen
                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegister6);
                              } else {
                                // Show an error message or handle it in a way that makes sense for your app
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please make sure select a city/municipality and enter baranggay.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const FarmSwapGreenBtn(text: "Next"),
                          ),
                        ],
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
}
