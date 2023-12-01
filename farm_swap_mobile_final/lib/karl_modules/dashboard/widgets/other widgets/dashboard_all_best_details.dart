import 'package:farm_swap_mobile_final/clare_modules/pages/consumer_cart/screens/cart_order.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/label/wallet_textfield_label.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_bottom_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/place_order_screens/buy_order_1.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/colors.dart';

class DashBoardAllBestProductsDetails extends StatefulWidget {
  const DashBoardAllBestProductsDetails({
    super.key,
    required this.imageUrl,
    required this.listingname,
    required this.listingPrice,
    required this.listingCategory,
    required this.listingDesc,
    required this.farmerName,
    required this.farmerLname,
    required this.farmerAddress,
    required this.startTime,
    required this.endTime,
    required this.listingQuan,
    required this.listingStatus,
  });

  final String imageUrl;
  final String listingname;
  final String listingPrice;
  final String listingQuan;
  final String listingStatus;
  final String listingCategory;
  final String listingDesc;
  final String farmerName;
  final String farmerLname;
  final String farmerAddress;
  final String startTime;
  final String endTime;

  @override
  State<DashBoardAllBestProductsDetails> createState() =>
      _DashBoardAllBestProductsDetailsState();
}

class _DashBoardAllBestProductsDetailsState
    extends State<DashBoardAllBestProductsDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  double rating = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userRole =
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
                                      "Fresh Deals",
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
                                      "Best Quality",
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
                                  widget.listingDesc,
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
                              /*Diri ang condtion kung pila ang e display s arating depende sa pula ka value ang stars */
                              (rating <= 1)
                                  ? Icon(
                                      Icons.star,
                                      color: darkGreen,
                                    )
                                  : (rating > 1 && rating <= 2)
                                      ? Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: darkGreen,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: darkGreen,
                                              ),
                                            ],
                                          ),
                                        )
                                      : (rating > 2 && rating <= 3)
                                          ? Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: darkGreen,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: darkGreen,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: darkGreen,
                                                  )
                                                ],
                                              ),
                                            )
                                          : (rating > 3 && rating <= 4)
                                              ? Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: darkGreen,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: darkGreen,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: darkGreen,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: darkGreen,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : (rating > 4 && rating <= 5)
                                                  ? Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: darkGreen,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: darkGreen,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: darkGreen,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: darkGreen,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: darkGreen,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
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
                                      "${widget.farmerAddress} , Cebu, Philippines",
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
                                      "${widget.listingPrice} pesos per kilo",
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
                              /*IF ang user kay consumer mo display ang mga button
                                else container ray mo display walay buttons*/
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
          title: poppinsText("Warning!", Colors.blue, 20.sp, FontWeight.bold),
          content: poppinsText(
            "As of now farmer can't buy a single product.",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Go to Cart"))
          ],
        );
      },
    );
  }
}
