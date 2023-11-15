import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerListOfBidsDetils extends StatefulWidget {
  const FarmerListOfBidsDetils({
    super.key,
    required this.imgurl,
    required this.itemname,
    required this.itemquan,
    required this.itemVal,
    required this.itemCond,
    required this.itemDisc,
    required this.bidTime,
    required this.listId,
    required this.listName,
    required this.listStat,
    required this.listPrice,
    required this.listQuan,
    required this.consname,
    required this.consid,
    required this.conslname,
    required this.consuname,
    required this.consbarangay,
    required this.consmunicipal,
  });

  final String imgurl;
  final String itemname;
  final String itemquan;
  final String itemVal;
  final String itemCond;
  final String itemDisc;
  final String bidTime;

  final String listId;
  final String listName;
  final String listStat;
  final String listPrice;
  final String listQuan;

  final String consname;
  final String consid;
  final String conslname;
  final String consuname;
  final String consbarangay;
  final String consmunicipal;

  @override
  State<FarmerListOfBidsDetils> createState() => _FarmerListOfBidsDetilsState();
}

class _FarmerListOfBidsDetilsState extends State<FarmerListOfBidsDetils> {
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
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Bid Details",
              style: TextStyle(fontSize: 25.sp),
            ),
            SizedBox(
              width: 50.w,
            ),
            /*Shoppping cart button */
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.cartShopping),
              iconSize: 30.sp,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
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
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Center(
                    /*Container that holds the image */
                    child: Container(
                      width: 250.w,
                      height: 250.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            offset: const Offset(1, 5),
                          ),
                        ],
                        color: Colors.blue,
                        /*The display of the iamge */
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.imgurl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: const FarmSwapGreenBtn(text: "Accept Bid"),
            ),
            SizedBox(
              height: 15.h,
            ),
            /*This container is for the item name */
            Container(
              color: const Color(0xFF86A789),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      widget.itemname,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for the item bid */
            Container(
              color: const Color(0xFFB2C8BA),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      widget.itemDisc,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for the itembidtime*/
            Container(
              color: const Color(0xFF86A789),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "Date of bid is ${widget.bidTime}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for the item quantity */
            Container(
              color: const Color(0xFFB2C8BA),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "${widget.itemquan} pieces",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for the item value */
            Container(
              color: const Color(0xFF86A789),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "Estimated value is ${widget.itemVal}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for the item condition */
            Container(
              color: const Color(0xFFB2C8BA),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "Item condition ${widget.itemCond}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*Container for the consumer name */
            Container(
              color: const Color(0xFF86A789),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "Your customer is ${widget.consname} "
                      " ${widget.conslname} "
                      " (${widget.consuname})",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /*This container is for da customer address*/
            Container(
              color: const Color(0xFFB2C8BA),
              width: MediaQuery.of(context).size.width,
              height: 50.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Text(
                      "Address at ${widget.consbarangay} " " ${widget.consmunicipal} ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
