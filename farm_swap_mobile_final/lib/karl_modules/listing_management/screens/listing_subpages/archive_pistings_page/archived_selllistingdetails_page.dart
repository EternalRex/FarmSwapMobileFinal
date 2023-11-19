import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/renew_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/listing_management_bottomnav.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ArchiveSellListingDetails extends StatefulWidget {
  const ArchiveSellListingDetails({
    super.key,
    required this.url,
    required this.name,
    required this.disc,
    required this.price,
    required this.quantity,
    required this.status,
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
  State<ArchiveSellListingDetails> createState() => _ArchiveSellListingDetailsState();
}

class _ArchiveSellListingDetailsState extends State<ArchiveSellListingDetails> {
/*Instance of the other classes used in this class */
  final ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  final RenewUpdateListing renew = RenewUpdateListing();

  /*Variables used in this class */
  double swapCoins = 0;
  DateTime endListingDate = DateTime.now();
  String endListingDateString = "";

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
        title: const Text("Archived Selling Listing"),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: const DashBoardDrawer(),
      /*Body og ang iyang style */
      body: Column(
        children: [
          /*Expanded for the contents */
          Expanded(
            flex: 8,
            /*Mao ni container nga naa sa midle flex*/
            child: SingleChildScrollView(
              child: Container(
                height: 750.h,
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
                    Column(
                      children: [
                        /*Container for name and discription */
                        Container(
                          // height: 200.h,
                          width: 340.w,
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
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 240.w,
                                    child: poppinsText(
                                      widget.name,
                                      Colors.black,
                                      30.sp,
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 240.w,
                                    child: poppinsText(
                                      widget.disc,
                                      Colors.black,
                                      13.sp,
                                      FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        /*Container for product quantity, price, preffered item start and end date */
                        Container(
                          width: 340.w,
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
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.sp),
                            child: Column(
                              children: [
                                /*For Product Quality */
                                SizedBox(
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
                                /*Equivalent Price */
                                SizedBox(
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

                                /*For start date */
                                SizedBox(
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
                                /*For end date */
                                SizedBox(
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.sp,
                        ),
                        /*Container for status, promoted, farmer name and farmer location */
                        Container(
                          width: 340.w,
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
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.sp),
                            child: Column(
                              children: [
                                /**For Status */
                                SizedBox(
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
                                /*For Promoted */
                                SizedBox(
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
                                /**For farmer Name */
                                SizedBox(
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
                                        "${widget.fname} "
                                        " ${widget.fLname} "
                                        " (${widget.fUname})",
                                        Colors.black,
                                        15.sp,
                                        FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ),
                                /*For place */
                                SizedBox(
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        /*Information*/
                        Container(
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
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
                          child: IconButton(
                              onPressed: () {
                                information();
                              },
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.question_mark,
                                    color: Colors.white,
                                  ),
                                  poppinsText(
                                      "Renew Listing", Colors.white, 15.sp, FontWeight.w500),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*Expanded for the bottom navbar */
          /*Expanded(
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
          ),*/
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.sp,
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
        child: const ListingManagementBottomNav(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.listingmainpage);
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

/*Function that will show an information to the user*/
  void information() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Listing Renew",
            Colors.blue,
            20.sp,
            FontWeight.w300,
          ),
          content: poppinsText(
            "10 swap coins will be deducted for each renewal",
            Colors.black,
            15.sp,
            FontWeight.w500,
          ),
          actions: [
            TextButton(
              onPressed: () {
                /*Calling the function that will update our database and actually
                reactivate our listing */
                selectFinalDateBox();
              },
              child: poppinsText(
                "Continue",
                farmSwapTitlegreen,
                20.sp,
                FontWeight.w500,
              ),
            )
          ],
        );
      },
    );
  }

  /*Function ni siya na mag pull out sa pila ang swap coins ni farmer */
  Future<void> getFarmerSwapCoins() async {
    double coins = await farmerDetails.getSwapCoins();
    setState(() {
      swapCoins = coins;
    });
  }

  /*Function that will give an advisory to the user that he cannot proceed with
  the promotion because he has no enough swap coins */
  void notEnoughSwapCoins() {
    double constantDeductibleSwapCoins = 10;
    //determines pila ang kulang na coins ni farmer para maka promote
    double neededCoins = constantDeductibleSwapCoins - swapCoins;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Low SwapCoins",
            Colors.red,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "Sorry, You dont have enough swap coins to promote this product, You only have ${swapCoins.toString()} coins left, you need ${neededCoins.toString()} more",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  //adto nya tani e redirect sa swap coins page
                  Navigator.of(context).pushNamed(RouteManager.listingmainpage);
                },
                child: poppinsText("Ok", farmSwapTitlegreen, 20.sp, FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  /*Function that picks date*/
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endListingDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != endListingDate) {
      setState(() {
        endListingDate = pickedDate;
        endListingDateString = DateFormat('dd-MM-yyyy').format(endListingDate);
      });
    }
  }

/*A show dialog box function for selecting a date */
  void selectFinalDateBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Select Expiration",
            Colors.blue,
            20.sp,
            FontWeight.w500,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _selectDate();
                },
                icon: const Icon(Icons.calendar_month),
                iconSize: 60.sp,
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  selectFinalDateBox2();
                },
                child: poppinsText("See Date", farmSwapTitlegreen, 20.sp, FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  void selectFinalDateBox2() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Expiration Date",
            Colors.blue,
            20.sp,
            FontWeight.w500,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: poppinsText(endListingDateString, Colors.black, 15.sp, FontWeight.w200),
              ),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  updatePromotion();
                  Navigator.of(context).pushNamed(RouteManager.listingmainpage);
                },
                child: poppinsText("Finish", farmSwapTitlegreen, 20.sp, FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  /*A function that will update the promoted field in database to true when promoted 
  button is clicked and will deduct swap coins and update the swap coins field in the database
  to reflect the remaining swap coins*/
  Future<void> updatePromotion() async {
    double constantDeductibleSwapCoins = 10;
    double newSwapCoins = swapCoins - constantDeductibleSwapCoins;

    /*Gi call nato ang function sa class na mag update sa atong database niya giapasa nato
    ang mga needed na values */
    await renew.renewSellingListing(
      widget.fUname,
      widget.url,
      Timestamp.fromDate(endListingDate),
    );

    await renew.updateFarmerSwapCoins(newSwapCoins.toInt());
  }
}
