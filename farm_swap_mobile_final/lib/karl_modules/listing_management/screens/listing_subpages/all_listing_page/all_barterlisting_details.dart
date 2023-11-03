import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/listing_management_bottomnav.dart';

class BarterAllListingDetails extends StatefulWidget {
  const BarterAllListingDetails({
    super.key,
    required this.url,
    required this.name,
    required this.disc,
    required this.price,
    required this.quantity,
    required this.status,
    required this.prefItem,
    required this.promoted,
    required this.category,
    required this.start,
    required this.end,
    required this.fname,
    required this.fLname,
    required this.fUname,
    required this.fmunicipal,
    required this.fbarangay,
  });
  final String url;
  final String name;
  final String disc;
  final String price;
  final String quantity;
  final String status;
  final String prefItem;
  final bool promoted;
  final String category;
  final String start;
  final String end;
  final String fname;
  final String fLname;
  final String fUname;
  final String fmunicipal;
  final String fbarangay;

  @override
  State<BarterAllListingDetails> createState() => _BarterAllListingDetailsState();
}

class _BarterAllListingDetailsState extends State<BarterAllListingDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*App bar og iyang style */
      appBar: AppBar(
        backgroundColor: greenNormal,
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        /*So mao nani ang condition nga mag depende sa value nga e hatag sa atong provider ang mo display
        nga label sa appbar */
        title: const Text("Barter Listing Details"),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: DashBoardDrawer(),
      /*Body og ang iyang style */
      body: Column(
        children: [
          /*Expanded for the contents */
          Expanded(
            flex: 8,
            /*Mao ni container nga naa sa midle flex*/
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                /*Mao ni column na mag align sa contents vertically solod aning container */
                child: Column(
                  children: [
                    /*Container ni sa atong picture, or background picture*/
                    Container(
                      width: 400.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        /*PUTTING BOX SHADOW ON THE CONTAINER */
                        boxShadow: [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            offset: const Offset(1, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.url),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    /*Container for the other details*/
                    Container(
                      width: 500.w,
                      height: 500.h,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          /*For  the name of listing */
                          Center(
                            child: SizedBox(
                              height: 50.h,
                              width: 240.w,
                              child: Center(
                                child: poppinsText(
                                  widget.name,
                                  Colors.black,
                                  30.sp,
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          /*For the listing discription */
                          Center(
                            child: SizedBox(
                              height: 80.h,
                              width: 220.w,
                              child: poppinsText(widget.disc, Colors.black, 13.sp, FontWeight.w300),
                            ),
                          ),
                          /*For the product quantity*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  poppinsText(
                                    "Quantity:",
                                    farmSwapTitlegreen,
                                    20.sp,
                                    FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    "${widget.quantity} " " kg",
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For the equivalent proce */
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  poppinsText(
                                    "Equiv. Price:",
                                    farmSwapTitlegreen,
                                    20.sp,
                                    FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    "${widget.price} " " pesos",
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*Preffered Barter Item*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  poppinsText(
                                    "Preffered Item:",
                                    farmSwapTitlegreen,
                                    20.sp,
                                    FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    widget.prefItem,
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For Start Time */
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  poppinsText(
                                    "Start:",
                                    farmSwapTitlegreen,
                                    20.sp,
                                    FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    widget.start,
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For End Time*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  poppinsText(
                                    "End:",
                                    farmSwapTitlegreen,
                                    20.sp,
                                    FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    widget.end,
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*For status*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.check,
                                    color: farmSwapTitlegreen,
                                    size: 30.sp,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    widget.status,
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For Promoted*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    (widget.promoted == false)
                                        ? FontAwesomeIcons.xmark
                                        : FontAwesomeIcons.check,
                                    size: 30.sp,
                                    color: (widget.promoted == false)
                                        ? Colors.red
                                        : farmSwapTitlegreen,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    (widget.promoted == false) ? "Not Promoted" : "Promoted",
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For farmer name */
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: farmSwapTitlegreen,
                                    size: 30.sp,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    "${widget.fname} " " ${widget.fLname} " " (${widget.fUname})",
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*For Place*/
                          Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: farmSwapTitlegreen,
                                    size: 30.sp,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  poppinsText(
                                    "${widget.fbarangay} " " ${widget.fmunicipal}",
                                    Colors.black,
                                    15.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //Update field button
                              DecoratedBox(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF53E78B),
                                      Color(0xFF14BE77),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(17.50),
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.transparent.withOpacity(0.38),
                                    disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      'Update Field',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*Expanded for the bottom navbar */
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: greenNormal,
                image: const DecorationImage(
                  image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: farmSwapTitlegreen),
              ),
              child: const ListingManagementBottomNav(),
            ),
          ),
        ],
      ),
    );
  }
}
