import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
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
  State<UserPersonalDetailsRegistration8> createState() => _UserPersonalDetailsRegistration8State();
}

class _UserPersonalDetailsRegistration8State extends State<UserPersonalDetailsRegistration8> {
  String registrationdates = "select registration date";
  String birthdates = "select birthdate";

  /*Instance of the class that will save our data*/
  AddNewFarmerUserDb farmerUser = AddNewFarmerUserDb();
  AddNewConsumerUserDb consumerUser = AddNewConsumerUserDb();

  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<UserTypeProvider>(context, listen: false).getUserType;

/*getting all the values that we put in the provider to pass to the function
 that adds data to the database, we are doing it here, becasue we cannot call provider outside
 of the build method*/

    String fname = Provider.of<UserDetailsProvider>(context, listen: false).getFirstname;
    String lname = Provider.of<UserDetailsProvider>(context, listen: false).getLastName;
    String birthplaces = Provider.of<UserDetailsProvider>(context, listen: false).getBirthplace;
    String contactNum = Provider.of<UserDetailsProvider>(context, listen: false).getContactNum;
    String municipalitys =
        Provider.of<UserDetailsProvider>(context, listen: false).getCityMunicipality;
    String baranggays = Provider.of<UserDetailsProvider>(context, listen: false).getBaranggy;
    String userNames = Provider.of<UserDetailsProvider>(context, listen: false).getUsername;
    String docUrls = Provider.of<UserDetailsProvider>(context, listen: false).getDocUrl;
    String idUrls = Provider.of<UserDetailsProvider>(context, listen: false).getPictureUrl;
    String profilePhoto = Provider.of<UserDetailsProvider>(context, listen: false).getProfilePhoto;
    double walletbalance = Provider.of<UserDetailsProvider>(context, listen: false).getBalance;
    int userrating = Provider.of<UserDetailsProvider>(context, listen: false).getRatings;

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        showTermsAndConditionsDialog(context);
                                      },
                                      child: Text(
                                        'Read Terms and Conditions',
                                        style: TextStyle(
                                          color: greenDark,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: greenDark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide(color: farmSwapSmoothGreen, width: 1),
                                        ),
                                        value: agreeToTerms,
                                        onChanged: (value) {
                                          setState(() {
                                            agreeToTerms = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'I agree to the Terms and Conditions',
                                        style: Poppins.detailsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Check if both dates are selected
                              if (registerdate != null && registerdate2 != null) {
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

                                Navigator.of(context)
                                    .pushNamed(RouteManager.userDetailsRegisterEnd);
                              } else {
                                // Show an error message Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please select both birth and registration dates.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                              if (agreeToTerms) {
                                // Proceed with navigation
                                Navigator.of(context)
                                    .pushNamed(RouteManager.userDetailsRegisterEnd);
                              } else {
                                // Show an error message Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please agree to the Terms and Conditions.'),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        showTermsAndConditionsDialog(context);
                                      },
                                      child: Text(
                                        'Read Terms and Conditions',
                                        style: TextStyle(
                                          color: greenDark,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: Colors.white,
                                        checkColor: greenDark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide(color: farmSwapSmoothGreen, width: 1),
                                        ),
                                        value: agreeToTerms,
                                        onChanged: (value) {
                                          setState(() {
                                            agreeToTerms = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'I agree to the Terms and Conditions',
                                        style: Poppins.detailsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /*GestureDetector(
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

                              if (agreeToTerms) {
                                // Proceed with navigation
                                Navigator.of(context).pushNamed(
                                    RouteManager.userDetailsRegisterEnd);
                              } else {
                                // Show an error message Snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please agree to the Terms and Conditions.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: const FarmSwapGreenBtnNew(text: "Next"),
                          ),*/
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
    String formattedDate = DateFormat('MMMM dd, yyyy hh:mm a').format(initialDate);

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

  void showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Terms and Conditions',
            style: Poppins.userName.copyWith(
              color: greenDark,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              // Your terms and conditions text here
              "AGREEMENT TO TERMS\n\n"
              "These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity (“you”) and AgriVentures, concerning your access to and use of our mobile application, FarmSwap. You agree that by accessing the application, you have read, understood, and agree to be bound by all of these Terms and Conditions Use. IF YOU DO NOT AGREE WITH ALL OF THESE TERMS AND CONDITIONS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE APPLICATION AND YOU MUST DISCONTINUE USE IMMEDIATELY.\n\n"
              "Supplemental terms and conditions or documents that may be posted on the Application from time to time are hereby expressly incorporated herein by reference. We reserve the right, in our sole discretion, to make changes or modifications to these Terms and Conditions at any time and for any reason. We will alert you about any changes by updating the “Last updated” date of these Terms and Conditions and you waive any right to receive specific notice of each such change. It is your responsibility to periodically review these Terms and Conditions to stay informed of updates. You will be subject to, and will be deemed to have been made aware of and to have accepted, the changes in any revised Terms and Conditions by your continued use of the Application after the date such revised Terms are posted.\n\n"
              "The information provided on the Application is not intended for distribution to or use by any person or entity in any jurisdiction or country where such distribution or use would be contrary to law or regulation or which would subject us to any registration requirement within such jurisdiction or country. Accordingly, those persons who choose to access the Application from other locations do so on their own initiative and are solely responsible for compliance with local laws, if and to the extent local laws are applicable.\n\n"
              "The Application is intended for users who are at least 18 years old. Persons under the legal age as stated in the Philippine Constitution are not permitted to register for the Application.\n\n\n"
              "INTELLECTUAL PROPERTY RIGHTS\n\n"
              "Unless otherwise indicated, the Application is our proprietary property and all source code, databases, functionality, software, website designs, audio, video, text, photographs, and graphics on the Application (collectively, the “Content”) and the trademarks, service marks, and logos contained therein (the “Marks”) are owned or controlled by us or licensed to us, and are protected by copyright and trademark laws and various other intellectual property rights and unfair competition laws of the Republic of the Philippines, foreign jurisdictions, and international conventions. The Content and the Marks are provided on the Application “AS IS” for your information and personal use only. Except as expressly provided in these Terms of Use, no part of the Application and no Content or Marks may be copied, reproduced, aggregated, republished, uploaded, posted, publicly displayed, encoded, translated, transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose whatsoever, without our express prior written permission.\n\n"
              "Provided that you are eligible to use the Application, you are granted a limited license to access and use the Application and to download or print a copy of any portion of the Content to which you have properly gained access solely for your personal, non-commercial use. We reserve all rights not expressly granted to you in and to the Application, Content, and the Marks.\n\n\n"
              "USER REPRESENTATIONS\n\n"
              "By using the Application, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary; (3) you have the legal capacity and you agree to comply with these Terms of Use; (4) you are not under the age of 13; (5) not a minor in the jurisdiction in which you reside, or if a minor, you have received parental permission to use the Site; (6) you will not access the Application through automated or non-human means, whether through a bot, script or otherwise; (7) you will not use the Application for any illegal or unauthorized purpose; and (8) your use of the Application will not violate any applicable law or regulation.\n\n"
              "If you provide any information that is untrue, inaccurate, not current, or incomplete, we have the right to suspend or terminate your account and refuse any and all current or future use of the Application(or any portion thereof).\n\n\n"
              "USER REGISTRATION\n\n"
              "You may be required to register with the Application. You agree to keep your password confidential and will be responsible for all use of your account and password. We reserve the right to remove, or deny any registration, in our sole discretion, that information being provided is  inappropriate, obscene, or otherwise objectionable.\n\n\n"
              "ACCOUNT MANAGEMENT\n\n"
              "FarmSwap admins have certain controls over user accounts to maintain the integrity of the platform and ensure a smooth user experience. These controls include:\n\n"
              "Viewing account details: Admins can access and view user account details, including profile information, wallet addresses, and swapCoin balances. This access is necessary for troubleshooting issues, investigating potential misuse, and ensuring compliance with platform policies.\n\n"
              "Managing swapCoin balances: Admins can adjust user swapCoin balances in limited circumstances, such as correcting errors or recovering funds in case of technical glitches. However, admins are strictly prohibited from modifying swapCoin balances for any unauthorized purpose.\n\n\n"
              "ACCOUNT SECURITY\n\n"
              "FarmSwap takes the security of user accounts very seriously. To protect user privacy and prevent unauthorized access, admins are prohibited from:\n\n"
              "Changing user email addresses: User email addresses are considered sensitive information and are essential for password recovery and account communication. Admins are not permitted to modify user email addresses for any reason.\n\n"
              "Changing user passwords: User passwords are the primary security gateways to user accounts. Admins are strictly forbidden from changing user passwords, as this could compromise the security of the account and expose the user's personal information.\n\n\n"
              "ADMIN ACCOUNTABILITY\n\n"
              "FarmSwap implements a robust system of admin accountability to prevent potential misuse of admin privileges and maintain a transparent and secure environment for all users. This system includes:\n\n"
              "Admin logs: All admin actions, including account access, balance adjustments, and activity monitoring, are recorded in detailed logs. These logs are accessible to other admins for review, ensuring that any admin actions are transparent and traceable.\n\n"
              "Disciplinary measures: Admins who violate the terms of service or engage in unauthorized actions will face disciplinary measures, up to and including the termination of their admin privileges.\n\n"
              "FarmSwap is committed to providing a secure and trustworthy platform for all users. The controls outlined in these terms and conditions are designed to ensure that admins act responsibly and in the best interests of the platform and its users.\n\n\n"
              "USER CONDUCT\n\n"
              "FarmSwap is committed to providing a safe and secure platform for all users. To maintain this positive environment, we expect all users to abide by our terms of service and refrain from engaging in any activities that could harm or disrupt the platform or its users. Any user found to be engaging in prohibited activities may be subject to penalties as outlined below.\n\n\n"
              "PENALTIES FOR MISCONDUCT\n\n"
              "FarmSwap takes violations of our terms and conditions seriously and reserves the right to impose penalties on users who engage in misconduct. The severity of the penalty will depend on the nature and severity of the offense. Penalties may include:\n\n"
              "Warning: A warning message will be sent to the offending user, informing them of the violation and outlining the potential consequences of further misconduct.\n\n"
              "Swap Coins deduction: For minor offenses, admins may deduct a portion of the user's Swap Coins balance. The amount deducted will be determined by the severity of the offense.\n\n"
              "Wallet balance deduction: For more serious offenses, admins may deduct a portion of the user's wallet balance. The amount deducted will be determined by the severity of the offense.\n\n"
              "Account deactivation: For the most severe offenses, admins may deactivate the user's account. This means that the user will no longer be able to access their account or use the FarmSwap platform.\n\n\n"
              "PROHIBITED ACTIVITIES\n\n"
              "The following are examples of activities that may be considered prohibited and could result in penalties:\n\n"
              "Creating multiple accounts: Users are only allowed to have one FarmSwap account. Creating multiple accounts is considered a form of fraud and will result in penalties.\n\n"
              "Engaging in fraudulent activities: This includes activities such as using fake or stolen identities, manipulating transactions, or attempting to exploit bugs or glitches in the platform.\n\n"
              "Harassing or abusing other users: This includes sending threatening or abusive messages, making inappropriate comments, or engaging in any other behavior that could make another user feel uncomfortable or unsafe.\n\n"
              "Spreading misinformation or malicious content: This includes sharing false or misleading information, posting harmful or offensive content, or promoting illegal or harmful activities.\n\n"
              "Interfering with the platform's operation: This includes activities such as attempting to hack into the platform, overloading the servers, or using bots to automate actions.\n\n"
              "FarmSwap is committed to maintaining a safe and positive environment for all users. We encourage all users to report any instances of misconduct to our support team. We will thoroughly investigate all reports and take appropriate action against users who violate our terms of service.\n\n\n"
              "GUIDELINES FOR REVIEWS\n\n"
              "We may provide you areas on the Application to leave reviews or ratings. When posting a review, you must comply with the following criteria: (1) you should have firsthand experience with the person/entity being reviewed; (2) your reviews should not contain offensive profanity, or abusive, racist, offensive, or hate language; (3) your reviews should not contain discriminatory references based on religion, race, gender, national origin, age, marital status, sexual orientation, or disability; (4) your reviews should not contain references to illegal activity; (5) you should not be affiliated with competitors if posting negative reviews; (6) you should not make any conclusions as to the legality of conduct; (7) you may not post any false or misleading statements; and (8) you may not organize a campaign encouraging others to post reviews, whether positive or negative.\n\n"
              "We may accept, reject, or remove reviews in our sole discretion. We have absolutely no obligation to screen reviews or to delete reviews, even if anyone considers reviews objectionable or inaccurate. Reviews are not endorsed by us, and do not necessarily represent our opinions or the views of any of our affiliates or partners. We do not assume liability for any review or for any claims, liabilities, or losses resulting from any review.\n\n\n"
              "SUBMISSIONS\n\n"
              "You acknowledge and agree that any questions, comments, suggestions, ideas, feedback, or other information regarding the Application (“Submissions”) provided by you to us are non-confidential and shall become our sole property. We shall own exclusive rights, including all intellectual property rights, and shall be entitled to the unrestricted use and dissemination of these Submissions for any lawful purpose, commercial or otherwise, without acknowledgment or compensation to you. You hereby waive all moral rights to any such Submissions, and you hereby warrant that any such Submissions are original with you or that you have the right to submit such Submissions. You agree there shall be no recourse against us for any alleged or actual infringement or misappropriation of any proprietary right in your Submissions.\n\n\n"
              "THIRD-PARTY WEBSITES AND CONTENT\n\n"
              "The Application may contain (or you may be sent via the Application) links to other websites (“Third-Party Websites”) as well as articles, photographs, text, graphics, pictures, designs, music, sound, video, information, applications, software, and other content or items belonging to or originating from third parties (“Third-Party Content”). Such Third-Party Websites and Third-Party Content are not investigated, monitored, or checked for accuracy, appropriateness, or completeness by us, and we are not responsible for any Third-Party Websites accessed through the Application or any Third-Party Content posted on, available through, or installed from the Application, including the content, accuracy, offensiveness, opinions, reliability, privacy practices, or other policies of or contained in the Third-Party Websites or the Third-Party Content. Inclusion of, linking to, or permitting the use or installation of any Third-Party Websites or any Third-Party Content does not imply approval or endorsement thereof by us. If you decide to leave the Application and access the Third-Party Websites or to use or install any Third-Party Content, you do so at your own risk, and you should be aware these Terms of Use no longer govern. You should review the applicable terms and policies, including privacy and data gathering practices, of any website to which you navigate from the Application or relating to any applications you use or install from the Application. Any purchases you make through Third-Party Websites will be through other websites and from other companies, and we take no responsibility whatsoever in relation to such purchases which are exclusively between you and the applicable third party. You agree and acknowledge that we do not endorse the products or services offered on Third-Party Websites and you shall hold us harmless from any harm caused by your purchase of such products or services. Additionally, you shall hold us harmless from any losses sustained by you or harm caused to you relating to or resulting in any way from any Third-Party Content or any contact with Third-Party Websites.\n\n\n"
              "PRIVACY POLICY\n\n"
              "FarmSwap is committed to protecting your privacy and ensuring that your personal data is collected, used, and disclosed in accordance with the Data Privacy Act of 2012 (DPA) and other applicable laws in the Philippines. This Privacy Policy explains our practices regarding the collection, use, and disclosure of your personal data when you use our FarmSwap mobile app.\n\n\n"
              "COLLECTION OF PERSONAL DATA\n\n"
              "We collect personal data from you when you use our FarmSwap mobile app. This includes information such as:\n\n"
              "Registration information: When you create an account with us, we collect information such as your name, email address, and phone number.\n\n"
              "Profile information: You may choose to provide additional profile information, such as your date of birth and country of residence.\n\n"
              "Transaction information: We collect information about your transactions on our platform, such as the type of transaction, the amount transacted, and the date and time of the transaction.\n\n\n"
              "USE OF PERSONAL DATA\n\n"
              "We use your personal data for the following purposes:\n\n"
              "To provide you with our services: We use your personal data to provide you with access to our FarmSwap mobile app and its features, including creating and managing your account, performing transactions, and participating in our community.\n\n"
              "To improve our services: We use your personal data to improve our services, analyze usage patterns, and identify potential problems.\n\n"
              "To protect our rights and interests: We use your personal data to protect our rights and interests, such as detecting and preventing fraud, complying with legal requirements, and enforcing our terms of service.\n\n\n"
              "DISCLOSURE OF PERSONAL DATA\n\n"
              "We may disclose your personal data to the following third parties:\n\n"
              "Service providers: We may disclose your personal data to service providers who help us operate our business, such as cloud hosting providers, payment processors, and customer support providers.\n\n"
              "Legal and regulatory authorities: We may disclose your personal data to legal and regulatory authorities if required by law or if we believe that disclosure is necessary to protect our rights or interests or the rights or interests of others.\n\n\n\n"
              "AgriVentures Inc.\n"
              "Cebu City, Philippines\n"
              "farmswap@agriventures.com"
              // ... (Add the rest of your terms and conditions text)
              ,
              style: Poppins.terms.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: Poppins.userName.copyWith(
                  color: greenNormal,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
