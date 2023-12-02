import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/other widgets/dashboard_all_best_details.dart';

class DashBoardGetAllBestListings extends StatefulWidget {
  const DashBoardGetAllBestListings({super.key});

  @override
  State<DashBoardGetAllBestListings> createState() =>
      _DashBoardGetAllBestListingsState();
}

class _DashBoardGetAllBestListingsState
    extends State<DashBoardGetAllBestListings> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('sample_PromotionListings')
          .where("status", isEqualTo: "PROMOTED")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final bestLists = snapshot.data!.docs;

            return ListView.builder(
              itemCount: bestLists.length,
              itemBuilder: (context, index) {
                return accesspromotionDoc(bestLists[index]);
              },
            );
          }
        }
        return const Text("Loading....");
      },
    );
  }

  Widget accesspromotionDoc(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    /*Firebase data assigned to variables for easy use */
    /*Firebase data assigned to variables for easy use */
    String imageUrl = data["listingPicture"];
    String listingname = data["listingName"];
    String listingPrice = data["listingPrice"].toString();
    String listingQuan = data["listingQuantity"].toString();
    String listingStatus = data["status"];
    String listingCategory = data["listingCategory"];
    String listingDesc = data["listingDescription"];
    String farmerName = data["firstname"];
    String farmerLname = data["lastname"];
    String farmerAddress = data["address"];
    /*Date Conversions of listing start date*/
    Timestamp timestamp1 = data["listingStartDate"];
    DateTime dateTime1 = timestamp1.toDate();
    String finalStartDate = DateFormat('yyyy-MM-dd').format(dateTime1);

    /*Date Conversions of listing end date */
    Timestamp timestamp2 = data["listingEndDate"];
    DateTime dateTime2 = timestamp2.toDate();
    String finalEndDate = DateFormat('yyyy-MM-dd').format(dateTime2);

    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return DashBoardAllBestProductsDetails(
                  imageUrl: imageUrl,
                  listingname: listingname,
                  listingPrice: listingPrice,
                  listingCategory: listingCategory,
                  listingDesc: listingDesc,
                  farmerName: farmerName,
                  farmerLname: farmerLname,
                  farmerAddress: farmerAddress,
                  startTime: finalStartDate,
                  endTime: finalEndDate,
                  listingQuan: listingQuan,
                  listingStatus: listingStatus,
                );
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadow,
                    blurRadius: 2,
                    offset: const Offset(1, 5),
                  ),
                ],
              ),
              width: 340.w,
              height: 100.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    padding: EdgeInsets.all(15.sp),
                    height: 90.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.sp),
                      ),
                      /*PUTTING BOX SHADOW ON THE CONTAINER */
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 150.w,
                    height: 70.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          listingname,
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 25.sp,
                              color: farmSwapTitlegreen,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "$listingQuan kilograms",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "$listingPrice value",
                          style: TextStyle(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
