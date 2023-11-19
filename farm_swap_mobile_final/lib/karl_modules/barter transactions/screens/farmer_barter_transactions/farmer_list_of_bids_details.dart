import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/save_tobarter_database.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/update_barter_selectedproperty.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/functions/compute_deductible_swapcoins.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/selected_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/message_consumer/farmer_consumer_actualchat.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/archive_update.dart';
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

  BarterTransactionDatabase transaction = BarterTransactionDatabase();
  ComputeDeductibleSwapCoins compute = ComputeDeductibleSwapCoins();
  UpdateSelectedBarterBid updateSelected = UpdateSelectedBarterBid();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  ArchiveUpdateListing archive = ArchiveUpdateListing();
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

  @override
  void initState() {
    super.initState();
    getFarmerDetails();
    farmersSwapCoins();
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
                          /*Text button para sa pag accept sa bid */
                          child: TextButton(
                            onPressed: () {
                              computeAverageValueRange();
                              computeDeductibleSwapCoins();
                              computePercentage();
                              /*Check if the farmer has enough swap coins to do the trade*/
                              if (farmerSwapCoins > deductSwapCoins) {
                                showConfirmationMessage();
                              } else {
                                showNoSwapCoinsMessage();
                              }
                            },
                            child: poppinsText(
                              (widget.selected == true) ? "ACCEPTED" : "ACCEPT BID",
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
                          onPressed: () {
                            (widget.selected == true)
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FarmerConsumerActualChat(
                                          farmerId: farmerId,
                                          farmerName: farmerFname,
                                          farmerUname: farmerUname,
                                          farmerBarangay: farmerBaranggay,
                                          farmerMunicipality: farmerMunicipality,
                                          consumerId: widget.consid,
                                          consumerFname: widget.consname,
                                          consumerLname: widget.conslname,
                                          consumerUname: widget.consuname,
                                          consumerBarangay: widget.consbarangay,
                                          consumerMunicipality: widget.consmunicipal,
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
              height: 15.h,
            ),
            /*Diri sugod ang mga details sa listing sa og sa item og sa consumer*/
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
            ),
            SizedBox(
              height: 10.h,
            ),
            (widget.completed == true)
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
                            if (widget.selected == false) {
                              showInvalidMessage();
                            } else {
/*Ato e update ang completed field to true tapos ato e reload ang page*/
                              updateSelected.updateIsBarteredCompletedProperty(
                                  widget.listId, widget.consid);

                              /*If the tranaction is completed then the barter listing will be archived*/
                              archive.archiveBarterListing(farmerUname, widget.listUrl);

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
                          child: poppinsText(
                              "Completed", farmSwapTitlegreen, 20.sp, FontWeight.normal),
                        ),
                        SizedBox(
                          width: 70.w,
                        ),
                        TextButton(
                          onPressed: () {
                            if (widget.selected == false) {
                              showInvalidMessage();
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
      /*This is the button that will go back to the bids to be selected */
      floatingActionButton: FloatingActionButton(
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
          title: poppinsText("Invalid Operation", Colors.red, 20.sp, FontWeight.normal),
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
              child: poppinsText("Back", farmSwapTitlegreen, 17.sp, FontWeight.bold),
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
    setState(() {
      farmerFname = fname;
      farmerLname = lname;
      farmerUname = uname;
      farmerId = fid;
      farmerBaranggay = fbarangay;
      farmerMunicipality = fmunicipality;
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
    double average =
        compute.averageValue(double.tryParse(widget.listPrice), double.tryParse(widget.itemVal));
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
    int farmSwapCoins = await farmerDetails.getSwapCoins();
    /* if (_isMounted) {
      setState(() {
        farmerSwapCoins = farmSwapCoins.toDouble();
      });
    }*/
    setState(() {
      farmerSwapCoins = farmSwapCoins.toDouble();
    });
  }

  /*Function that will show the confirmation message */
  void showConfirmationMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Information", Colors.blue, 20.sp, FontWeight.bold),
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
                  onPressed: () {
                    setState(() {
                      accepted = true;
                    });
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
          title: poppinsText("Invalid Operation", Colors.red, 17.sp, FontWeight.bold),
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
              child: poppinsText("Ok", farmSwapTitlegreen, 17.sp, FontWeight.bold),
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
              child: poppinsText("Finish", farmSwapTitlegreen, 17.sp, FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
