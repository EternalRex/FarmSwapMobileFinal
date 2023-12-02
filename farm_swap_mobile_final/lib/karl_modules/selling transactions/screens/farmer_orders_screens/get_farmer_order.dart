import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/farmer_orders_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GetFarmerOrders extends StatefulWidget {
  const GetFarmerOrders({super.key});

  @override
  State<GetFarmerOrders> createState() => _GetFarmerOrdersState();
}

class _GetFarmerOrdersState extends State<GetFarmerOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup("sellbuy")
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('purchaseDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>((document) => accessDocumentContents(document))
                  .toList(),
            );
          }
          return const Text("No Data Found");
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String cId = data["consumerId"];
    String cFName = data["consumerName"];
    String cLname = data["consumerLname"];
    String cLUname = data["consumerUname"];
    String cBarangay = data["consumerBarangay"];
    String cMunicipal = data["consumerMunicipal"];

    String fId = data["farmerId"];
    String fName = data["farmerName"];
    String fLname = data["farmerLname"];
    String fUname = data["farmerUname"];
    String fBarangay = data["farmerBarangay"];
    String fMunicipal = data["farmerMunicipal"];

    String listingid = data["listingId"];
    String listingName = data["listingName"];
    String listingPrice = data["listingPrice"];
    String listingQuan = data["listingQuan"];
    String listingstatus = data["listingStatus"];
    String imageUrl = data["imgurl"];

    double purchasekilograms = (data["purchaseQuan"] as num).toDouble();
    double purchasePrice = (data["purchaseTotalPrice"] as num).toDouble();
    bool purchaseIsComplete = data["purchaseIsComplete"];
    bool confirmed = data["confirmed"];
    bool selected = data["selected"];
    bool declined = data["declined"];

/*Order time conversion*/
    Timestamp orderTime = data["purchaseDate"];
    DateTime newOrderTime = orderTime.toDate();
    String finalOrderTime = DateFormat('yyyy-MM-dd').format(newOrderTime);

    /*Confirmed time conversion */
    Timestamp confirmedTime = data["confirmedDate"];
    DateTime newConfirmedTime = confirmedTime.toDate();
    String finalConfirmedTime =
        DateFormat('yyyy-MM-dd').format(newConfirmedTime);

    /*Completed time conversion */
    // ignore: unused_local_variable
    Timestamp completedTime = data["confirmedDate"];
    DateTime newCompletedTime = confirmedTime.toDate();
    String finalCompletedTime =
        DateFormat('yyyy-MM-dd').format(newCompletedTime);

    if ((listingstatus == "ACTIVE" || listingstatus == "REACTIVATED") &&
        (confirmed == false && selected == false && declined == false)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        /*The oval container*/
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            /*PUTTING BOX SHADOW ON THE CONTAINER */
            boxShadow: [
              BoxShadow(
                color: shadow,
                blurRadius: 2,
                offset: const Offset(1, 5),
              ),
            ],
          ),
          width: 190.w,
          height: 100.h,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FarmerOrderDetails(
                      consName: cFName,
                      consLName: cLname,
                      consUname: cLUname,
                      consId: cId,
                      consBarangay: cBarangay,
                      consMunicipality: cMunicipal,
                      farmerName: fName,
                      farmerLName: fLname,
                      farmerUname: fUname,
                      farmerId: fId,
                      farmerBarangay: fBarangay,
                      farmerMunicipality: fMunicipal,
                      listingName: listingName,
                      listingId: listingid,
                      listingPrice: listingPrice,
                      listingQuantity: listingQuan,
                      purchaseQuantity: purchasekilograms,
                      purchaseTotalPrice: purchasePrice,
                      purchaseTime: finalOrderTime,
                      isCompletedPurchase: purchaseIsComplete,
                      isConfirmed: confirmed,
                      confirmedDate: finalConfirmedTime,
                      completeDate: finalCompletedTime,
                      listingStatus: listingstatus,
                      selected: selected,
                      declined: declined,
                      imageUrl: imageUrl,
                    );
                  },
                ),
              );
            },
            /*A column that contains the details being displayed */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*Container that contains the image */
                Container(
                  padding: EdgeInsets.all(15.sp),
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    /*PUTTING BOX SHADOW ON THE CONTAINER */
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        listingName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: farmSwapTitlegreen,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        "${purchasekilograms.toString()} kilograms",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        finalOrderTime,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.sp),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FarmerOrderDetails(
                              consName: cFName,
                              consLName: cLname,
                              consUname: cLUname,
                              consId: cId,
                              consBarangay: cBarangay,
                              consMunicipality: cMunicipal,
                              farmerName: fName,
                              farmerLName: fLname,
                              farmerUname: fUname,
                              farmerId: fId,
                              farmerBarangay: fBarangay,
                              farmerMunicipality: fMunicipal,
                              listingName: listingName,
                              listingId: listingid,
                              listingPrice: listingPrice,
                              listingQuantity: listingQuan,
                              purchaseQuantity: purchasekilograms,
                              purchaseTotalPrice: purchasePrice,
                              purchaseTime: finalOrderTime,
                              isCompletedPurchase: purchaseIsComplete,
                              isConfirmed: confirmed,
                              confirmedDate: finalConfirmedTime,
                              completeDate: finalCompletedTime,
                              listingStatus: listingstatus,
                              selected: selected,
                              declined: declined,
                              imageUrl: imageUrl,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      color: farmSwapTitlegreen,
                    ),
                    iconSize: 25.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
