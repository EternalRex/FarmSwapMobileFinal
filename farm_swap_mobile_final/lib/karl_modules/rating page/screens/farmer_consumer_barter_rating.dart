import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids_details.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/selected_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/barter_bids_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/getting_final_rating.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/rating_review_save.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/updating_consumer_rating.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/updating_farmer_rating.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/widgets/rating_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerRatesConsumerBarter extends StatefulWidget {
  const FarmerRatesConsumerBarter({
    super.key,
    required this.farmerId,
    required this.farmerName,
    required this.farmerLname,
    required this.farmerUname,
    required this.farmerBarangay,
    required this.farmerMunicipal,
    required this.consId,
    required this.consName,
    required this.consUname,
    required this.consLname,
    required this.consBarangay,
    required this.consMunicipal,
    required this.listingUrl,
    required this.listingid,
  });

  final String farmerId;
  final String farmerName;
  final String farmerLname;
  final String farmerUname;
  final String farmerBarangay;
  final String farmerMunicipal;

  final String consId;
  final String consName;
  final String consLname;
  final String consUname;
  final String consBarangay;
  final String consMunicipal;

  final String listingid;
  final String listingUrl;

  @override
  State<FarmerRatesConsumerBarter> createState() => _FarmerRatesConsumerBarterState();
}

class _FarmerRatesConsumerBarterState extends State<FarmerRatesConsumerBarter> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  TextEditingController reviewController = TextEditingController();
  GettingFinalRating calculateRating = GettingFinalRating();
  UpdatingConsumerRating consRating = UpdatingConsumerRating();
  RatingAndReview review = RatingAndReview();
  int average = 0;
  /*I need to reget the farmer details*/
  String fid = "";
  String fName = "";
  String fLname = "";
  String fUname = "";
  String fbaranga = "";
  String fMunicipal = "";
  /*The rating that will be given to the farmer based on the column of stars being selected */
  int rating = 1;
  String ratingString = "1";
  Color star1 = Colors.black;
  Color star2 = Colors.black;
  Color star3 = Colors.black;
  Color star4 = Colors.black;
  Color star5 = Colors.black;

  @override
  void initState() {
    super.initState();
    getFarmerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Consumer Rating"),
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
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return SelectedBids(
                        farmerId: fid,
                        listingId: widget.listingid,
                        farmerUname: fUname,
                        listingUrl: widget.listingUrl,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 30.sp,
            ),
          ),
        ],
      ),
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 750.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Column(
                  children: [
                    poppinsText("$ratingString stars", Colors.black, 20.sp, FontWeight.w500),
                    Divider(
                      thickness: 10.h,
                      color: orangeDark,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    /*So mao ni end row sa plus icon and minus icon */
                    /*ato e check kung pilay value sa rating, then based on that value ma display ang pila kabook star */
                    (rating == 5)
                        ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: greenDark,
                                  size: 40.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: greenDark,
                                  size: 40.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: greenDark,
                                  size: 40.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: greenDark,
                                  size: 40.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: greenDark,
                                  size: 40.sp,
                                ),
                              ],
                            ),
                          )
                        : (rating == 4)
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: greenDark,
                                      size: 40.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: greenDark,
                                      size: 40.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: greenDark,
                                      size: 40.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: greenDark,
                                      size: 40.sp,
                                    ),
                                  ],
                                ),
                              )
                            : (rating == 3)
                                ? Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: greenDark,
                                          size: 40.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: greenDark,
                                          size: 40.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: greenDark,
                                          size: 40.sp,
                                        ),
                                      ],
                                    ),
                                  )
                                : (rating == 2)
                                    ? Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: greenDark,
                                              size: 40.sp,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: greenDark,
                                              size: 40.sp,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: greenDark,
                                              size: 40.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                    SizedBox(
                      height: 40.h,
                    ),
                    RatingTxtField(
                      controller: reviewController,
                      label: const Text("Write a comment for the consumer"),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    /*So mao ni row na nag contain sa add buton sa rate na word og sa minus na botton */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*For incrementing the number stars*/
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              if (rating == 5) {
                                showExceedMessage();
                              } else {
                                setState(() {
                                  rating = rating + 1;
                                  ratingString = rating.toString();
                                });
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.plus),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        TextButton(
                          onPressed: () async {
                            average =
                                await calculateRating.calculateConsumerAverageRating(widget.consId);
                            print("AHAHAHAHAHAH $average");
                            consRating.updateConsumerRating(widget.consId, average);
                            review.updateRatingValueConsumer(
                              fUname,
                              fid,
                              fLname,
                              fName,
                              fbaranga,
                              fMunicipal,
                              widget.consId,
                              widget.consName,
                              widget.consLname,
                              widget.consUname,
                              widget.consBarangay,
                              widget.consMunicipal,
                              reviewController.text,
                              rating,
                              DateTime.now(),
                            );

                            showRatingSuccessMessage();
                          },
                          child: poppinsText("Submit", farmSwapTitlegreen, 26.sp, FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        /*For decrementing the number stars*/
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            onPressed: () {
                              if (rating == 1) {
                                showDeceedMessage();
                              } else {
                                setState(() {
                                  rating = rating - 1;
                                  ratingString = rating.toString();
                                });
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.minus),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        child: BarterBidsNavBar(
          farmerUname: fUname,
          farmerId: fid,
          listingId: widget.listingid,
          listUrl: widget.listingUrl,
        ),
      ),
    );
  }

  Future<void> getFarmerDetails() async {
    String farmerId = await farmerDetails.getFarmerUserId();
    String farmerFName = await farmerDetails.getFarmerFirstname();
    String farmerLname = await farmerDetails.getLastName();
    String farmerUname = await farmerDetails.getUname();
    String farmerBarangay = await farmerDetails.getBaranggay();
    String farmerMunicipal = await farmerDetails.getMunicipalityFirstname();

    setState(() {
      fid = farmerId;
      fName = farmerFName;
      fLname = farmerLname;
      fUname = farmerUname;
      fbaranga = farmerBarangay;
      fMunicipal = farmerMunicipal;
    });
  }

  void showExceedMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You have reached the maximum star", Colors.black, 15.sp, FontWeight.normal),
        );
      },
    );
  }

  /*A function that will show a message if the amount of kilograms being purchased is less than 1 kilogram*/
  void showDeceedMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You have reached the minimum kilogram", Colors.black, 15.sp, FontWeight.normal),
        );
      },
    );
  }

  void showRatingSuccessMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 20.sp, FontWeight.normal),
          content: Text(
            "Thank you for your honest feedback",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
