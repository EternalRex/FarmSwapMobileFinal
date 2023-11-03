import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/barter_listing_saving.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/functions/get_barter_listings.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/functions/get_sell_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllListingsList extends StatefulWidget {
  const AllListingsList({super.key});

  @override
  State<AllListingsList> createState() => _AllListingsListState();
}

class _AllListingsListState extends State<AllListingsList> {
  /*Properties for the choice switch color */
  Color container1 = Colors.white;
  Color container2 = Colors.white;
  int containerSelector = 1;
  String listingType = "";

  /*Instance of the class for barter database */
  BarterListingSaving barter = BarterListingSaving();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*This row is para ni sa katong choices asa iya e select, for barter or for
      selling na listings */
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
                  Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 360.w,
                          child: GetBarterListings(farmerUname: farmerUname),
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 360.w,
                          child: GetSellListings(farmerUname: farmerUname),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  /*A function that will change the color of the container when it is tapped */
  void containerColor(int index) {
    setState(() {
      if (index == 1) {
        container1 = Colors.black;
        container2 = Colors.white;
        containerSelector = 1;
        listingType = "BARTER";
      } else {
        container1 = Colors.white;
        container2 = Colors.black;
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
