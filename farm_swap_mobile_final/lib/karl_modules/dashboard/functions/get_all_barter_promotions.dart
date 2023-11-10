import "package:cached_network_image/cached_network_image.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/database/get_all_promotions_querry.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_promoted_prod_details.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";

class GetAllBarterPromotions extends StatefulWidget {
  const GetAllBarterPromotions({super.key});

  @override
  State<GetAllBarterPromotions> createState() => _GetAllBarterPromotionsState();
}

class _GetAllBarterPromotionsState extends State<GetAllBarterPromotions> {
/*Instance of other class used here*/
  GetAllPromotionsQuerry promotion = GetAllPromotionsQuerry();
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collectionGroup('barter').where('promoted', isEqualTo: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final barterListing = snapshot.data!.docs;

            return CarouselSlider.builder(
              itemCount: barterListing.length,
              itemBuilder: (context, index, realIndex) {
                final barterListings = barterListing[index];
                return accesspromotionDoc(barterListings);
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.9,
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
    //Timestamp timestamp3 = data["promotionDate"];
    // DateTime promotedTime = timestamp3.toDate();

    /*Firebase data assigned to variables for easy use */
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

    /*Actual design of widget to be returned */
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return DashboardPromotedProductDetails(
                imageUrl: imageUrl,
                listingname: listingname,
                listingPrice: listingPrice,
                prefItem: prefItem,
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
              );
            },
          ));
        },
        child: Row(
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
                poppinsText(listingname, Colors.black, 20.sp, FontWeight.w500),
                poppinsText("Barter With: $prefItem", Colors.black, 10.sp, FontWeight.normal),
                poppinsText(
                    "Available Until: $finalEndDate", Colors.black, 10.sp, FontWeight.normal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
