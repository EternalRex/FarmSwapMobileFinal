import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/poppins_text.dart';

class GetAllSellPromotions extends StatefulWidget {
  const GetAllSellPromotions({super.key});

  @override
  State<GetAllSellPromotions> createState() => _GetAllSellPromotionsState();
}

class _GetAllSellPromotionsState extends State<GetAllSellPromotions> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collectionGroup('sell')
          .where('promoted', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final sellListing = snapshot.data!.docs;

            return CarouselSlider.builder(
              itemCount: sellListing.length,
              itemBuilder: (context, index, realIndex) {
                final sellListings = sellListing[index];
                return accesspromotionDoc(sellListings);
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.99,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
              ),
            );

            /*return ListView(
              children:
                  snapshot.data!.docs.map((document) => accesspromotionDoc(document)).toList(),
            );*/
            /* return ListView.builder(
              itemCount: barterListing.length,
              itemBuilder: (context, index) {
                final barterListings = barterListing[index];
                return ListTile(
                  title: Text(barterListings["listingName"]),
                );
              },
            );*/
          }
        }
        return const Text("Loading");
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
    DateTime promotedDate = timestamp3.toDate();

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
    /*Actual design of widget to be returned */
    return GestureDetector(
      onTap: () {
        print("Hi");
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 39, 107, 163),
              Color.fromARGB(255, 48, 175, 192),
              Color.fromARGB(255, 99, 176, 102),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15.sp),
                height: 100.h,
                width: 100.w,
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
                width: 15.sp,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText(
                      listingname, Colors.white, 20.sp, FontWeight.w800),
                  poppinsText("$listingPrice only  per kilogrm", Colors.white,
                      10.sp, FontWeight.normal),
                  poppinsText("Available Until: $finalEndDate", Colors.white,
                      10.sp, FontWeight.normal),
                ],
              ),
              SizedBox(
                width: 15.sp,
              ),
              Image.asset(
                'assets/karl_assets/images/banner.png',
                height: 70.h,
                width: 70.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
