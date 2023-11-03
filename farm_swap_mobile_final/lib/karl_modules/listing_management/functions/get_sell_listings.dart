import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/sell_listing_saving.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/poppins_text.dart';

/*
class GetSellListings {
  SellListingSaving sell = SellListingSaving();

  accessSellListings(String farmerUname) {
    return StreamBuilder(
      stream: sell.getSellingListing(farmerUname),
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
                    child: accessSellDocumentContents(documents[start + index]),
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

  accessSellDocumentContents(DocumentSnapshot document) {
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
    );
  }
}*/

class GetSellListings extends StatefulWidget {
  const GetSellListings({super.key, required this.farmerUname});
  final String farmerUname;

  @override
  State<GetSellListings> createState() => _GetSellListingsState();
}

class _GetSellListingsState extends State<GetSellListings> {
  SellListingSaving sell = SellListingSaving();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sell.getSellingListing(widget.farmerUname),
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
                    child: accessSellDocumentContents(documents[start + index]),
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

  accessSellDocumentContents(DocumentSnapshot document) {
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
      width: 190.w,
      height: 240.h,
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
    );
  }
}
