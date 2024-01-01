import "dart:convert";
import "package:cached_network_image/cached_network_image.dart";
import "package:farm_swap_mobile_final/authentication/user_authentication.dart";
import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/green_btn.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/common/upload_image_functions.dart";
import "package:farm_swap_mobile_final/constants/typography.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/database/add_consumerdata_db.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/database/add_farmerdata_db.dart";
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/registration_2/registration2_txtfield.dart';
import "package:farm_swap_mobile_final/karl_modules/user_signup/screens/registration_2/registration2_username_check.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup10.dart";
import "package:farm_swap_mobile_final/provider/user_type_provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class Registration2 extends StatefulWidget {
  const Registration2({super.key});

  @override
  State<Registration2> createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  UploadImageFunctions uploadImg = UploadImageFunctions();
  AddNewFarmerUserDb addFarmer = AddNewFarmerUserDb();
  AddNewConsumerUserDb addCounser = AddNewConsumerUserDb();
  AddNewFarmerUserDb2 addFarmer2 = AddNewFarmerUserDb2();
  CheckUsernameAvailability userNameCheck = CheckUsernameAvailability();
  UserAuthentication userAuthRegister = UserAuthentication();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();

  List<String> regions = [];
  List<String> provinces = [];
  List<String> municipalities = [];
  List<String> cities = [];
  List<String> barangays = [];
  Map<String, dynamic>? data;
  String oldSelectedMunicipality = 'RONDA';
  String selectedMunicipality = 'RONDA';
  String documentProofUrl = "";
  String idProofUrl = "";
  String profilePhotoUrl = "";
  bool checkBoxIsChecked = false;
  bool isTrueEmail = true;
  bool isValidPhoneNumber = true;
  bool isPasswordVisible = true;
  bool bothGoodPassword = true;
  bool isAStrongPassword = true;
  DateTime registerdate2 = DateTime.now();
  String registrationdates = "Please select a date";
  bool isLegalAge = true;
  bool isUsedUname = false;
  List<String> barangay = [];
  /*Mao ni atong default value para sa atong dropdown, gi mark as late lang nato kay adto man tani
  assignan og value solod sa atong Future<void> na method */
  late String selectedBarangay = '';
  String userid = '';
  String firstBarangay = '';

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    emailNameController.dispose();
    passwordNameController.dispose();
    contactController.dispose();
    birthPlaceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    loadBarangay();
  }

/*Function that gets the list of municipalities from our api file */
  Future<void> loadData() async {
    String jsonString = await rootBundle.loadString(
        'assets/karl_assets/json/philippine_provinces_cities_municipalities_and_barangays_2016.json');
    data = json.decode(jsonString);
    var regionData = data?["07"];
    if (regionData != null) {
      setState(() {
        for (var provinceEntry in regionData['province_list'].entries) {
          var provinceName = provinceEntry.key;
          provinces.add(provinceName);

          for (var municipalityEntry in provinceEntry.value['municipality_list']) {
            var municipalityName = municipalityEntry.keys.first;
            municipalities.add(municipalityName);

            var barangayListing = municipalityEntry[municipalityName]['barangay_list'];
            barangays.addAll(barangayListing.cast<String>());
          }
        }
      });
    }
  }

/*Function that gets the list of barangays from our API file*/
  Future<void> loadBarangay() async {
    /*Gi decode nato ang jsong file */
    String jsonString = await rootBundle.loadString(
        'assets/karl_assets/json/philippine_provinces_cities_municipalities_and_barangays_2016.json');
    var data = json.decode(jsonString);
    /*Gi kuha nato ang data nga nag wrap sa atong municipalities */
    var regionData = data?["07"];
    /*Check nato og naa ba jud na nga data sa atong json */
    if (regionData != null) {
      /*Atong gi traverse ang atong json file tapos gi assign nato ang mga pronvince_list sa province entry na variable */
      for (var provinceEntry in regionData['province_list'].entries) {
        /*Tapos gi traverse nato ang provinceEntry nga nag contain sa atong municipality na mga pangalan, tapos kini na mga 
        pangalan e solod nato sa temporary variable na municipalityEntry*/
        for (var municipalityEntry in provinceEntry.value['municipality_list']) {
          /*Dayon taga municipality name na mosolod sa municiplaity entry ato e anam anam og solod sa municipalityName na variable */
          var municipalityName = municipalityEntry.keys.first;
          /*Then ato e check kung ang bagohay lang ni solod na municipality name sa atong municipalityName na variable kay equal ba sa atong
          widget.selectedMunicipality*/
          if (municipalityName == selectedMunicipality) {
            /*Kuhaon  nato ang kaakibat na barangy sa selected na munisipyo, key value pairs maning [][] */
            var barangayList = municipalityEntry[municipalityName]['barangay_list'];
            setState(() {
              barangay = List<String>.from(barangayList);
              /*So diri ang initial value sa atong dropdown is ang pinaka first na brangay sa selected na municiplaity */
              selectedBarangay = barangay.isNotEmpty ? barangay[0] : 'BUTONG';
            });
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<UserTypeProvider>(context, listen: false).getUserType;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: greenNormal,
        title: (userType == "Farmer")
            ? poppinsText("Farmer Registration", Colors.white, 18.sp, FontWeight.w300)
            : poppinsText("Consumer Registration", Colors.white, 18.sp, FontWeight.w300),
      ),
      body: (userType == "Farmer")
          ? SafeArea(
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
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          //FOR FIRSTNAME
                          Registration2TextField(
                            controller: firstNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("First Name", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR LASTNAME
                          Registration2TextField(
                            controller: lastNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("Last Name Name", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR USERNAME
                          Registration2TextField(
                            controller: userNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          (isUsedUname == false)
                              ? poppinsText2(
                                  "Username Name",
                                  Colors.black54,
                                  15.sp,
                                  FontWeight.w400,
                                )
                              : poppinsText2(
                                  "Username name already used",
                                  Colors.red,
                                  15.sp,
                                  FontWeight.w400,
                                ),
                          //FOR BIRTHPLACE
                          Registration2TextField(
                            controller: birthPlaceController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("Birthplace", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR CONTACT NUMBER
                          Registration2TextField(
                            controller: contactController,
                            inputType: TextInputType.number,
                            isPasswordVisible: false,
                            maxCharacters: 11,
                          ),
                          (isValidPhoneNumber == true)
                              ? poppinsText2(
                                  "Contact Number", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText2(
                                  "Invalid Contact Number", Colors.red, 15.sp, FontWeight.w400),
                          //FOR BIRTH DATE FIELD
                          TextField(
                            decoration: InputDecoration(
                              hintText: registrationdates,
                              prefix: IconButton(
                                onPressed: () {
                                  _selectDate2();
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                          (isLegalAge == true)
                              ? poppinsText2("Birth Date", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText2(
                                  "User must be 18 years old", Colors.red, 15.sp, FontWeight.w400),
                          //FOR EMAIL
                          Registration2TextField(
                            controller: emailNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          (isTrueEmail == true)
                              ? poppinsText("Email Address", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText(
                                  "Invalid Email Address", Colors.red, 15.sp, FontWeight.w400),
                          //FOR PASSWORD
                          Registration2TextField(
                            controller: passwordNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: isPasswordVisible,
                            isPassword: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isPasswordVisible == true)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: togglePasswordVisibility,
                            ),
                          ),
                          (isAStrongPassword == true)
                              ? poppinsText(
                                  "Password",
                                  Colors.black54,
                                  15.sp,
                                  FontWeight.w400,
                                )
                              : poppinsText(
                                  "Weak password please modify",
                                  Colors.red,
                                  15.sp,
                                  FontWeight.w400,
                                ),
                          //FOR CONFIRM PASSWORD
                          Registration2TextField(
                            controller: confirmPasswordController,
                            inputType: TextInputType.text,
                            isPasswordVisible: isPasswordVisible,
                            isPassword: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isPasswordVisible == true)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                togglePasswordVisibility();
                              },
                            ),
                          ),
                          (bothGoodPassword == true)
                              ? poppinsText(
                                  "Confirm Password", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText(
                                  "Password Mismatch", Colors.red, 15.sp, FontWeight.w400),
                          Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                          ),
                          /*Drop down for the municipality */
                          DropdownButton<String>(
                            hint: const Text('Select a Municipality'),
                            value: selectedMunicipality,
                            onChanged: (String? newValue) {
                              // Handle region selection
                              setState(() {
                                selectedMunicipality = newValue.toString();
                                loadBarangay();
                              });
                            },
                            items: municipalities.map((municipalities) {
                              return DropdownMenuItem<String>(
                                value: municipalities,
                                child: Text(municipalities),
                              );
                            }).toList(),
                          ),
                          poppinsText("Municipality", Colors.black54, 15.sp, FontWeight.w400),
                          Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                          ),
                          /*Drop down for the barangay */
                          /* Registration2LocationDropDown(selectedMunicipality: selectedMunicipality),
                    poppinsText("Baranggay", Colors.black54, 15.sp, FontWeight.w400),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                    ),*/
                          /*FOR BARANGAY*/
                          DropdownButton<String>(
                            hint: const Text('Select a Barangay'),
                            value: selectedBarangay,
                            onChanged: (String? newValue) {
                              setState(() {
                                print(newValue);
                                selectedBarangay = newValue.toString();
                              });
                            },
                            items: barangay.map((barangay) {
                              return DropdownMenuItem<String>(
                                value: barangay,
                                child: Text(barangay),
                              );
                            }).toList(),
                          ),
                          poppinsText("Baranggay", Colors.black54, 15.sp, FontWeight.w400),
                          /*For upload document proof */
                          Padding(
                            padding: EdgeInsets.only(top: 15.sp),
                          ),
                          Container(
                            width: 230.w,
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: (documentProofUrl != "")
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(documentProofUrl),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image:
                                          Image.asset('assets/karl_assets/images/upload_symbol.png')
                                              .image,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                String? docUrl = await uploadImg.uploadImageToFirebaseGallery();
                                setState(() {
                                  documentProofUrl = docUrl!;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Registration2();
                                    },
                                  ),
                                );
                              }
                            },
                            child: poppinsText(
                                "Upload Document Proof", darkGreen, 13.sp, FontWeight.normal),
                          ),
                          /*For Id  proof */
                          Container(
                            width: 230.w,
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: (idProofUrl != "")
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(idProofUrl),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image:
                                          Image.asset('assets/karl_assets/images/upload_symbol.png')
                                              .image,
                                      fit: BoxFit.fill),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                String? idproof = await uploadImg.uploadImageToFirebaseGallery();
                                setState(() {
                                  idProofUrl = idproof!;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Registration2();
                                    },
                                  ),
                                );
                              }
                            },
                            child: poppinsText(
                                "Upload Id Front Page", darkGreen, 13.sp, FontWeight.normal),
                          ),
                          /*For upload profile url */
                          Container(
                            width: 230.w,
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: (profilePhotoUrl != "")
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(profilePhotoUrl),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image:
                                          Image.asset('assets/karl_assets/images/upload_symbol.png')
                                              .image,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                String? profileUrl = await uploadImg.uploadImageToFirebaseGallery();
                                setState(() {
                                  profilePhotoUrl = profileUrl!;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Registration2();
                                    },
                                  ),
                                );
                              }
                            },
                            child: poppinsText(
                                "Upload Profile Picture", darkGreen, 13.sp, FontWeight.normal),
                          ),
                          /*Terms and agreement*/
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*Check box to determine if the user agreed to the terms and condition */
                                Checkbox(
                                  value: checkBoxIsChecked,
                                  onChanged: (bool? value) {
                                    setState(
                                      () {
                                        checkBoxIsChecked = value ?? false;
                                      },
                                    );
                                  },
                                ),
                                /*Click to read the terms and conditions */
                                TextButton(
                                  onPressed: () {
                                    showTermsAndConditionsDialog(context);
                                  },
                                  child: poppinsText(
                                    "Terms and Conditions",
                                    darkGreen,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              /*Check if email enetered is valid */
                              bool emailTrue = isValidEmail(emailNameController.text);
                              /*Check if phone number entered is valid */
                              bool contactTrue = isValidPhilippineNum(contactController.text);
                              /*Check if both password and confirm password match with each other */
                              bool correctPasswords = isMatchedPassowrds();
                              /*Check if passwords is strong */
                              bool strongPassword = isStrongPassword(passwordNameController.text);
                              //Check if the user is on legal age
                              isLegalAge = isLegalAgeCheck(registerdate2);
                              //Check if username is already used
                              checkUname(userNameController.text);
                              setState(() {
                                isTrueEmail = emailTrue;
                                isValidPhoneNumber = contactTrue;
                                bothGoodPassword = correctPasswords;
                                isAStrongPassword = strongPassword;
                              });

                              /*Save the password and email address to the firebase authentication*/
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              : await registerFarmer();

                              /*Save the actual data to the firestore */
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              : addFarmer2.insertFarmerData(
                                                                  firstNameController.text,
                                                                  lastNameController.text,
                                                                  birthPlaceController.text,
                                                                  contactController.text,
                                                                  selectedMunicipality,
                                                                  selectedBarangay,
                                                                  userNameController.text,
                                                                  documentProofUrl,
                                                                  idProofUrl,
                                                                  profilePhotoUrl,
                                                                  registerdate2,
                                                                  DateTime.now(),
                                                                  500,
                                                                  0,
                                                                  emailNameController.text,
                                                                  userid,
                                                                );

                              /*Redirect to done registration page*/
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              // ignore: use_build_context_synchronously
                                                              : Navigator.of(context)
                                                                  .push(MaterialPageRoute(
                                                                  builder: (context) {
                                                                    return const UserRegisterEndPage();
                                                                  },
                                                                ));
                            },
                            child: const FarmSwapGreenBtn(text: "Register"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          :
          //IF USER IS CONSUMER
          SafeArea(
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
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          //FOR FIRSTNAME
                          Registration2TextField(
                            controller: firstNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("First Name", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR LASTNAME
                          Registration2TextField(
                            controller: lastNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("Last Name Name", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR USERNAME
                          Registration2TextField(
                            controller: userNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          (isUsedUname == false)
                              ? poppinsText2(
                                  "Username Name",
                                  Colors.black54,
                                  15.sp,
                                  FontWeight.w400,
                                )
                              : poppinsText2(
                                  "Username name already used",
                                  Colors.red,
                                  15.sp,
                                  FontWeight.w400,
                                ),
                          //FOR BIRTHPLACE
                          Registration2TextField(
                            controller: birthPlaceController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          poppinsText2("Birthplace", Colors.black54, 15.sp, FontWeight.w400),
                          //FOR CONTACT NUMBER
                          Registration2TextField(
                            controller: contactController,
                            inputType: TextInputType.number,
                            isPasswordVisible: false,
                            maxCharacters: 11,
                          ),
                          (isValidPhoneNumber == true)
                              ? poppinsText2(
                                  "Contact Number", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText2(
                                  "Invalid Contact Number", Colors.red, 15.sp, FontWeight.w400),
                          //FOR BIRTH DATE FIELD
                          TextField(
                            decoration: InputDecoration(
                              hintText: registrationdates,
                              prefix: IconButton(
                                onPressed: () {
                                  _selectDate2();
                                },
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ),
                          ),
                          (isLegalAge == true)
                              ? poppinsText2("Birth Date", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText2(
                                  "User must be 18 years old", Colors.red, 15.sp, FontWeight.w400),
                          //FOR EMAIL
                          Registration2TextField(
                            controller: emailNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: false,
                          ),
                          (isTrueEmail == true)
                              ? poppinsText("Email Address", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText(
                                  "Invalid Email Address", Colors.red, 15.sp, FontWeight.w400),
                          //FOR PASSWORD
                          Registration2TextField(
                            controller: passwordNameController,
                            inputType: TextInputType.text,
                            isPasswordVisible: isPasswordVisible,
                            isPassword: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isPasswordVisible == true)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: togglePasswordVisibility,
                            ),
                          ),
                          (isAStrongPassword == true)
                              ? poppinsText(
                                  "Password",
                                  Colors.black54,
                                  15.sp,
                                  FontWeight.w400,
                                )
                              : poppinsText(
                                  "Weak password please modify",
                                  Colors.red,
                                  15.sp,
                                  FontWeight.w400,
                                ),
                          //FOR CONFIRM PASSWORD
                          Registration2TextField(
                            controller: confirmPasswordController,
                            inputType: TextInputType.text,
                            isPasswordVisible: isPasswordVisible,
                            isPassword: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                (isPasswordVisible == true)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                togglePasswordVisibility();
                              },
                            ),
                          ),
                          (bothGoodPassword == true)
                              ? poppinsText(
                                  "Confirm Password", Colors.black54, 15.sp, FontWeight.w400)
                              : poppinsText(
                                  "Password Mismatch", Colors.red, 15.sp, FontWeight.w400),
                          Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                          ),
                          /*Drop down for the municipality */
                          DropdownButton<String>(
                            hint: const Text('Select a Municipality'),
                            value: selectedMunicipality,
                            onChanged: (String? newValue) {
                              // Handle region selection
                              setState(() {
                                selectedMunicipality = newValue.toString();
                                loadBarangay();
                              });
                            },
                            items: municipalities.map((municipalities) {
                              return DropdownMenuItem<String>(
                                value: municipalities,
                                child: Text(municipalities),
                              );
                            }).toList(),
                          ),
                          poppinsText("Municipality", Colors.black54, 15.sp, FontWeight.w400),
                          Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                          ),
                          /*Drop down for the barangay */
                          /* Registration2LocationDropDown(selectedMunicipality: selectedMunicipality),
                    poppinsText("Baranggay", Colors.black54, 15.sp, FontWeight.w400),
                    Padding(
                      padding: EdgeInsets.only(top: 15.sp),
                    ),*/
                          /*FOR BARANGAY*/
                          DropdownButton<String>(
                            hint: const Text('Select a Barangay'),
                            value: selectedBarangay,
                            onChanged: (String? newValue) {
                              setState(() {
                                print(newValue);
                                selectedBarangay = newValue.toString();
                              });
                            },
                            items: barangay.map((barangay) {
                              return DropdownMenuItem<String>(
                                value: barangay,
                                child: Text(barangay),
                              );
                            }).toList(),
                          ),
                          poppinsText("Baranggay", Colors.black54, 15.sp, FontWeight.w400),
                          /*For upload document proof */
                          Padding(
                            padding: EdgeInsets.only(top: 15.sp),
                          ),
                          /*For Id  proof */
                          Container(
                            width: 230.w,
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: (idProofUrl != "")
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(idProofUrl),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image:
                                          Image.asset('assets/karl_assets/images/upload_symbol.png')
                                              .image,
                                      fit: BoxFit.fill),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                String? idproof = await uploadImg.uploadImageToFirebaseGallery();
                                setState(() {
                                  idProofUrl = idproof!;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Registration2();
                                    },
                                  ),
                                );
                              }
                            },
                            child: poppinsText(
                                "Upload Id Front Page", darkGreen, 13.sp, FontWeight.normal),
                          ),
                          /*For upload profile url */
                          Container(
                            width: 230.w,
                            height: 300.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              image: (profilePhotoUrl != "")
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(profilePhotoUrl),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image:
                                          Image.asset('assets/karl_assets/images/upload_symbol.png')
                                              .image,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                String? profileUrl = await uploadImg.uploadImageToFirebaseGallery();
                                setState(() {
                                  profilePhotoUrl = profileUrl!;
                                });
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Registration2();
                                    },
                                  ),
                                );
                              }
                            },
                            child: poppinsText(
                                "Upload Profile Picture", darkGreen, 13.sp, FontWeight.normal),
                          ),
                          /*Terms and agreement*/
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /*Check box to determine if the user agreed to the terms and condition */
                                Checkbox(
                                  value: checkBoxIsChecked,
                                  onChanged: (bool? value) {
                                    setState(
                                      () {
                                        checkBoxIsChecked = value ?? false;
                                      },
                                    );
                                  },
                                ),
                                /*Click to read the terms and conditions */
                                TextButton(
                                  onPressed: () {
                                    showTermsAndConditionsDialog(context);
                                  },
                                  child: poppinsText(
                                    "Terms and Conditions",
                                    darkGreen,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 13.sp, bottom: 13.sp),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              /*Check if email enetered is valid */
                              bool emailTrue = isValidEmail(emailNameController.text);
                              /*Check if phone number entered is valid */
                              bool contactTrue = isValidPhilippineNum(contactController.text);
                              /*Check if both password and confirm password match with each other */
                              bool correctPasswords = isMatchedPassowrds();
                              /*Check if passwords is strong */
                              bool strongPassword = isStrongPassword(passwordNameController.text);
                              //Check if the user is on legal age
                              isLegalAge = isLegalAgeCheck(registerdate2);
                              //Check if username is already used
                              checkUname(userNameController.text);
                              setState(() {
                                isTrueEmail = emailTrue;
                                isValidPhoneNumber = contactTrue;
                                bothGoodPassword = correctPasswords;
                                isAStrongPassword = strongPassword;
                              });

                              /*Registering the user email and password into the firebase auth */
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              : await registerConsumer();

                              /*Inserting the consumer data into the firestore */
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              : addCounser.insertConsumerData(
                                                                  firstNameController.text,
                                                                  lastNameController.text,
                                                                  birthPlaceController.text,
                                                                  contactController.text,
                                                                  selectedMunicipality,
                                                                  selectedBarangay,
                                                                  userNameController.text,
                                                                  idProofUrl,
                                                                  profilePhotoUrl,
                                                                  registerdate2,
                                                                  DateTime.now(),
                                                                  500,
                                                                  0,
                                                                  emailNameController.text,
                                                                  userid,
                                                                );

                              /*If all conditions are met, redirect to the done page */
                              (checkBoxIsChecked == false)
                                  ? showUncheckTermsAndConditions()
                                  : (firstNameController.text == "" ||
                                          lastNameController.text == "" ||
                                          userNameController.text == "" ||
                                          emailNameController.text == "" ||
                                          passwordNameController.text == "" ||
                                          confirmPasswordController.text == "")
                                      ? showAllEmptyTextBox()
                                      : (emailTrue == false)
                                          ? showInvalidEmail()
                                          : (isValidPhoneNumber == false)
                                              ? showInvalidPhoneNumber()
                                              : (correctPasswords == false)
                                                  ? showPasswordMismatched()
                                                  : (isAStrongPassword == false)
                                                      ? showPasswordStrength()
                                                      : (isLegalAge == false)
                                                          ? showIllegalAge()
                                                          : (isUsedUname == true)
                                                              ? showUnameAlreadyUsed()
                                                              // ignore: use_build_context_synchronously
                                                              : Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                    builder: (context) {
                                                                      return const UserRegisterEndPage();
                                                                    },
                                                                  ),
                                                                );
                            },
                            child: const FarmSwapGreenBtn(text: "Register"),
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

/*Function that saves all the data */
  void saveFarmerData() {
    registerFarmer();
    print("Executing");
    addFarmer2.insertFarmerData(
      firstNameController.text,
      lastNameController.text,
      birthPlaceController.text,
      contactController.text,
      selectedMunicipality,
      selectedBarangay,
      userNameController.text,
      documentProofUrl,
      idProofUrl,
      profilePhotoUrl,
      registerdate2,
      DateTime.now(),
      500,
      0,
      emailNameController.text,
      userid,
    );
    print("data saved");
  }

/*Messsage to display when user does not check the checkbox and pressed the register button */
  void showUncheckTermsAndConditions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Information", Colors.blue, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Please agree to our terms and conditions to register an account. Tap the box",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

  void showInvalidEmail() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Invalid Email Address, please enter a valid email",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

  void showInvalidPhoneNumber() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Invalid Philippine phone number, please enter a valid contact number",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

/*Message that will show if user has an unfilled text box */
  void showAllEmptyTextBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Please fill out all the fields",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

/*Message that will show if password mismatched */
  void showPasswordMismatched() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Passowrds Mismatched, please review your password and confirm password fields",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

/*Message that will show if password is not Strong */
  void showPasswordStrength() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Password must have a 8 characters, an upper case letter, a lower case letter and a special character, please modify your password",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

/*Message that will show if password is not Strong */
  void showIllegalAge() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "You must be 18 years old to be able to Register",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

/*Message that will show if password is not Strong */
  void showUnameAlreadyUsed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 17.sp, FontWeight.w500),
          content: poppinsText2(
            "Username is already used",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

// Function to check if the email is valid
  bool isValidEmail(String email) {
    // This is the email validation logic
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
  }

//Function that will check if phone number is a valid philippine phone number
  bool isValidPhilippineNum(String contactNum) {
    return RegExp(r'^(09|\+639)\d{9}$').hasMatch(contactNum);
  }

  /*Function that checks if passwords matched*/
  bool isMatchedPassowrds() {
    if (passwordNameController.text == confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  /*Function that will check if password is a strong password*/
  bool isStrongPassword(String password) {
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp specialCharRegex = RegExp(r'[^a-zA-Z0-9]');

    bool hasLowerCase = lowercaseRegex.hasMatch(password);
    bool hasUpperCase = uppercaseRegex.hasMatch(password);
    bool hasSpecialCharacter = specialCharRegex.hasMatch(password);
    bool passWordLength = password.length >= 8;

    if (hasLowerCase == true &&
        hasUpperCase == true &&
        hasSpecialCharacter == true &&
        passWordLength == true) {
      return true;
    } else {
      return false;
    }
  }

//Functioin that checks if the registering user is on a legal age
  bool isLegalAgeCheck(DateTime bday) {
    DateTime now = DateTime.now();
    DateTime minDate = now.subtract(const Duration(days: 18 * 365));
    if (bday.isBefore(minDate) || bday.isAtSameMomentAs(minDate)) {
      return true;
    } else {
      return false;
    }
  }

//Function that will check if the usename is available
  Future<void> checkUname(String uname) async {
    bool checked = await userNameCheck.userNameCheck(uname);
    setState(() {
      isUsedUname = checked;
    });
  }

//Function for selecting a date
  Future<void> _selectDate2() async {
    DateTime initialDate = registerdate2 ?? DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(initialDate);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          initialDate, // Set the initial date to the current date or registerdate2 if not null
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != registerdate2) {
      String pickedDateFormat = DateFormat('MMMM dd, yyyy').format(pickedDate);
      setState(() {
        registrationdates = pickedDateFormat;
        //Provider.of<UserDetailsProvider>(context, listen: false).setBirthdate(registerdate2);
        registerdate2 = pickedDate;
      });
    }
  }

/*Message that will display when user clicks on terms and conditions */
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

  //FUNCTION THAT ADDS THE USER EMAIL AND PASSWORD TO THE AUTHENTICATION
  Future<void> registerFarmer() async {
    String email = emailNameController.text;
    String password = passwordNameController.text;

    User? user = await userAuthRegister.createEmailPassowrd(email, password);
    if (user != null) {
      setState(() {
        userid = user.uid;
        print('Here is the userid $userid');
      });
    }
  }

  Future<void> registerConsumer() async {
    String email = emailNameController.text;
    String password = passwordNameController.text;
    User? user = await userAuthRegister.createEmailPassowrd(email, password);
    if (user != null) {
      setState(() {
        userid = user.uid;
      });
    }
  }
}
