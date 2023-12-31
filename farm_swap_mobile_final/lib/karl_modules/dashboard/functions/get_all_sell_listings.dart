import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_all_selling_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashBoardGetAllSellListings extends StatefulWidget {
  const DashBoardGetAllSellListings({super.key});

  @override
  State<DashBoardGetAllSellListings> createState() =>
      _DashBoardGetAllSellListingsState();
}

class _DashBoardGetAllSellListingsState
    extends State<DashBoardGetAllSellListings> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collectionGroup('sell').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final barterLists = snapshot.data!.docs;
            // Filtering the barterLists based on listingStatus
            final filteredBarterLists = barterLists.where((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String listingStatus = data["listingstatus"];
              return listingStatus == "ACTIVE" ||
                  listingStatus == "REACTIVATED";
            }).toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: filteredBarterLists.length,
              itemBuilder: (context, index) {
                return accesspromotionDoc(filteredBarterLists[index]);
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

    /*Date Conversions of listing start date*/
    Timestamp timestamp1 = data["listingStartTime"];
    DateTime dateTime1 = timestamp1.toDate();
    String finalStartDate = DateFormat('yyyy-MM-dd').format(dateTime1);

    /*Date Conversions of listing end date */
    Timestamp timestamp2 = data["listingEndTime"];
    DateTime dateTime2 = timestamp2.toDate();
    String finalEndDate = DateFormat('yyyy-MM-dd').format(dateTime2);

    /*This Date conversion is for the promotion date */
    Timestamp timestamp3 = data["promotionDate"];
    // ignore: unused_local_variable
    DateTime promotedTime = timestamp3.toDate();

    /*Firebase data assigned to variables for easy use */
    /*Firebase data assigned to variables for easy use */
    String imageUrl = data["listingpictureUrl"];
    String listingname = data["listingName"];
    String listingPrice = data["listingprice"].toString();
    String listingQuan = data["listingQuantity"].toString();
    String listingStatus = data["listingstatus"];
    bool promoted = data["promoted"];
    String listingCategory = data["listingcategory"];
    String listingDisc = data["listingdiscription"];
    String farmerName = data["farmerFname"];
    String farmerLname = data["farmerLname"];
    String farmerMunicipality = data["farmerMunicipality"];
    String farmerBarangay = data["farmerBaranggay"];
    String farmerUsername = data["farmerUserName"];
    String farmerId = data["farmerId"];
    String listingId = document.id;

    if (listingStatus == "ACTIVE" || listingStatus == "REACTIVATED") {
/*Actual design of widget to be returned */
      return Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DashBoardAllSellDetails(
                    imageUrl: imageUrl,
                    listingname: listingname,
                    listingPrice: listingPrice,
                    promoted: promoted,
                    listingCategory: listingCategory,
                    listingDisc: listingDisc,
                    farmerName: farmerName,
                    farmerLname: farmerLname,
                    farmerMunicipality: farmerMunicipality,
                    farmerBarangay: farmerBarangay,
                    farmerUsername: farmerUsername,
                    startTime: finalStartDate,
                    endTime: finalEndDate,
                    listingQuan: listingQuan,
                    listingStatus: listingStatus,
                    farmerId: farmerId,
                    listingId: listingId,
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
                width: 164.w,
                height: 164.h,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.sp),
                      height: 100.h,
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
                    Padding(
                      padding: EdgeInsets.only(left: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            listingname,
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 10.sp,
                                color: farmSwapTitlegreen,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$listingQuan kilograms",
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 9.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "$listingPrice value",
                            style: TextStyle(
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontSize: 9.sp,
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
    } else {
      return Container();
    }
  }
}
