import "package:cached_network_image/cached_network_image.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/database/get_all_promotions_querry.dart";
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: promotion.getPromotedBarterListings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print("Here");
            return ListView(scrollDirection: Axis.horizontal, children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: snapshot.data!.docs
                    .map<Widget>((document) => accesspromotionDoc(document))
                    .toList(),
              )
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        } else {
          return const Text("Loading");
        }
      },
    );
  }

  Widget accesspromotionDoc(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

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

    /*Converting time to string values */
    /*Date Conversions of listing start date*/
    Timestamp timestamp1 = data["listingStartTime"];
    DateTime dateTime1 = timestamp1.toDate();
    String startDate = DateFormat('yyyy-MM-dd').format(dateTime1);

    /*Date Conversions of listing end date */
    Timestamp timestamp2 = data["listingEndTime"];
    DateTime dateTime2 = timestamp2.toDate();
    String finalEndDate = DateFormat('yyyy-MM-dd').format(dateTime2);

    /*This Date conversion is for the promotion date */
    Timestamp timestamp3 = data["promotionDate"];
    DateTime promotedTime = timestamp3.toDate();

    /*Actual design of widget to be returned */
    return Container(
      padding: EdgeInsets.all(15.sp),
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        /*PUTTING BOX SHADOW ON THE CONTAINER */
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
