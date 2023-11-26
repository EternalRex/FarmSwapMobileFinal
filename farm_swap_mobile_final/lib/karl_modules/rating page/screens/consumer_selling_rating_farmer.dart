import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/getting_final_rating.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/rating_review_save.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/database/updating_farmer_rating.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/widgets/rating_txt_field.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/consumer_confirmed_orders.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/widgets/consumer_buying_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SellConsumerRatingFarmer extends StatefulWidget {
  const SellConsumerRatingFarmer({
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
  State<SellConsumerRatingFarmer> createState() => _SellConsumerRatingFarmerState();
}

class _SellConsumerRatingFarmerState extends State<SellConsumerRatingFarmer> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  TextEditingController reviewController = TextEditingController();
  GettingFinalRating calculateRating = GettingFinalRating();
  UpdateFarmerRating farmerRatingFinal = UpdateFarmerRating();
  RatingAndReview review = RatingAndReview();
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  int average = 0;

/*The rating that will be given to the farmer based on the column of stars being selected */
  int rating = 1;
  String ratingString = "1";
  Color star1 = Colors.black;
  Color star2 = Colors.black;
  Color star3 = Colors.black;
  Color star4 = Colors.black;
  Color star5 = Colors.black;

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
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Farmer Rating"),
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
      /*Start of the body */
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
                      label: const Text("Write a comment for the farmer"),
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
                            average = await calculateRating.calculateAverageRating(widget.farmerId);
                            print("AHAHAHAHAHAH $average");
                            showRatingSuccessMessage(average);
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
        child: const ConsumerBuyingNavBar(),
      ),
    );
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

  void showRatingSuccessMessage(finalAverage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 20.sp, FontWeight.normal),
          content: Text(
            "Thank you for your honset feedback",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.sp,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  farmerRatingFinal.updateFarmerRating(widget.farmerId, finalAverage);
                  /*Saving the rating and review*/
                  review.updateRatingValue(
                    widget.farmerUname,
                    widget.farmerId,
                    widget.farmerLname,
                    widget.farmerName,
                    widget.farmerBarangay,
                    widget.farmerMunicipal,
                    consid,
                    consName,
                    consLname,
                    consUname,
                    consBarangay,
                    constMunispyo,
                    reviewController.text,
                    rating,
                    DateTime.now(),
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const ConsumerConfirmedOrder();
                    },
                  ));
                },
                child: poppinsText("Continue", farmSwapTitlegreen, 20.sp, FontWeight.normal),
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
