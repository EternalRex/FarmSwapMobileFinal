import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/consumer_notif_bid/provider/consumer_notif_provider.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/database/consumer_notif_query.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/save_tobarter_database.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/update_barter_selectedproperty.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/update_swap_coins.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/functions/compute_deductible_swapcoins.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/message_consumer/farmer_consumer_actualchat.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/archive_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/display_consumer_reviews/display_consumer_review.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/farmer_consumer_barter_rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../profile views/database/save_consumer_profile_views.dart';

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
    required this.selected,
    required this.bartered,
    required this.completed,
    required this.listUrl,
  });

  final String imgurl;
  final String itemname;
  final String itemquan;
  final String itemVal;
  final String itemCond;
  final String itemDisc;
  final String bidTime;
  final bool selected;
  final bool bartered;
  final bool completed;

  final String listUrl;
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

  final String farmerUname = '';
  final String farmerId = '';
  final String listingId = '';

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

  CountConsumerProfileVisitsQuerry consProfileVisits =
      CountConsumerProfileVisitsQuerry();
  BarterTransactionDatabase transaction = BarterTransactionDatabase();
  ComputeDeductibleSwapCoins compute = ComputeDeductibleSwapCoins();
  UpdateSelectedBarterBid updateSelected = UpdateSelectedBarterBid();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  ArchiveUpdateListing archive = ArchiveUpdateListing();
  UpdateConsumerFarmerSwapCoins consumerFarmerSwapCoins =
      UpdateConsumerFarmerSwapCoins();

  bool accepted = false;
  String farmerFname = "";
  String farmerLname = "";
  String farmerUname = "";
  String farmerId = "";
  String farmerBaranggay = "";
  String farmerMunicipality = "";
  double averageValue = 0;
  double deductSwapCoins = 0;
  double farmerSwapCoins = 0;
  String percentValue = "";
  double consSwapCoins = 0;
  String farmerPhoto = "";
  int finalRating = 0;
  String farmerPhoto2 = "";
  String farmerUname2 = "";

  //for notif
  String consumerId = "";
  @override
  void initState() {
    super.initState();
    farmerProfileUname();
    getFarmerDetails();
    farmersSwapCoins();
    getConsumersSwapCoins();
    getConsumersRating();
    getConsumerId();
  }

  String senderId = FirebaseAuth.instance.currentUser!.uid;
  ConsumerNotificationQuerry consumerQuery = ConsumerNotificationQuerry();

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
              width: 60.w,
            ),
            /*Back cart button */
            IconButton(
              onPressed: () {
                getFarmerDetails();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FarmerListOfBids(
                      farmerUname: farmerUname,
                      farmerId: farmerId,
                      listingId: widget.listId,
                      listingUrl: widget.listUrl,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_ios),
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
            /*I need to put a condition here nga kung completed na ang transaction dili na accessible
                ang chat og ang message na option naa nalay label na mag ingon na completed*/
            (widget.completed == true)
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
/*Mao ni mo display na mga buttons kung ang mga transaction dili pa completed */
                      Container(
                        height: 50.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          /*The color of the container will change to green when it is the bid that is selected by farmer */
                          color: (widget.selected == true)
                              ? Colors.green
                              : Colors.red,
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
                          /*Text button para sa pag accept sa bid */
                          child: TextButton(
                            onPressed: () {
                              computeAverageValueRange();
                              computeDeductibleSwapCoins();
                              computePercentage();
                              /*Check if the farmer has enough swap coins to do the trade*/
                              if (farmerSwapCoins > deductSwapCoins) {
                                /*Atong gi total kung pila nalay mahabilin sa swap coins ni farmer og consumer
                                tapos atong gi pasa ang value ngadto sa function na maoy mo update sa swapcoins value didto sa database */
                                double newFCoins =
                                    farmerSwapCoins - deductSwapCoins;
                                double newCCoins =
                                    consSwapCoins - deductSwapCoins;
                                showConfirmationMessage(newFCoins, newCCoins);
                              } else {
                                showNoSwapCoinsMessage();
                              }
                            },
                            child: poppinsText(
                              (widget.selected == true)
                                  ? "ACCEPTED"
                                  : "ACCEPT BID",
                              Colors.white,
                              15.sp,
                              FontWeight.w500,
                            ),
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
                        /*Text button para sa pag message sa consumer*/
                        child: TextButton(
                          onPressed: () async {
                            (widget.selected == true)
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FarmerConsumerActualChat(
                                          farmerId: farmerId,
                                          farmerName: farmerFname,
                                          farmerLName: farmerLname,
                                          farmerUname: farmerUname,
                                          farmerBarangay: farmerBaranggay,
                                          farmerMunicipality:
                                              farmerMunicipality,
                                          consumerId: widget.consid,
                                          consumerFname: widget.consname,
                                          consumerLname: widget.conslname,
                                          consumerUname: widget.consuname,
                                          consumerBarangay: widget.consbarangay,
                                          consumerMunicipality:
                                              widget.consmunicipal,
                                          listingId: widget.listId,
                                          listingName: widget.listName,
                                        );
                                      },
                                    ),
                                  )
                                : showInvalidMessage();
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
              child: TextButton(
                onPressed: () async {
                  /*Profile visits count */
                  consProfileVisits.counstFarmerProfileVisit(
                    widget.consid,
                    FirebaseAuth.instance.currentUser!.uid,
                    DateTime.now(),
                    farmerUname2,
                    farmerPhoto2,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return DisplayConsumerReview(
                          consumerId: widget.consid,
                        );
                      },
                    ),
                  );
                },
                child:
                    poppinsText("Reviews", orangeDark, 15.sp, FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            poppinsText2(
                widget.itemname, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2("Item Name", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
                widget.itemDisc, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2(
                "Item Discription", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
                widget.itemVal, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2("Estimated Item Value", Colors.black54, 15.sp,
                FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
                widget.itemquan, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2(
                "Number of Items", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
                widget.itemCond, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2(
                "Condition of Item", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
                widget.consuname, Colors.black, 20.sp, FontWeight.normal),
            const Divider(),
            poppinsText2(
                "Bidder User Name", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            poppinsText2(
              " Barnagay ${widget.consbarangay} , Municipality of ${widget.consmunicipal}",
              Colors.black,
              20.sp,
              FontWeight.normal,
            ),
            const Divider(),
            poppinsText2(
                "Bidder Location", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            /*IF rating is 5 display 5 stars */
            (finalRating == 5)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: darkGreen,
                        size: 40.sp,
                      ),
                      Icon(
                        Icons.star,
                        color: darkGreen,
                        size: 40.sp,
                      ),
                      Icon(
                        Icons.star,
                        color: darkGreen,
                        size: 40.sp,
                      ),
                      Icon(
                        Icons.star,
                        color: darkGreen,
                        size: 40.sp,
                      ),
                      Icon(
                        Icons.star,
                        color: darkGreen,
                        size: 40.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      poppinsText2(
                        "(5/5)",
                        Colors.black,
                        20.sp,
                        FontWeight.normal,
                      ),
                    ],
                  )
                /*if rating is 4 display 4 stars */
                : (finalRating < 5 && finalRating >= 4)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: darkGreen,
                            size: 40.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: darkGreen,
                            size: 40.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: darkGreen,
                            size: 40.sp,
                          ),
                          Icon(
                            Icons.star,
                            color: darkGreen,
                            size: 40.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          poppinsText2(
                            "(4/5)",
                            Colors.black,
                            20.sp,
                            FontWeight.normal,
                          ),
                        ],
                      )
                    : (finalRating < 4 && finalRating >= 3)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: darkGreen,
                                size: 40.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: darkGreen,
                                size: 40.sp,
                              ),
                              Icon(
                                Icons.star,
                                color: darkGreen,
                                size: 40.sp,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              poppinsText2(
                                "(3/5)",
                                Colors.black,
                                20.sp,
                                FontWeight.normal,
                              ),
                            ],
                          )
                        : (finalRating < 3 && finalRating >= 2)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: darkGreen,
                                    size: 40.sp,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: darkGreen,
                                    size: 40.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  poppinsText2(
                                    "(2/5)",
                                    Colors.black,
                                    20.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: darkGreen,
                                    size: 40.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  poppinsText2(
                                    "(1/5)",
                                    Colors.black,
                                    20.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
            const Divider(),
            poppinsText2(
                "Bidder Rating", Colors.black54, 15.sp, FontWeight.normal),
            SizedBox(
              height: 10.h,
            ),
            /*Diri sugod ang mga details sa listing sa og sa item og sa consumer*/
            /*This container is for the item name */
            /*
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
                      "Address at ${widget.consbarangay} "
                      " ${widget.consmunicipal} ",
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
            ),*/
            SizedBox(
              height: 10.h,
            ),
            (widget.completed == true)
                /*If completed the ang transaction so wala nay completed og disupute na button meaning
            dli na maka dispute si farmer kung iya na e mark as complete ang transaction */
                ? Container()
                /*Kung dli pa marked as completed ang transaction so naay button na choices na pwde e label as completed or e dispute lang ang transaction */
                : Padding(
                    padding: EdgeInsets.only(
                        right: 10.sp, left: 10.sp, bottom: 10.sp),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            if (widget.selected == false) {
                              showInvalidMessage();
                            } else {
                              /*Ato e update ang completed field to true tapos ato e reload ang page*/
                              updateSelected.updateIsBarteredCompletedProperty(
                                  widget.listId, widget.consid);

                              /*If the tranaction is completed then the barter listing will be archived*/
                              archive.archiveBarterListing(
                                  farmerUname, widget.listUrl);

                              showArchiveMessage();

                              /*Reloading sa page */
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FarmerListOfBidsDetils(
                                      imgurl: widget.imgurl,
                                      itemname: widget.itemname,
                                      itemquan: widget.itemquan,
                                      itemVal: widget.itemVal,
                                      itemCond: widget.itemCond,
                                      itemDisc: widget.itemDisc,
                                      bidTime: widget.bidTime,
                                      listId: widget.listId,
                                      listName: widget.listName,
                                      listStat: widget.listStat,
                                      listPrice: widget.listPrice,
                                      listQuan: widget.listQuan,
                                      consname: widget.consname,
                                      consid: widget.consid,
                                      conslname: widget.conslname,
                                      consuname: widget.consuname,
                                      consbarangay: widget.consbarangay,
                                      consmunicipal: widget.consmunicipal,
                                      selected: widget.selected,
                                      bartered: widget.bartered,
                                      completed: widget.completed,
                                      listUrl: widget.listUrl,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 135,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF53E78B), Color(0xFF14BE77)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: shadow,
                                  blurRadius: 5,
                                  offset: const Offset(1, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_box,
                                      color: Colors.white,
                                    ),
                                    poppinsText(
                                      "Mark as Done",
                                      Colors.white,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /*poppinsText(
                              "Completed", farmSwapTitlegreen, 20.sp, FontWeight.normal)*/
                        ),
                        SizedBox(
                          width: 0.w,
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.selected == false) {
                              showInvalidMessage();
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FarmerRatesConsumerBarter(
                                      farmerId: farmerId,
                                      farmerName: farmerFname,
                                      farmerLname: farmerLname,
                                      farmerUname: farmerUname,
                                      farmerBarangay: farmerBaranggay,
                                      farmerMunicipal: farmerMunicipality,
                                      consId: widget.consid,
                                      consName: widget.consname,
                                      consUname: widget.consuname,
                                      consLname: widget.conslname,
                                      consBarangay: widget.consbarangay,
                                      consMunicipal: widget.consmunicipal,
                                      listingUrl: widget.imgurl,
                                      listingid: widget.listId,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 135,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFE0000), Color(0xFFD83F31)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: shadow,
                                  blurRadius: 5,
                                  offset: const Offset(1, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_border,
                                      color: Colors.white,
                                    ),
                                    poppinsText(
                                      "Review & Rate ",
                                      Colors.white,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void showInvalidMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
              "Invalid Operation", Colors.red, 20.sp, FontWeight.normal),
          content: poppinsText(
            "You can only perform this opeartion once you accept this bid",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FarmerListOfBidsDetils(
                        imgurl: widget.imgurl,
                        itemname: widget.itemname,
                        itemquan: widget.itemquan,
                        itemVal: widget.itemVal,
                        itemCond: widget.itemCond,
                        itemDisc: widget.itemDisc,
                        bidTime: widget.bidTime,
                        listId: widget.listId,
                        listName: widget.listName,
                        listStat: widget.listStat,
                        listPrice: widget.listPrice,
                        listQuan: widget.listQuan,
                        consname: widget.consname,
                        consid: widget.consid,
                        conslname: widget.conslname,
                        consuname: widget.consuname,
                        consbarangay: widget.consbarangay,
                        consmunicipal: widget.consmunicipal,
                        selected: widget.selected,
                        bartered: widget.bartered,
                        completed: widget.completed,
                        listUrl: widget.listUrl,
                      );
                    },
                  ),
                );
              },
              child: poppinsText(
                  "Back", farmSwapTitlegreen, 17.sp, FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

/*Function that get all farmer details */
  Future<void> getFarmerDetails() async {
    String fname = await farmerDetails.getFarmerFirstname();
    String lname = await farmerDetails.getLastName();
    String uname = await farmerDetails.getUname();
    String fid = await farmerDetails.getFarmerUserId();
    String fbarangay = await farmerDetails.getBaranggay();
    String fmunicipality = await farmerDetails.getMunicipalityFirstname();
    String photo = await farmerDetails.getFarmerUserProfilePhoto();
    setState(() {
      farmerFname = fname;
      farmerLname = lname;
      farmerUname = uname;
      farmerId = fid;
      farmerBaranggay = fbarangay;
      farmerMunicipality = fmunicipality;
      farmerPhoto = photo;
    });
/*
    if (_isMounted) {
      setState(() {
        farmerFname = fname;
        farmerLname = lname;
        farmerUname = uname;
        farmerId = fid;
        farmerBaranggay = fbarangay;
        farmerMunicipality = fmunicipality;
      });
    }*/
  }

/*Function that will compute the average value range */
  void computeAverageValueRange() {
    double average = compute.averageValue(
        double.tryParse(widget.listPrice), double.tryParse(widget.itemVal));
    setState(() {
      averageValue = average;
    });
  }

/*Compute the deductible swap coins */
  void computeDeductibleSwapCoins() {
    double swapcoins = compute.computeDeductibleSwapCoins(
        double.tryParse(widget.listPrice), double.tryParse(widget.itemVal));
    setState(() {
      deductSwapCoins = swapcoins;
    });
  }

/*Compute the percentage of transaction feee */
  void computePercentage() {
    String percent = compute.percentDeduction(averageValue);
    setState(() {
      percentValue = percent;
    });
  }

  /*Function that will get the consumer swap coins */
  Future<void> farmersSwapCoins() async {
    double farmSwapCoins = await farmerDetails.getSwapCoins();
    /* if (_isMounted) {
      setState(() {
        farmerSwapCoins = farmSwapCoins.toDouble();
      });
    }*/
    setState(() {
      farmerSwapCoins = farmSwapCoins;
    });
  }

  /*Funcntion that will counpute the swap coins of consumer*/
  Future<void> getConsumersSwapCoins() async {
    double consumerSwapCoins =
        await consumerDetails.getSwapCoinsWithProvidedId(widget.consid);
    setState(() {
      consSwapCoins = consumerSwapCoins;
    });
  }

  /*Funcntion that will get the rating of consumer*/
  Future<void> getConsumersRating() async {
    double rating = await consumerDetails.getConsumerRating(widget.consid);
    setState(() {
      finalRating = rating.toInt();
    });
  }

  /*Funcntion that will counpute the swap coins of consumer*/
  Future<void> getConsumerId() async {
    String userId = await consumerDetails.getConsumerUserId();
    setState(() {
      consumerId = userId;
    });
  }

  /*Function that will show the confirmation message */
  void showConfirmationMessage(double newFarmerCoins, double newConsumerCoins) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              poppinsText("Information", Colors.blue, 20.sp, FontWeight.bold),
          content: poppinsText(
            "This transaction has an average value of ${averageValue.toString()}. The system will deduct $percentValue that is equal to ${deductSwapCoins.toString()} swapCoins",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            Row(
              children: [
                /*Will update the fields that indicate that the listing has been selected */
                TextButton(
                  onPressed: () async {
                    setState(() {
                      accepted = true;
                    });

                    /*Function na mo hansak og swap coins lag ngadto sa farmer og consumer */

                    /*Updates the consumer and farmer swap coins/ deducting the consumer and farmer swapcoins */
                    updateSwapCoins(FirebaseAuth.instance.currentUser!.uid,
                        newFarmerCoins, widget.consid, newConsumerCoins);

                    /*Ato e update ang selected na property to true sa bid na napilian */
                    updateSelected.updateBidSelectedStatus(
                      true,
                      widget.listId,
                      widget.consid,
                    );
                    /*Ato e update ang tanang IsBarteredOut property sa tanang bids to true
                          kay nana may napili an si farmer */
                    updateSelected.updateIsBarteredOutProperty();

                    transaction.addBarterTransaction(
                      farmerFname,
                      farmerId,
                      farmerUname,
                      farmerLname,
                      farmerBaranggay,
                      farmerMunicipality,
                      widget.consname,
                      widget.consid,
                      widget.consname,
                      widget.conslname,
                      widget.consbarangay,
                      widget.consmunicipal,
                      widget.listUrl,
                      widget.listId,
                      widget.listName,
                      double.tryParse(widget.listPrice),
                      widget.itemname,
                      double.tryParse(widget.itemVal),
                      widget.imgurl,
                      averageValue,
                      deductSwapCoins,
                      deductSwapCoins,
                      percentValue,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FarmerListOfBidsDetils(
                            imgurl: widget.imgurl,
                            itemname: widget.itemname,
                            itemquan: widget.itemquan,
                            itemVal: widget.itemVal,
                            itemCond: widget.itemCond,
                            itemDisc: widget.itemDisc,
                            bidTime: widget.bidTime,
                            listId: widget.listId,
                            listName: widget.listName,
                            listStat: widget.listStat,
                            listPrice: widget.listPrice,
                            listQuan: widget.listQuan,
                            consname: widget.consname,
                            consid: widget.consid,
                            conslname: widget.conslname,
                            consuname: widget.consuname,
                            consbarangay: widget.consbarangay,
                            consmunicipal: widget.consmunicipal,
                            selected: true,
                            bartered: true,
                            completed: widget.completed,
                            listUrl: widget.listUrl,
                          );
                        },
                      ),
                    );
                    //NOTIFICATION FOR ACCEPT BID
                    consumerQuery.sendNotification(
                      senderId,
                      consumerId,
                      "Your barter bid is accepted.",
                      farmerFname,
                      farmerLname,
                      DateTime.now(),
                      "BID_ACCEPTED",
                    );

                    Provider.of<ConsumerNotificationProvider>(context,
                            listen: false)
                        .setIncrement(consumerId);
                    print(farmerId);
                    print("$farmerFname, $farmerLname");
                  },
                  child: poppinsText(
                    "Continue",
                    farmSwapTitlegreen,
                    17.sp,
                    FontWeight.w300,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                /*Will cancel the bidding */
                TextButton(
                  onPressed: () {
                    /*If cancel is pressed it will just redirect back to this page */
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return FarmerListOfBidsDetils(
                            imgurl: widget.imgurl,
                            itemname: widget.itemname,
                            itemquan: widget.itemquan,
                            itemVal: widget.itemVal,
                            itemCond: widget.itemCond,
                            itemDisc: widget.itemDisc,
                            bidTime: widget.bidTime,
                            listId: widget.listId,
                            listName: widget.listName,
                            listStat: widget.listStat,
                            listPrice: widget.listPrice,
                            listQuan: widget.listQuan,
                            consname: widget.consname,
                            consid: widget.consid,
                            conslname: widget.conslname,
                            consuname: widget.consuname,
                            consbarangay: widget.consbarangay,
                            consmunicipal: widget.consmunicipal,
                            selected: true,
                            bartered: true,
                            completed: widget.completed,
                            listUrl: widget.listUrl,
                          );
                        },
                      ),
                    );
                  },
                  child: poppinsText(
                    "Cancel",
                    Colors.red,
                    17.sp,
                    FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /*Function that will show a message when consumers has not enough swap coins */
  void showNoSwapCoinsMessage() {
    int neededswapCoins = deductSwapCoins.toInt() - farmerSwapCoins.toInt();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
              "Invalid Operation", Colors.red, 17.sp, FontWeight.bold),
          content: poppinsText(
            "Not enough swapcoins. You need ${neededswapCoins.toString()}",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FarmerListOfBidsDetils(
                        imgurl: widget.imgurl,
                        itemname: widget.itemname,
                        itemquan: widget.itemquan,
                        itemVal: widget.itemVal,
                        itemCond: widget.itemCond,
                        itemDisc: widget.itemDisc,
                        bidTime: widget.bidTime,
                        listId: widget.listId,
                        listName: widget.listName,
                        listStat: widget.listStat,
                        listPrice: widget.listPrice,
                        listQuan: widget.listQuan,
                        consname: widget.consname,
                        consid: widget.consid,
                        conslname: widget.conslname,
                        consuname: widget.consuname,
                        consbarangay: widget.consbarangay,
                        consmunicipal: widget.consmunicipal,
                        selected: true,
                        bartered: true,
                        completed: widget.completed,
                        listUrl: widget.listUrl,
                      );
                    },
                  ),
                );
              },
              child:
                  poppinsText("Ok", farmSwapTitlegreen, 17.sp, FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  /*functions that will output a message that the barter has been accepted*/
  void showDoneMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 17.sp, FontWeight.bold),
          content: poppinsText(
            "Your bid is placed successfull, wait for the farmers respond, you might be the lucky chosen bidder!",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: poppinsText(
                  "Finish", farmSwapTitlegreen, 17.sp, FontWeight.bold),
            ),
          ],
        );
      },
    );
  }

  /*Function na mo deduct sa swap coins sa farmer og consumer*/
  void updateSwapCoins(String farmerId, double newFarmerSwapCoins,
      String consumerId, double newConsumerSwapCoins) {
    consumerFarmerSwapCoins.updateFarmerSwapCoins(farmerId, newFarmerSwapCoins);
    consumerFarmerSwapCoins.updateConsumerSwapCoins(
        consumerId, newConsumerSwapCoins);
  }

  void showArchiveMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20, FontWeight.w500),
          content: Text(
            "Your listing will now be archived, For dispute, go to Dispute Page",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        );
      },
    );
  }

  Future<void> farmerProfileUname() async {
    String uname = await farmerDetails.getUname();
    String url = await farmerDetails.getFarmerUserProfilePhoto();
    setState(() {
      farmerPhoto2 = url;
      farmerUname2 = uname;
    });
  }
}
