import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/database/add_consumerdata_db.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/database/add_farmerdata_db.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserPersonalDetailsRegistration8 extends StatefulWidget {
  const UserPersonalDetailsRegistration8({super.key});

  @override
  State<UserPersonalDetailsRegistration8> createState() =>
      _UserPersonalDetailsRegistration8State();
}

class _UserPersonalDetailsRegistration8State
    extends State<UserPersonalDetailsRegistration8> {
  String registrationdates = "select registration date";
  String birthdates = "select birthdate";

  /*Instance of the class that will save our data*/
  AddNewFarmerUserDb farmerUser = AddNewFarmerUserDb();
  AddNewConsumerUserDb consumerUser = AddNewConsumerUserDb();

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<UserTypeProvider>(context, listen: false).getUserType;

/*getting all the values that we put in the provider to pass to the function
 that adds data to the database, we are doing it here, becasue we cannot call provider outside
 of the build method*/

    String fname =
        Provider.of<UserDetailsProvider>(context, listen: false).getFirstname;
    String lname =
        Provider.of<UserDetailsProvider>(context, listen: false).getLastName;
    String birthplaces =
        Provider.of<UserDetailsProvider>(context, listen: false).getBirthplace;
    String contactNum =
        Provider.of<UserDetailsProvider>(context, listen: false).getContactNum;
    String municipalitys =
        Provider.of<UserDetailsProvider>(context, listen: false)
            .getCityMunicipality;
    String baranggays =
        Provider.of<UserDetailsProvider>(context, listen: false).getBaranggy;
    String userNames =
        Provider.of<UserDetailsProvider>(context, listen: false).getUsername;
    String docUrls =
        Provider.of<UserDetailsProvider>(context, listen: false).getDocUrl;
    String idUrls =
        Provider.of<UserDetailsProvider>(context, listen: false).getPictureUrl;
    String profilePhoto =
        Provider.of<UserDetailsProvider>(context, listen: false)
            .getProfilePhoto;
    double walletbalance =
        Provider.of<UserDetailsProvider>(context, listen: false).getBalance;
    int userrating =
        Provider.of<UserDetailsProvider>(context, listen: false).getRatings;

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
                ? Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/karl_assets/images/farmer.png"),
                          /*Header text */
                          poppinsText(
                            "Farmer Registration",
                            farmSwapTitlegreen,
                            20.sp,
                            FontWeight.w500,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          /*This row display the calendar icon and a container beside it
                           that will display the selected date */
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80.h,
                                  width: 90.w,
                                  child: IconButton(
                                    onPressed: () {
                                      _selectDate();
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 80.sp,
                                      color: farmSwapSmoothGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 200.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: farmSwapSmoothGreen,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadow,
                                          blurRadius: 2,
                                          offset: const Offset(1, 5),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: poppinsText(
                                        birthdates,
                                        Colors.black,
                                        10.sp,
                                        FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*This row will contain the second calendar button and container that will contain
                          the selected date or will display the selected date */
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80.h,
                                  width: 90.w,
                                  child: IconButton(
                                    onPressed: () {
                                      _selectDate2();
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 80.sp,
                                      color: farmSwapSmoothGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 200.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: farmSwapSmoothGreen,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadow,
                                          blurRadius: 2,
                                          offset: const Offset(1, 5),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: poppinsText(
                                        registrationdates,
                                        Colors.black,
                                        10.sp,
                                        FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Check if both dates are selected
                              if (registerdate != null &&
                                  registerdate2 != null) {
                                // Proceed with the logic when both dates are selected
                                farmerUser.insertFarmerData(
                                  fname,
                                  lname,
                                  birthplaces,
                                  contactNum,
                                  municipalitys,
                                  baranggays,
                                  userNames,
                                  docUrls,
                                  idUrls,
                                  profilePhoto,
                                  registerdate!,
                                  registerdate2!,
                                  walletbalance,
                                  userrating,
                                );

                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegisterEnd);
                              } else {
                                // Show an error message Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select both birth and registration dates.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const FarmSwapGreenBtnNew(text: "Next"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/karl_assets/images/consumer.png"),
                          /*Header text */
                          poppinsText(
                            "Consumer Registration",
                            farmSwapTitlegreen,
                            20.sp,
                            FontWeight.w500,
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          /*This row display the calendar icon and a container beside it
                           that will display the selected date */
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80.h,
                                  width: 90.w,
                                  child: IconButton(
                                    onPressed: () {
                                      _selectDate();
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 80.sp,
                                      color: farmSwapSmoothGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 200.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: farmSwapSmoothGreen,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadow,
                                          blurRadius: 2,
                                          offset: const Offset(1, 5),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: poppinsText(
                                        birthdates,
                                        Colors.black,
                                        10.sp,
                                        FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*This row will contain the second calendar button and container that will contain
                          the selected date or will display the selected date */
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80.h,
                                  width: 90.w,
                                  child: IconButton(
                                    onPressed: () {
                                      _selectDate2();
                                    },
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 80.sp,
                                      color: farmSwapSmoothGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 200.sp,
                                    height: 50.sp,
                                    decoration: BoxDecoration(
                                      color: farmSwapSmoothGreen,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: shadow,
                                          blurRadius: 2,
                                          offset: const Offset(1, 5),
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: poppinsText(
                                        registrationdates,
                                        Colors.black,
                                        10.sp,
                                        FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Check if both dates are selected
                              if (registerdate != null &&
                                  registerdate2 != null) {
                                // Proceed with the logic when both dates are selected
                                consumerUser.insertConsumerData(
                                  fname,
                                  lname,
                                  birthplaces,
                                  contactNum,
                                  municipalitys,
                                  baranggays,
                                  userNames,
                                  idUrls,
                                  profilePhoto,
                                  registerdate!,
                                  registerdate2!,
                                  walletbalance,
                                  userrating,
                                );

                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegisterEnd);
                              } else {
                                // Show an error message Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please select both birth and registration dates.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const FarmSwapGreenBtnNew(text: "Next"),
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

  DateTime? registerdate; // Use DateTime? to allow null values
  DateTime? registerdate2; // Use DateTime? to allow null values
  Future<void> _selectDate() async {
    DateTime initialDate = registerdate ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != registerdate) {
      setState(() {
        // Format the pickedDate to display only the date
        birthdates = DateFormat('MMMM dd, yyyy').format(pickedDate);
        registerdate = pickedDate;
      });

      // Check if the selected date is not in the legal age (less than 18 years old)
      if (!isLegalAge(pickedDate)) {
        // Show a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must be at least 18 years old.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  bool isLegalAge(DateTime date) {
    // Calculate age based on the selected birthdate
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - date.year;

    // Check if the birthday has occurred this year
    if (currentDate.month < date.month ||
        (currentDate.month == date.month && currentDate.day < date.day)) {
      age--;
    }

    // Check if the calculated age is 18 or older
    return age >= 18;
  }

/*For selecting registration date */
  Future<void> _selectDate2() async {
    DateTime initialDate = registerdate2 ?? DateTime.now();
    String formattedDate =
        DateFormat('MMMM dd, yyyy hh:mm a').format(initialDate);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          initialDate, // Set the initial date to the current date or registerdate2 if not null
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != registerdate2) {
      setState(() {
        registrationdates = formattedDate;
        registerdate2 = pickedDate;
      });
    }
  }
}
