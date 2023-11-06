import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/barter_listing_saving.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/archive_pistings_page/archived_barterlistingsdetails_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class GetBarterArchiveListings extends StatefulWidget {
  const GetBarterArchiveListings({super.key, required this.farmerUname});
  final String farmerUname;

  @override
  State<GetBarterArchiveListings> createState() => _GetBarterArchiveListingsState();
}

class _GetBarterArchiveListingsState extends State<GetBarterArchiveListings> {
  BarterListingSaving barter = BarterListingSaving();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barter.getBarteringListing(widget.farmerUname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs
                .map<Widget>((document) => accessDocumentContents(document))
                .toList(),
          );
          /*final List<DocumentSnapshot> documents = snapshot.data!.docs;
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
                    padding: EdgeInsets.only(left: 3.sp, bottom: 13.sp, right: 10.sp),
                    child: accessDocumentContents(documents[start + index]),
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

/*A condition that states that only display the listings that have both an active
status and a promoted field that is equal to true */
    if (listingStatus == "ARCHIVE") {
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
                    return ArchivedBarterListingDetails(
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
                            return ArchivedBarterListingDetails(
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
