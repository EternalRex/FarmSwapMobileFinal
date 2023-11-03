import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../database/barter_listing_saving.dart';
import '../screens/listing_subpages/all_listing_page/all_barterlisting_details.dart';

/* 
class GetBarterListings {
/*Instance of the class that gets the individual details of a farmer */
  ListinGetFarmerDetails details = ListinGetFarmerDetails();
  BarterListingSaving barter = BarterListingSaving();

  accessBarterListing(String farmerUname) {
    return StreamBuilder(
      stream: barter.getBarteringListing(farmerUname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
            /*A condition that allows data to be displayed in listview in a horizontal
            direction */
            scrollDirection: Axis.horizontal,
            /*A conditon that states if a data displayed in horizontal direction is above 2 items
            then the third item will be displayed on the next row */
            children: List<Widget>.generate((documents.length / 2).ceil(), (rowIndex) {
              final start = rowIndex * 2;
              final end = (start + 2 < documents.length) ? start + 2 : documents.length;

              return Column(
                children: List.generate(end - start, (index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 13.sp, bottom: 13.sp, right: 10.sp),
                    child: accessDocumentContents(documents[start + index]),
                  );
                }),
              );
            }),
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    /*Firebase data assigned to variables for easy use */
    String imageUrl = data["listingpictureUrl"];
    String listingname = data["listingName"];
    String listingPrice = data["listingprice"].toString();
    String listingQuan = data["listingQuantity"].toString();

    return Container(
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
      width: 180,
      height: 230,
      child: GestureDetector(
        onTap: () {
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              height: 150.sp,
              width: 200.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                /*PUTTING BOX SHADOW ON THE CONTAINER */
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            poppinsText(listingname, farmSwapTitlegreen, 15.sp, FontWeight.w500),
            SizedBox(
              height: 10.sp,
            ),
            poppinsText("$listingPrice " " pesos", Colors.black, 12.sp, FontWeight.normal),
            SizedBox(
              height: 7.sp,
            ),
            poppinsText("$listingQuan " " kg ", Colors.black, 12.sp, FontWeight.normal),
          ],
        ),
      ),
    );
  }
}*/

class GetBarterListings extends StatefulWidget {
  const GetBarterListings({super.key, required this.farmerUname});
  final String farmerUname;

  @override
  State<GetBarterListings> createState() => _GetBarterListingsState();
}

class _GetBarterListingsState extends State<GetBarterListings> {
  BarterListingSaving barter = BarterListingSaving();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barter.getBarteringListing(widget.farmerUname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
            /*A condition that allows data to be displayed in listview in a horizontal
            direction */
            scrollDirection: Axis.horizontal,
            /*A conditon that states if a data displayed in horizontal direction is above 2 items
            then the third item will be displayed on the next row */
            children: List<Widget>.generate((documents.length / 2).ceil(), (rowIndex) {
              final start = rowIndex * 2;
              final end = (start + 2 < documents.length) ? start + 2 : documents.length;

              return Column(
                children: List.generate(end - start, (index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 13.sp, bottom: 13.sp, right: 10.sp),
                    child: accessDocumentContents(documents[start + index]),
                  );
                }),
              );
            }),
          );
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    /*Date Conversions of listing start date*/
    Timestamp timestamp1 = data["listingStartTime"];
    DateTime dateTime1 = timestamp1.toDate();
    String finalStartDate = DateFormat('yyyy-MM-dd').format(dateTime1);

    /*Date Conversions of listing end date */
    Timestamp timestamp2 = data["listingEndTime"];
    DateTime dateTime2 = timestamp2.toDate();
    String finalEndDate = DateFormat('yyyy-MM-dd').format(dateTime2);

    /*Firebase data assigned to variables for easy use */
    String imageUrl = data["listingpictureUrl"];
    String listingname = data["listingName"];
    String listingPrice = data["listingprice"].toString();
    String listingQuan = data["listingQuantity"].toString();
    String listingStatus = data["listingstatus"];
    String prefItem = data["prefferedItem"];
    bool promoted = data["promoted"];
    String listingCategory = data["listingcategory"];
    String listingDisc = data["listingdiscription"];
    String farmerName = data["farmerFname"];
    String farmerLname = data["farmerLname"];
    String farmerMunicipality = data["farmerMunicipality"];
    String farmerBarangay = data["farmerBaranggay"];
    String farmerUsername = data["farmerUserName"];

    if (listingStatus == "ACTIVE") {
      return Container(
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
        height: 240.h,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  /*Passing the values to the constructor of our next page
                  so that we can use this values in that page */
                  return BarterAllListingDetails(
                    url: imageUrl,
                    name: listingname,
                    disc: listingDisc,
                    price: listingPrice,
                    quantity: listingQuan,
                    status: listingStatus,
                    prefItem: prefItem,
                    promoted: promoted,
                    category: listingCategory,
                    start: finalStartDate,
                    end: finalEndDate,
                    fname: farmerName,
                    fLname: farmerLname,
                    fUname: farmerUsername,
                    fmunicipal: farmerMunicipality,
                    fbarangay: farmerBarangay,
                  );
                },
              ),
            );
          },
          /*A column that contains the details being displayed */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                height: 150.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  /*PUTTING BOX SHADOW ON THE CONTAINER */
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              poppinsText(listingname, farmSwapTitlegreen, 15.sp, FontWeight.w500),
              SizedBox(
                height: 10.sp,
              ),
              poppinsText("$listingPrice " " pesos", Colors.black, 12.sp, FontWeight.normal),
              SizedBox(
                height: 7.sp,
              ),
              poppinsText("$listingQuan " " kg ", Colors.black, 12.sp, FontWeight.normal),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
