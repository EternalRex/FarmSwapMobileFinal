import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/archive_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/sell_listing_saving.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/unpromote_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/all_listing_page/all_sellinglisting_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../common/poppins_text.dart';

class GetSellListings extends StatefulWidget {
  const GetSellListings({super.key, required this.farmerUname});
  final String farmerUname;

  @override
  State<GetSellListings> createState() => _GetSellListingsState();
}

class _GetSellListingsState extends State<GetSellListings> {
  /*Instance of the other classes */
  SellListingSaving sell = SellListingSaving();
  ArchiveUpdateListing archive = ArchiveUpdateListing();
  UnpromoteProduct unpromote = UnpromoteProduct();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sell.getSellingListing(widget.farmerUname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs
                .map<Widget>((document) => accessSellDocumentContents(document))
                .toList(),
          );

          /*return ListView(
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
          );*/
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  accessSellDocumentContents(DocumentSnapshot document) {
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
    DateTime promotedTime = timestamp3.toDate();

    /*Archiving time check, if the current time today is  after the expiration date, then the
    listing status will be archived*/
    DateTime now = DateTime.now();
    if (now.isAfter(dateTime2)) {
      archive.archiveSellingListing(data["farmerUserName"], data["listingpictureUrl"]);
    }

    /*This is a condition that states nga if the current time exceeds 7 days from the promotion date
    then the promotion status will be changed to false / for testing purposes during defense we can
    change the duration to days to just 1*/

    /*Aton kwa on ang difference sa number of days between sa karon og sa promoted time sa listing 
    then butang tag condition nga if difference gani sa both time is 7 greater than 7 days so ato e
    update ang promotion status sa listing into false.*/
    Duration differenceTime = now.difference(promotedTime);
    if (differenceTime > const Duration(days: 7) && data["promoted"] == true) {
      unpromote.unpromoteSellingUpdate(data["farmerUserName"], data["listingpictureUrl"]);
    }

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

    if (listingStatus == "ACTIVE" && promoted != true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
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
                    return SellingAllListingDetails(
                      url: imageUrl,
                      name: listingname,
                      disc: listingDisc,
                      price: listingPrice,
                      quantity: listingQuan,
                      status: listingStatus,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.sp),
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
                    poppinsText(
                      listingname,
                      farmSwapTitlegreen,
                      15.sp,
                      FontWeight.w500,
                    ),
                    poppinsText(
                      "$listingQuan kg",
                      Colors.black,
                      13.sp,
                      FontWeight.w300,
                    ),
                    poppinsText(
                      finalStartDate,
                      Colors.black,
                      13.sp,
                      FontWeight.w300,
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
                            return SellingAllListingDetails(
                              url: imageUrl,
                              name: listingname,
                              disc: listingDisc,
                              price: listingPrice,
                              quantity: listingQuan,
                              status: listingStatus,
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
