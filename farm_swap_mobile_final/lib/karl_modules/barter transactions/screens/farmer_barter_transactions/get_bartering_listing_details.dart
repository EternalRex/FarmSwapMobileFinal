import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/barter_listing_saving.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class GetBarteringListingDetails extends StatefulWidget {
  const GetBarteringListingDetails({super.key});

  @override
  State<GetBarteringListingDetails> createState() => _GetBarteringListingDetailsState();
}

class _GetBarteringListingDetailsState extends State<GetBarteringListingDetails> {
  BarterListingSaving barterSaving = BarterListingSaving();
  String farmerUname = "";

  @override
  void initState() {
    super.initState();
    getFarmerUname();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: barterSaving.getBarteringListing(farmerUname),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          // final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs
                .map<Widget>((document) => accessDocumentContents(document))
                .toList(),
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

    /*Firebase data assigned to variables for easy use */
    String listingid = document.id;
    String imageUrl = data["listingpictureUrl"];
    String listingname = data["listingName"];
    String listingQuan = data["listingQuantity"].toString();
    String listingStatus = data["listingstatus"];
    bool promoted = data["promoted"];
    String farmerUsername = data["farmerUserName"];
    String farmerId = data["farmerId"];

    if (listingStatus == "ACTIVE" || listingStatus == "REACTIVATED" && promoted != true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.bottomLeft,
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
              /*Pasa nato ang needed na data sa next page nga Farmer list of bids */
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return FarmerListOfBids(
                    farmerId: farmerId,
                    farmerUname: farmerUsername,
                    listingId: listingid,
                    listingUrl: imageUrl,
                  );
                },
              ));
            },
            /*A column that contains the details being displayed */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
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
                      /*Pasa nato ang needed na data sa next page nga Farmer list of bids */
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return FarmerListOfBids(
                            farmerId: farmerId,
                            farmerUname: farmerUsername,
                            listingId: listingid,
                            listingUrl: imageUrl,
                          );
                        },
                      ));
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

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  Future<void> getFarmerUname() async {
    String uname = await farmerDetails.getUname();
    setState(() {
      farmerUname = uname;
    });
  }
}
