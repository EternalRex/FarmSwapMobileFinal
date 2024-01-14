// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/custom_image_picker.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/update_dropdown.dart';
import 'move_to_Archived_Collection.dart';
import 'retrieve_DocId/retrieve_archivedDocID.dart';
import 'retrieve_DocId/retrieve_deactivateDocID.dart';
import 'retrieve_DocId/retrieve_updateDocID.dart';
import 'textfield/update_textfield.dart';
import 'updateDetails_Fields_Class.dart';
import 'update_uploadProfile_Functions.dart';

class DisplayFarmerProfileData extends StatefulWidget {
  const DisplayFarmerProfileData({super.key, required this.documentId});

  final String documentId;

  @override
  State<DisplayFarmerProfileData> createState() =>
      _DisplayFarmerProfileDataState();
}

class _DisplayFarmerProfileDataState extends State<DisplayFarmerProfileData> {
  /*Initializing the update picture class */
  final UpdateProfilePicture updatePicture = UpdateProfilePicture();
  /*Initializing the MoveCollection class */
  final MoveCollection movetoarchivedcollecion = MoveCollection();
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");

    return FutureBuilder(
      future: reference.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          Timestamp datatimestamp = data["birthdate"];
          DateTime birthdate = datatimestamp.toDate();
          String finalBirthdate = DateFormat('yyy-MM-dd').format(birthdate);

          Timestamp datatimestampreg = data["registrationDate"];
          DateTime registerdate = datatimestampreg.toDate();
          String finalRegisterDate =
              DateFormat('yyy-MM-dd').format(registerdate);

          return Column(
            children: [
              /*in this stack naa ang profile photo of the current user
              where in maka change siya sa iya profile whenever iya i click ang camera icon
              */
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40.sp,
                    backgroundImage:
                        CachedNetworkImageProvider("${data["profilePhoto"]}"),
                  ),
                  Positioned(
                    top: 46,
                    left: 45,
                    child: IconButton(
                      icon: const Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text("Choose Profile Picture!"),
                              ),
                              content: SizedBox(
                                height: 280.h,
                                child: Column(
                                  children: [
                                    /*This is for picking image in the gallery */
                                    GestureDetector(
                                      onTap: () async {
                                        // Start loading state
                                        _showLoadingDialog(context);
                                        await updatePicture
                                            .uploadImageToFirebaseGallery();
                                        Navigator.of(context)
                                            .pop(); // Close the dialog box
                                        Navigator.of(context).pushNamed(
                                            RouteManager
                                                .farmeraccountmanagement);
                                      },
                                      child: CustomPicturePicker(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: 200.sp,
                                        imagePath:
                                            "assets/karl_assets/images/Gallery.svg",
                                        title: "From Gallery",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    /*This is for picking image in the camera */
                                    GestureDetector(
                                      onTap: () async {
                                        // Start loading state
                                        _showLoadingDialog(context);
                                        await updatePicture
                                            .uploadImageToFirebaseCamera();
                                        Navigator.of(context)
                                            .pop(); // Close the dialog box
                                        Navigator.of(context).pushNamed(
                                            RouteManager
                                                .farmeraccountmanagement);
                                      },
                                      child: CustomPicturePicker(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: 200.sp,
                                        imagePath:
                                            "assets/karl_assets/images/camera.svg",
                                        title: "From Camera",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog box
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              //dire kay ang full name, id and the user role
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        poppinsText(
                          "${data["firstname"]}",
                          Colors.white,
                          20.sp,
                          FontWeight.w700,
                        ),
                        poppinsText(
                          " ${data["lastname"]}",
                          Colors.white,
                          20.sp,
                          FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    poppinsText(
                      "${data["userId"]}",
                      Colors.white,
                      10.sp,
                      FontWeight.w700,
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    poppinsText(
                      "${data["userRole"]}",
                      Colors.white,
                      12.sp,
                      FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              //this align is para sa account status of the current user
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 180.h,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        poppinsText(
                          "Status : ",
                          Colors.black,
                          12.sp,
                          FontWeight.w700,
                        ),
                        poppinsText(
                          "${data["accountStatus"]}",
                          Colors.black,
                          12.sp,
                          FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              /*this container is for the current user personal information 
              this include email, full name, contact num, bdate, bplace and reg date
              */
              Container(
                height: 240.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 13.w,
                          ),
                          Text(
                            "Profile Information",
                            style: GoogleFonts.viga(
                              textStyle: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Email Address",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["email"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //full name combination of first name and last name
                                  poppinsText(
                                    "Full Name",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["firstname"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                        poppinsText(
                                          " ${data["lastname"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //contact number
                                  poppinsText(
                                    "Contact Number",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["contactnum"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //birth place
                                  poppinsText(
                                    "Birth Place",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["birthplace"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //birth date
                                  poppinsText(
                                    "Birth Date",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          finalBirthdate,
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //register date
                                  poppinsText(
                                    "Registration Date",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          finalRegisterDate,
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),

              //this container is for the current user address specified into baranggay and municipality
              Container(
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 13.w,
                          ),
                          Text(
                            "Address",
                            style: GoogleFonts.viga(
                              textStyle: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Baranggay",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["city_baranggay"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Municipality",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35.h,
                                    width: 160.w,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      border: Border.all(
                                        color: blackLightActive,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        poppinsText(
                                          " ${data["city_municipality"]}",
                                          Colors.black,
                                          10.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              //this container is for the attachments picture
              Container(
                height: 260.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Attachment/s",
                              style: GoogleFonts.viga(
                                textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadow,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                height: 200.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Document Picture",
                                      style: GoogleFonts.viga(
                                        textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      height: 150.h,
                                      child: CachedNetworkImage(
                                        imageUrl: data[
                                            "documentProof"], // The URL of the image
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(), // Display a loading indicator while the image is loading
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.green,
                                        ), // Display an error icon if the image fails to load
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadow,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                height: 200.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "ID Picture",
                                      style: GoogleFonts.viga(
                                        textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150.w,
                                      height: 150.h,
                                      child: CachedNetworkImage(
                                        imageUrl: data[
                                            "idProof"], // The URL of the image
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(), // Display a loading indicator while the image is loading
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Colors
                                                    .green), // Display an error icon if the image fails to load
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              //para sa update, deeactivate and archive account button for the current user
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //update details button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.update_rounded),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Update",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                      onPressed: () {
                        selectfieldUpdate(context, "${data["userId"]}");
                      },
                    ),
                    //deactivate account button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.do_not_disturb),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Deactivate",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmation!"),
                              content: const Text(
                                  "Are you sure you want to deactivate your account?\n"
                                  "Click proceed to deactivate account."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Proceed"),
                                  onPressed: () async {
                                    // Create an instance of RetrieveDeactivateDocId
                                    RetrieveDeactivateDocId retriever =
                                        RetrieveDeactivateDocId();

                                    // Call the updateFieldDeactivate method to update
                                    //the account status and create admin logs
                                    await retriever.updateFieldDeactivate();

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Successful!"),
                                          content: const Text(
                                              "Account successfuly deactivated!"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog box

                                                //this will navigate to log in page
                                                Navigator.of(context).pushNamed(
                                                    RouteManager.userlogin);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog box
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    //archived account button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.delete),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Archive",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmation!"),
                              content: const Text(
                                  "Are you sure you want to archived your account permanently?\n"
                                  "This won't undo the process.\nClick proceed to archive account."),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Proceed"),
                                  onPressed: () async {
                                    // Create an instance of RetrieveArchivedDocId
                                    RetrieveArchiveDocId retriever =
                                        RetrieveArchiveDocId();

                                    // Call the updateFieldAndNavigate method to update
                                    //the account status and create admin logs
                                    await retriever.updateFieldArchive();

                                    //this will move to other collection called sample_FarmerArchived
                                    await movetoarchivedcollecion
                                        .moveUserToArchivedCollection();

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Successful!"),
                                          content: const Text(
                                              "Account successfuly archived!"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Ok"),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog box

                                                //this will navigate to log in page
                                                Navigator.of(context).pushNamed(
                                                    RouteManager.userlogin);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog box
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  // Display loading dialog
  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
              SizedBox(width: 16),
              Text("Uploading..."),
            ],
          ),
        );
      },
    );
  }

  //create a variable for updatedValue and selectedValue
  String? updatedValue;
  String? selectedValue;

  //create an instance of UpdateRetrieveDocId
  UpdateRetriveDocId updateRetrieve = UpdateRetriveDocId();
  Widget updateLabel = const Text("Type here");
  TextEditingController updateController = TextEditingController();
  UpdateFields updatefield = UpdateFields();

  //create a variable date time for the register date nad birthdate
  DateTime registerdate = DateTime.now();
  DateTime birthdate = DateTime.now();

  //this function is for selecting field to update in a dropdown
  void selectfieldUpdate(BuildContext context, String passeduid) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                "Choose Field to Update.",
              ),
              content: DropdownButton<String>(
                value: selectedValue,
                items: [
                  /*first menu item email address
                  DropdownMenuItem(
                    value: "email",
                    child: GestureDetector(
                        child: const Text(
                          "Email Address",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Email Address"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update the email address field
                                                  updatefield.updateEmailField(
                                                      context,
                                                      updatedValue,
                                                      passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  */
                  //second menu item password
                  DropdownMenuItem(
                    value: "password",
                    child: GestureDetector(
                        child: const Text(
                          "Password",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Password"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update the password field
                                                  updatefield
                                                      .updatePasswordField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //third menu item first name
                  DropdownMenuItem(
                    value: "firstName",
                    child: GestureDetector(
                        child: const Text(
                          "First Name",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter First Name"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update the firstname field
                                                  updatefield
                                                      .updateFirstNameField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //fourth menu item last name
                  DropdownMenuItem(
                    value: "lastName",
                    child: GestureDetector(
                        child: const Text(
                          "Last Name",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Last Name"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update the lastname field
                                                  updatefield
                                                      .updateLastNameField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //fifth menu item  contact number
                  DropdownMenuItem(
                    value: "contactNum",
                    child: GestureDetector(
                        child: const Text(
                          "Contact Number",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Contact Number"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update contact number field
                                                  updatefield
                                                      .updateContactNumField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //sixth menu item birthplace
                  DropdownMenuItem(
                    value: "birthplace",
                    child: GestureDetector(
                        child: const Text(
                          "Birth Place",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Birth Place"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update birthplace field
                                                  updatefield
                                                      .updateBirthPlaceField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //seventh menu item birthdate
                  DropdownMenuItem(
                    value: "birthdate",
                    child: GestureDetector(
                      child: const Text("Birth Date"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Select Birthdate"),
                              content: SizedBox(
                                height: 40.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                      child: GestureDetector(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            selectDateBirth(context, passeduid);
                                          },
                                          icon: Icon(
                                            Icons.calendar_month,
                                            size: 20.sp,
                                          ),
                                          label: Text(
                                            'Select Date',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              150.sp,
                                              20.sp,
                                            ),
                                            textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            backgroundColor: Colors.lightBlue,
                                            foregroundColor: Colors.black,
                                            shadowColor: shadow,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                SizedBox(
                                  height: 30.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //Update field button
                                        DecoratedBox(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF53E78B),
                                                Color(0xFF14BE77),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              disabledForegroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.38),
                                              disabledBackgroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.12),
                                              shadowColor: Colors.transparent,
                                            ),
                                            onPressed: () {
                                              updatefield.updateBirthdateField(
                                                  context,
                                                  birthdate,
                                                  passeduid);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, bottom: 3),
                                              child: Text(
                                                'Update Field',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  //eigth menu item regdate
                  DropdownMenuItem(
                    value: "regdate",
                    child: GestureDetector(
                      child: const Text("Registration Date"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Select Registration Date"),
                              content: SizedBox(
                                height: 40.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                      child: GestureDetector(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            selectRegDate(context, passeduid);
                                          },
                                          icon: Icon(
                                            Icons.calendar_month,
                                            size: 20.sp,
                                          ),
                                          label: Text(
                                            'Select Date',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              150.sp,
                                              20.sp,
                                            ),
                                            textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            backgroundColor: Colors.lightBlue,
                                            foregroundColor: Colors.black,
                                            shadowColor: shadow,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                SizedBox(
                                  height: 30.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //Update field button
                                        DecoratedBox(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFF53E78B),
                                                Color(0xFF14BE77),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              disabledForegroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.38),
                                              disabledBackgroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.12),
                                              shadowColor: Colors.transparent,
                                            ),
                                            onPressed: () {
                                              updatefield.updateRegDateField(
                                                  context,
                                                  registerdate,
                                                  passeduid);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3, bottom: 3),
                                              child: Text(
                                                'Update Field',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.50,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  //ninth menu item baranggay
                  DropdownMenuItem(
                    value: "baranggay",
                    child: GestureDetector(
                        child: const Text(
                          "Baranggay",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Enter Baranggay Address"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update baranggay field
                                                  updatefield
                                                      .updateBaranggayField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                  //tenth menu item municipality
                  DropdownMenuItem(
                    value: "municipality",
                    child: GestureDetector(
                        child: const Text(
                          "Municipality",
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text("Enter Municipality Address"),
                                  content: UpdateTextfield(
                                    label: updateLabel,
                                    updateControllerField: updateController,
                                    textType: false,
                                  ),
                                  actions: [
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //Update field button
                                            DecoratedBox(
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xFF53E78B),
                                                    Color(0xFF14BE77),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(17.50),
                                                ),
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  disabledForegroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.38),
                                                  disabledBackgroundColor:
                                                      Colors.transparent
                                                          .withOpacity(0.12),
                                                  shadowColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  updatedValue =
                                                      updateController.text;

                                                  UpdateFields updatefield =
                                                      UpdateFields();
                                                  //calling the function to update municipality field
                                                  updatefield
                                                      .updateMunicipalityField(
                                                          context,
                                                          updatedValue,
                                                          passeduid);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  child: Text(
                                                    'Update Field',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                ],
                onChanged: (value) {
                  selectedValue = value;
                  Provider.of<UpdateDropDownHint>(context, listen: false)
                      .setHint(value!);
                },
              ));
        });
  }

  //a function for selecting date birth
  Future<void> selectDateBirth(BuildContext context, String userid) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthdate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != birthdate) {
      birthdate = pickedDate;
    }
  }

  //a function for selecting date birth
  Future<void> selectRegDate(BuildContext context, String userid) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: registerdate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != registerdate) {
      registerdate = pickedDate;
    }
  }
}
