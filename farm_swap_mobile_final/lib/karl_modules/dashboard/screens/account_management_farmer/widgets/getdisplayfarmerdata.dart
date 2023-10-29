import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DisplayFarmerProfileData extends StatefulWidget {
  const DisplayFarmerProfileData({super.key, required this.documentId});

  final String documentId;

  @override
  State<DisplayFarmerProfileData> createState() =>
      _DisplayFarmerProfileDataState();
}

class _DisplayFarmerProfileDataState extends State<DisplayFarmerProfileData> {
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

          final profileImage =
              CachedNetworkImageProvider("${data["profilePhoto"]}");

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
                    radius: 40,
                    backgroundImage: profileImage,
                  ),
                  Positioned(
                    top: 46,
                    left: 45,
                    child: IconButton(
                      icon: const Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.sp,
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
              const SizedBox(
                height: 10,
              ),
              //this align is para sa account status of the current user
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 180,
                  height: 50,
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
              const SizedBox(
                height: 5,
              ),
              /*this container is for the current user personal information 
              this include email, full name, contact num, bdate, bplace and reg date
              */
              Container(
                height: 240,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            "Profile Information",
                            style: GoogleFonts.viga(
                              textStyle: const TextStyle(
                                fontSize: 15,
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
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Email Address",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //full name combination of first name and last name
                                  poppinsText(
                                    "Full Name",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //contact number
                                  poppinsText(
                                    "Contact Number",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //birth place
                                  poppinsText(
                                    "Birth Place",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //birth date
                                  poppinsText(
                                    "Birth Date",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //register date
                                  poppinsText(
                                    "Registration Date",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
              const SizedBox(
                height: 5,
              ),

              //this container is for the current user address specified into baranggay and municipality
              Container(
                height: 110,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            "Address",
                            style: GoogleFonts.viga(
                              textStyle: const TextStyle(
                                fontSize: 15,
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
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Baranggay",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //email address
                                  poppinsText(
                                    "Municipality",
                                    Colors.black,
                                    12.sp,
                                    FontWeight.w700,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 160,
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
                                        const SizedBox(
                                          width: 5,
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
              const SizedBox(
                height: 5,
              ),
              //this container is for the attachments picture
              Container(
                height: 260,
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
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Attachment/s",
                              style: GoogleFonts.viga(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                                height: 200,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Document Piture",
                                      style: GoogleFonts.viga(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CachedNetworkImage(
                                        imageUrl: data[
                                            "documentProof"], // The URL of the image
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(), // Display a loading indicator while the image is loading
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons
                                                .error), // Display an error icon if the image fails to load
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
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
                                height: 200,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "ID Picture",
                                      style: GoogleFonts.viga(
                                        textStyle: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CachedNetworkImage(
                                        imageUrl: data[
                                            "idProof"], // The URL of the image
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(), // Display a loading indicator while the image is loading
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons
                                                .error), // Display an error icon if the image fails to load
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
              const SizedBox(
                height: 5,
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
                      child: const Row(
                        children: [
                          Icon(Icons.update_rounded),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Update"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    //deactivate account button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.do_not_disturb),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Deactivate"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    //archived account button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Archive"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
