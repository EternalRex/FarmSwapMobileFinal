// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/account_management_farmer/provider/update_dropdown.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/database/retrieval/retrieve_deactivate.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/database/retrieval/retrieved_archive.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/database/retrieval/retrieved_update.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/widgets/profile/archived_collection.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/widgets/profile/image_picker.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/widgets/profile/update_details.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/widgets/profile/update_picture.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/widgets/profile/update_textfield.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReadConsumerProfile extends StatefulWidget {
  const ReadConsumerProfile({super.key, required this.userId});

  final String userId;

  @override
  State<ReadConsumerProfile> createState() => _ReadConsumerProfileState();
}

class _ReadConsumerProfileState extends State<ReadConsumerProfile> {
  /*Initializing the update picture class */
  final UpdateProfilePicture updatePicture = UpdateProfilePicture();

  /*Initializing the MoveCollection class */
  final ArchivedCollection movetoarchivedcollecion = ArchivedCollection();

  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('sample_ConsumerUsers');

    return FutureBuilder(
      future: reference.doc(widget.userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          CachedNetworkImageProvider consumerProfile =
              CachedNetworkImageProvider("${data["profilePhoto"]}");

          Timestamp birthdaytimestamp = data['birthdate'];
          DateTime birthDate = birthdaytimestamp.toDate();
          String bdayBirthDate = DateFormat('MM/dd/yyy').format(birthDate);

          Timestamp registertimestamp = data['registrationDate'];
          DateTime registerDate = registertimestamp.toDate();
          String registrationDate =
              DateFormat('MM/dd/yyy').format(registerDate);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: consumerProfile,
                      radius: 60,
                    ),
                    Positioned(
                      top: 80,
                      left: 75,
                      child: IconButton(
                        onPressed: () {},
                        icon: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Center(
                                    child: Text("Choose Profile Picture!"),
                                  ),
                                  content: SizedBox(
                                    height: 280,
                                    child: Column(
                                      children: [
                                        /*This is for picking image in the gallery */
                                        GestureDetector(
                                          // ignore: duplicate_ignore
                                          onTap: () async {
                                            await updatePicture
                                                .uploadImageToFirebaseGallery();
                                            Navigator.of(context)
                                                .pop(); // Close the dialog box
                                            setState(() {
                                              consumerProfile =
                                                  CachedNetworkImageProvider(
                                                      "${data["profilePhoto"]}");
                                            });
                                            Navigator.of(context).pushNamed(
                                                RouteManager.consumerpage);
                                          },
                                          child: PicturePicker(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
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
                                            await updatePicture
                                                .uploadImageToFirebaseCamera();
                                            Navigator.of(context)
                                                .pop(); // Close the dialog box
                                            setState(() {
                                              consumerProfile =
                                                  CachedNetworkImageProvider(
                                                      "${data["profilePhoto"]}");
                                            });
                                            Navigator.of(context).pushNamed(
                                                RouteManager.consumerpage);
                                          },
                                          child: PicturePicker(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
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
                          icon: const Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data["firstname"]}",
                          style: GoogleFonts.viga(
                            textStyle: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${data["lastname"]}",
                          style: GoogleFonts.viga(
                            textStyle: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    poppinsText(
                      "${data["userId"]}",
                      Colors.white,
                      10.sp,
                      FontWeight.w500,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "${data["userRole"]}",
                      style: GoogleFonts.viga(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 180.w,
                    height: 40.h,
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
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          poppinsText(
                            "Status: ",
                            const Color.fromARGB(255, 55, 54, 56),
                            15.sp,
                            FontWeight.w700,
                          ),
                          poppinsText(
                            "${data["accountStatus"]}",
                            greenNormalHover,
                            15.sp,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
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
                                fontSize: 20.sp,
                                color: const Color(0xFF09041B),
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
                                    "Name",
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          greenNormalHover,
                                          12.sp,
                                          FontWeight.w700,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        poppinsText(
                                          " ${data["lastname"]}",
                                          greenNormalHover,
                                          12.sp,
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
                                    "Birth Date",
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          bdayBirthDate,
                                          greenNormalHover,
                                          12.sp,
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
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          greenNormalHover,
                                          12.sp,
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
                                    "Email Address",
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          greenNormalHover,
                                          12.sp,
                                          FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  //birth date
                                  poppinsText(
                                    "Birth Place",
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          greenNormalHover,
                                          12.sp,
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
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          registrationDate,
                                          greenNormalHover,
                                          12.sp,
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
                height: 10.h,
              ),
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
                                fontSize: 20.sp,
                                color: const Color(0xFF09041B),
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
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          " ${data["baranggay"]}",
                                          greenNormalHover,
                                          12.sp,
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
                                    const Color.fromARGB(255, 55, 54, 56),
                                    15.sp,
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
                                          greenNormalHover,
                                          12.sp,
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
                height: 10.h,
              ),
              Container(
                height: 300.h,
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
                                  fontSize: 20.sp,
                                  color: const Color(0xFF09041B),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 250.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "ID Picture",
                                      style: GoogleFonts.viga(
                                        textStyle: TextStyle(
                                          fontSize: 15.sp,
                                          color: const Color.fromARGB(
                                              255, 55, 54, 56),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 200.h,
                                      child: CachedNetworkImage(
                                        imageUrl: data["idProof"],
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                          color: Color(0xFF14BE77),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
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
                height: 15.h,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //update details button
                    SizedBox(
                      height: 50.h,
                      width: 340.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 2,
                                offset: const Offset(2, 5),
                              ),
                            ]),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            selectfieldUpdate(context, "${data["userId"]}");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.update_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  'Update',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    //deactivate account button
                    SizedBox(
                      height: 50.h,
                      width: 340.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 2,
                                offset: const Offset(2, 5),
                              ),
                            ]),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation!"),
                                  content: const Text(
                                      "Are you sure you want to DEACTIVATE your account?\n"
                                      "Click proceed to deactivate account."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Proceed"),
                                      onPressed: () async {
                                        // Create an instance of RetrieveDeactivateDocId
                                        RetrieveDeactivate retriever =
                                            RetrieveDeactivate();

                                        // Call the updateFieldDeactivate method to update
                                        //the account status and create admin logs
                                        await retriever.updateFieldDeactivate();

                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Successful!"),
                                              content: const Text(
                                                  "Account has been successfuly DEACTIVATED!"),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog box

                                                    //this will navigate to log in page
                                                    Navigator.of(context)
                                                        .pushNamed(RouteManager
                                                            .userlogin);
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.do_not_disturb_alt_rounded,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  'Deactivate',
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    //archived account button
                    SizedBox(
                      height: 50.h,
                      width: 340.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 2,
                                offset: const Offset(2, 5),
                              ),
                            ]),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation!"),
                                  content: const Text(
                                      "Are you sure you want to ARCHIVE your account permanently?\n"
                                      "This won't undo the process.\nClick proceed to archive account."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Proceed"),
                                      onPressed: () async {
                                        // Create an instance of RetrieveArchivedDocId
                                        RetrieveArchive retriever =
                                            RetrieveArchive();

                                        // Call the updateFieldAndNavigate method to update
                                        //the account status and create admin logs
                                        await retriever.updateFieldArchive();

                                        //this will move to other collection called sample_FarmerArchived
                                        await movetoarchivedcollecion
                                            .moveConsumerToArchivedCollection();

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
                                                    Navigator.of(context)
                                                        .pushNamed(RouteManager
                                                            .userlogin);
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3, bottom: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  'Archive',
                                  style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.50,
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
              SizedBox(
                height: 10.h,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  //create a variable for updatedValue and selectedValue
  String? updatedValue;
  String? selectedValue;

  //create an instance of UpdateRetrieveDocId
  UpdateRetrive updateRetrieve = UpdateRetrive();
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
                  //first menu item email address
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
                                                      fontSize: 12,
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
                                          icon: const Icon(
                                            Icons.calendar_month,
                                            size: 20,
                                          ),
                                          label: Text(
                                            'Select Date',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              150.w,
                                              20.h,
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
                                          icon: const Icon(
                                            Icons.calendar_month,
                                            size: 20,
                                          ),
                                          label: Text(
                                            'Select Date',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              150.w,
                                              20.h,
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
