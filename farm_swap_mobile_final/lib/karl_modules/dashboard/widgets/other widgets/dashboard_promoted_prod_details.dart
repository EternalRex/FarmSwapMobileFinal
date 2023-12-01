import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/entering_barter_item/enter_barter_item.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/active_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_bottom_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/display_farmer_reviews/display_farmer_review.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardPromotedProductDetails extends StatefulWidget {
  const DashboardPromotedProductDetails({
    super.key,
    required this.listingId,
    required this.imageUrl,
    required this.listingname,
    required this.listingPrice,
    required this.prefItem,
    required this.promoted,
    required this.listingCategory,
    required this.listingDisc,
    required this.farmerName,
    required this.farmerLname,
    required this.farmerMunicipality,
    required this.farmerBarangay,
    required this.farmerUsername,
    required this.startTime,
    required this.endTime,
    required this.listingQuan,
    required this.listingStatus,
    required this.farmerId,
  });

  final String listingId;
  final String imageUrl;
  final String listingname;
  final String listingPrice;
  final String listingQuan;
  final String listingStatus;
  final String prefItem;
  final bool promoted;
  final String listingCategory;
  final String listingDisc;
  final String farmerName;
  final String farmerLname;
  final String farmerMunicipality;
  final String farmerBarangay;
  final String farmerUsername;
  final String startTime;
  final String endTime;
  final String farmerId;

  @override
  State<DashboardPromotedProductDetails> createState() =>
      _DashboardPromotedProductDetailsState();
}

class _DashboardPromotedProductDetailsState
    extends State<DashboardPromotedProductDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    String loginUserType =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;

    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Dashboard"),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: greenNormal,
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                  "assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          /*Shoppping cart button */
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.cartShopping),
              iconSize: 30.sp,
            ),
          ),
        ],
      ),
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      /*This is the column that contains two expanded, one for the navbar
       and the other one for the content */
      body: Column(
        children: [
          /*Center area that contains the content */
          Expanded(
            flex: 17,
            child: Container(
              color: Colors.white,
              /*A stack that stacks two containers */
              child: Stack(
                children: [
                  /*First Container contaiing the background image */
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 180.h,
                    ),
                  ),
                  /*Second container containing discripionts and other details */
                  Positioned.fill(
                    top: 140.sp,
                    bottom: 0,
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70.sp),
                          topRight: Radius.circular(70.sp),
                        ),
                        color: Colors.white,
                      ),
                      /*The column that holds everything inline */
                      child: Column(
                        children: [
                          /*Row for the best deals caption */
                          Padding(
                            padding: EdgeInsets.only(left: 40.sp, top: 20.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: farmSwapSmoothGreen,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: poppinsText(
                                      "Best Deals",
                                      darkGreen,
                                      13.sp,
                                      FontWeight.w300,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 80.sp,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: orangeLightActive,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.sp),
                                    child: poppinsText(
                                      "Limited Only",
                                      orangeDark,
                                      13.sp,
                                      FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Column(
                            /*For the lsiting name */
                            children: [
                              poppinsText(
                                widget.listingname,
                                Colors.black,
                                25.sp,
                                FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              /*For discription */
                              SizedBox(
                                width: 300.w,
                                child: Text(
                                  widget.listingDisc,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              /*Row for the location */
                              Padding(
                                padding: EdgeInsets.only(left: 30.sp),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.locationPin,
                                      color: farmSwapTitlegreen,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    poppinsText(
                                      "${widget.farmerBarangay} "
                                      " ${widget.farmerMunicipality}, Cebu, Philippines",
                                      Colors.black54,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              /*Row for the quantity */
                              Padding(
                                padding: EdgeInsets.only(left: 30.sp),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.weightHanging,
                                      color: farmSwapTitlegreen,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    poppinsText(
                                      "${widget.listingQuan} kilograms in total",
                                      Colors.black54,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              /*For for equivalent price */
                              Padding(
                                padding: EdgeInsets.only(left: 30.sp),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.tag,
                                      color: farmSwapTitlegreen,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    poppinsText(
                                      "${widget.listingPrice} pesos equivalent price",
                                      Colors.black54,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              /*For for equivalent price */
                              Padding(
                                padding: EdgeInsets.only(left: 30.sp),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      color: farmSwapTitlegreen,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    poppinsText(
                                      "Available until ${widget.endTime} only",
                                      Colors.black54,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              /*For for preffered Item */
                              Padding(
                                padding: EdgeInsets.only(left: 30.sp),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.stackExchange,
                                      color: farmSwapTitlegreen,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    poppinsText(
                                      "Preffered Item is ${widget.prefItem}",
                                      Colors.black54,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  (loginUserType == "CONSUMER")
                                      ?
                                      /*We used this kind of navigation so that we can pass data to the next class*/
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                          builder: (context) {
                                            /*So ato e pasa ang mga data ni listing ni farmer og item
                                      kay para magamit sa next class */
                                            return EnterToBarterItem(
                                              listingIdNeed: widget.listingId,
                                              listingNameNeed:
                                                  widget.listingname,
                                              listingDiscNeed:
                                                  widget.listingDisc,
                                              listingEquivalentPriceNeed:
                                                  widget.listingPrice,
                                              listingQuantityNeed:
                                                  widget.listingQuan,
                                              listingStatusNeed:
                                                  widget.listingStatus,
                                              farmerFNameNeed:
                                                  widget.farmerName,
                                              farmerUnameNeed:
                                                  widget.farmerUsername,
                                              farmerLnameNeed:
                                                  widget.farmerLname,
                                              farmerBaranggayNeed:
                                                  widget.farmerBarangay,
                                              farmerMunicaplityNeed:
                                                  widget.farmerMunicipality,
                                              farmerId: widget.farmerId,
                                            );
                                          },
                                        ))
                                      : showInvalidMessage();
                                },
                                child: const FarmSwapGreenBtn(text: "Barter"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DisplayFarmerReviews(
                                          farmerId: widget.farmerId,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: poppinsText("Reviews", orangeDark, 15.sp,
                                    FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Navbar areea */
          /*Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: greenNormal,
                image: const DecorationImage(
                  image:
                      AssetImage("assets/karl_assets/images/appbarpattern.png"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: farmSwapTitlegreen),
              ),
              child: const DashboardButtomNavBar(),
            ),
          ),*/
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.sp,
        decoration: BoxDecoration(
          color: greenNormal,
          image: const DecorationImage(
            image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: farmSwapTitlegreen),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: const DashboardButtomNavBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.activeDashboard);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void showInvalidMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Invalid Operation",
            Colors.red,
            17.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "You need to use a consumer account to barter other farmers products",
            Colors.black,
            13.sp,
            FontWeight.w100,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActiveDashboard(),
                  ),
                );
              },
              child: poppinsText(
                  "Back", farmSwapTitlegreen, 13.sp, FontWeight.w500),
            ),
          ],
        );
      },
    );
  }
}
