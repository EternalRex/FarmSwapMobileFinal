import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/update_barter_selectedproperty.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/consumer_barter_tranasctions/consumer_accepted_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/message_consumer/consumer_farmer_actualchat.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GetConsumerBidDetails extends StatefulWidget {
  const GetConsumerBidDetails({
    super.key,
    required this.imgurl,
    required this.itemname,
    required this.itemquan,
    required this.itemVal,
    required this.itemCond,
    required this.itemDisc,
    required this.bartered,
    required this.bidTime,
    required this.listId,
    required this.listName,
    required this.listStat,
    required this.listPrice,
    required this.listQuan,
    required this.farmerid,
    required this.farmername,
    required this.farmerlname,
    required this.farmeruname,
    required this.farmerbarangay,
    required this.farmermunicipal,
    required this.selected,
    required this.completed,
    required this.isConsCompleted,
  });

  final String imgurl;
  final String itemname;
  final String itemquan;
  final String itemVal;
  final String itemCond;
  final String itemDisc;
  final String bidTime;
  final bool bartered;
  final bool selected;
  final bool completed;
  final bool isConsCompleted;

  final String listId;
  final String listName;
  final String listStat;
  final String listPrice;
  final String listQuan;

  final String farmername;
  final String farmerid;
  final String farmerlname;
  final String farmeruname;
  final String farmerbarangay;
  final String farmermunicipal;

  @override
  State<GetConsumerBidDetails> createState() => _GetConsumerBidDetailsState();
}

class _GetConsumerBidDetailsState extends State<GetConsumerBidDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  UpdateSelectedBarterBid update = UpdateSelectedBarterBid();
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  String consid = "";
  String consName = "";
  String consLname = "";
  String consUname = "";
  String consBarangay = "";
  String constMunispyo = "";

  @override
  void initState() {
    super.initState();
    getConsumerDetails();
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
            (widget.isConsCompleted == true)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.h,
                        width: 250.w,
                        decoration: BoxDecoration(
                          /*The color of the container will change to green when it is the bid that is selected by farmer */
                          color: Colors.red,
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: poppinsText(
                              "COMPLETED TRANSACTION",
                              Colors.white,
                              15.sp,
                              FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          /*The color of the container will change to green when it is the bid that is selected by farmer */
                          color: (widget.selected == true) ? Colors.green : Colors.red,
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
                        ),
                        child: Center(
                          child: poppinsText(
                            (widget.selected == true) ? "SELECTED" : "WAITING...",
                            Colors.white,
                            15.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          color: Colors.green,
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
                        ),
                        child: TextButton(
                          onPressed: () {
                            /*The text high will be change to navigator when the message functionality is functional */
                            (widget.selected == true)
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return ConsumerFarmerActualChat(
                                        farmerId: widget.farmerid,
                                        farmerName: widget.farmername,
                                        farmerUname: widget.farmeruname,
                                        farmerBarangay: widget.farmerbarangay,
                                        farmerMunicipality: widget.farmermunicipal,
                                        consumerId: consid,
                                        consumerFname: consName,
                                        consumerLname: consLname,
                                        consumerUname: consUname,
                                        consumerBarangay: consBarangay,
                                        consumerMunicipality: constMunispyo,
                                        listingId: widget.listId,
                                        listingName: widget.listName,
                                      );
                                    }),
                                  )
                                : showInvaidMessage();
                          },
                          child: poppinsText(
                            "MESSAGE",
                            Colors.white,
                            15.sp,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
            /*This container is for the listing name */
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
                      "Bartered to ${widget.listName}",
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
            /*This container is for the listing active */
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
                      "listing is ${widget.listStat}",
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
            /*Listing estimated value */
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
                      "Listing worth ${widget.listPrice}",
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
            /*This container is for the listing quantity */
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
                      "${widget.listQuan} kg available",
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
            (widget.isConsCompleted == true)
                /*If completed the ang transaction so wala nay completed og disupute na button meaning
            dli na maka dispute si farmer kung iya na e mark as complete ang transaction */
                ? Container()
                /*Kung dli pa marked as completed ang transaction so naay button na choices na pwde e label as completed or e dispute lang ang transaction */
                : Padding(
                    padding: EdgeInsets.only(right: 10.sp, left: 10.sp, bottom: 10.sp),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            /*Condition ni na if dli pa gani selected ang status sa listing, dli maka gamit sa completed og dispute
                            functionality si consumer */
                            if (widget.selected == false) {
                              showInvaidMessage();
                            } else {
                              /*E update nato ang field na consuemerCompleted to true */
                              update.updateConsumerIsCompeleted(
                                  widget.listId, FirebaseAuth.instance.currentUser!.uid);
                              /*Re routign to this page to show the updated value effect*/
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ConsumerSelectedBid();
                                },
                              );
                            }
                          },
                          child: poppinsText(
                              "Completed", farmSwapTitlegreen, 20.sp, FontWeight.normal),
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        TextButton(
                          onPressed: () {
                            /*Condition ni na if dli pa gani selected ang status sa listing, dli maka gamit sa completed og dispute
                            functionality si consumer */
                            if (widget.selected == false) {
                              showInvaidMessage();
                            } else {
                              /*Re routign to this page to show the updated value effect*/
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ConsumerSelectedBid();
                                },
                              );
                            }
                          },
                          child: poppinsText("Dispute", Colors.red, 20.sp, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.consumerbidListings);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void showInvaidMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Invalid Operation", Colors.red, 20.sp, FontWeight.w500),
          content: poppinsText(
            "You can only perform this operation  when your bid status is SELECTED by the FARMER, as of now it is WAITING...",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.consumerbidListings);
              },
              child: Text(
                "Back",
                style: TextStyle(color: farmSwapTitlegreen),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getConsumerDetails() async {
    String id = await consumerDetails.getConsumerUserId();
    String name = await consumerDetails.getConsumerFirstname();
    String lname = await consumerDetails.getConsumerLastName();
    String uname = await consumerDetails.getUname();
    String barangay = await consumerDetails.getBaranggay();
    String municipal = await consumerDetails.getMunicipalityFirstname();
    setState(() {
      consid = id;
      consName = name;
      consLname = lname;
      consUname = uname;
      consBarangay = barangay;
      constMunispyo = municipal;
    });
  }
}
