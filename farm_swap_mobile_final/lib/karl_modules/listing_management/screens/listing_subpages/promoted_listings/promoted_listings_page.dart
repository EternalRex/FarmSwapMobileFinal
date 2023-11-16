import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/functions/get_sell_promoted_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../functions/get_barter_promoted_listings.dart';

class PromotedListingPage extends StatefulWidget {
  const PromotedListingPage({super.key});

  @override
  State<PromotedListingPage> createState() => _PromotedListingPageState();
}

class _PromotedListingPageState extends State<PromotedListingPage> {
/*Properties for the choice switch color */
  Color container1 = Colors.white;
  Color container2 = Colors.white;
  int containerSelector = 1;
  String listingType = "";

  String farmerUname = "";

/*Instance of the class that gets the individual details of a farmer */
  ListinGetFarmerDetails details = ListinGetFarmerDetails();

  /*Initializing the function that will get the farmers username */
  @override
  void initState() {
    getFarmerUname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 13.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    /*Container for barter option */
                    Container(
                      height: 50.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: container1,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        border: Border.all(color: greenDark),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            containerColor(1);
                          },
                          child: poppinsText(
                            "Barter",
                            farmSwapTitlegreen,
                            20.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    /*Container for sell option */
                    Container(
                      height: 50.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        color: container2,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(color: greenDark),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            containerColor(2);
                          },
                          child: poppinsText(
                            "Sell",
                            farmSwapTitlegreen,
                            20.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                (listingType == "BARTER")
                    ?
                    /*This is the center container that will contain the listings of the farmer */
                    /*Expanded for  */
                    SizedBox(
                        height: 450.h,
                        width: 360.w,
                        child: GetBarterPromotedListings(farmerUname: farmerUname),
                      )
                    : SizedBox(
                        height: 450.h,
                        width: 360.w,
                        child: GetSellListingsPromoted(farmerUname: farmerUname),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void containerColor(int index) {
    setState(() {
      if (index == 1) {
        container1 = blackLightActive;
        container2 = Colors.white;
        containerSelector = 1;
        listingType = "BARTER";
      } else {
        container1 = Colors.white;
        container2 = blackLightActive;
        containerSelector = 2;
        listingType = "SELL";
      }
    });
  }

/*Function that gets the username of the current farmer*/
  Future<void> getFarmerUname() async {
    String uname = await details.getUname();
    setState(() {
      farmerUname = uname;
    });
  }
}
