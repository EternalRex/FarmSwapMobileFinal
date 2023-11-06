import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/archive_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/promoted_update.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/listing_management_bottomnav.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/update_listing_dropdown/update_sell_barter_dropdown.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/green_btn.dart';

class SellingAllListingDetails extends StatefulWidget {
  const SellingAllListingDetails({
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
  State<SellingAllListingDetails> createState() => _SellingAllListingDetailsState();
}

class _SellingAllListingDetailsState extends State<SellingAllListingDetails> {
/*Instance of the class that gets individual farmer details so ako e pull out diri ang swapcoins
ni farmer, kay para ako e check kung naa bay swap coins si farmer para e bayad sa promotion before the
actual promotion will happen, niya mag deduct napd ko here hehe */
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  double swapCoins = 0;
  double constantDeductibleSwapCoins = 100;

/*Mao ni class na mo update sa promotion field and swap coins field sa database whenever a promotion is made*/
  PromotedListings promotionUpdate = PromotedListings();

  /*Instance of the archiving class*/
  ArchiveUpdateListing archive = ArchiveUpdateListing();

  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    /*Ako gi call diri ang function para ma execute siya ig ari nato na class
    og ma set ang state sa swapCoins na variable */
    getFarmerSwapCoins();
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
        title: const Text("Selling Listing Details"),
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
                          height: 13.h,
                        ),
                        /*For da buttons */
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Row(
                            children: [
                              /*Update Button */
                              TextButton(
                                onPressed: () {
                                  advisory();
                                },
                                child: poppinsText(
                                  "Update",
                                  Colors.blue,
                                  20.sp,
                                  FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              /*Promote Button */
                              TextButton(
                                onPressed: () {
                                  /*A condition that will check if the farmer has
                                  enough swap coins */
                                  if (swapCoins >= 100) {
                                    confirmPromotion();
                                  } else {
                                    notEnoughSwapCoins();
                                  }
                                },
                                child: poppinsText(
                                  "Promote",
                                  farmSwapTitlegreen,
                                  20.sp,
                                  FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              /*Archive Button */
                              TextButton(
                                onPressed: () {
                                  confirmArchive();
                                },
                                child: poppinsText(
                                  "Archive",
                                  Colors.orange,
                                  20.sp,
                                  FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void advisory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Advisory!",
            Colors.red,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "You can't update the start and expiration date of yout listing, as these fields are final, Thank You!",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  selectFieldToUpdate();
                },
                child: poppinsText("Continue", farmSwapTitlegreen, 20.sp, FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  /*Function for the dropdown */
  void selectFieldToUpdate() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "What to Update?",
            Colors.black,
            20.sp,
            FontWeight.w500,
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            /*Akog gi pasa sa atong drop down botton class ang value ni url */
            child: UpdateSellListingDropdownBtn(profileurl: widget.url),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: GestureDetector(
                  child: const FarmSwapGreenBtn(text: "Update"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

/*Function that will give an advisory to the user that he cannot proceed with
  the promotion because he has no enough swap coins */
  void notEnoughSwapCoins() {
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

  /*Function na mo inform ni farmer na mag deduct tag swap coins */
  void confirmPromotion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Confirm Promotion",
            Colors.blue,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "100 swap coins will deducted as promotion payment",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                updatePromotion();
                promotionSuccess();
              },
              child: poppinsText("Continue", farmSwapTitlegreen, 20.sp, FontWeight.w500),
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
    double newSwapCoins = swapCoins - constantDeductibleSwapCoins;

    /*Gi call nato ang function sa class na mag update sa atong database niya giapasa nato
    ang mga needed na values */
    await promotionUpdate.updateSellingListingPromotedField(
      widget.fUname,
      widget.url,
      newSwapCoins,
    );
  }

  /*Function that notifies that user that promotion was sucessfull*/
  void promotionSuccess() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Promotion Notice",
            Colors.blue,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "Listing Promoted Successfull!",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.listingmainpage);
              },
              child: poppinsText(
                "Continue",
                farmSwapTitlegreen,
                20.sp,
                FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }

  /*Function ni siya na mag pull out sa pila ang swap coins ni farmer */
  Future<void> getFarmerSwapCoins() async {
    int coins = await farmerDetails.getSwapCoins();
    setState(() {
      swapCoins = coins.toDouble();
    });
  }

/*Function for archiving warning message*/
  void confirmArchive() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Warning",
            Colors.red,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "Your Listing will be archived and will not be accessible again!",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                archiveListing();
                successArchive();
              },
              child: poppinsText("Continue", farmSwapTitlegreen, 20.sp, FontWeight.w500),
            ),
          ],
        );
      },
    );
  }

  /*Function for achiving success message*/
  void successArchive() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Archive Complete",
            Colors.red,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText(
            "Your Archived your listing successfully",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.listingmainpage);
              },
              child: poppinsText("Finish", farmSwapTitlegreen, 20.sp, FontWeight.w500),
            ),
          ],
        );
      },
    );
  }

  /*Actual function for archiving */
  Future<void> archiveListing() async {
    await archive.archiveSellingListing(widget.fUname, widget.url);
  }
}
