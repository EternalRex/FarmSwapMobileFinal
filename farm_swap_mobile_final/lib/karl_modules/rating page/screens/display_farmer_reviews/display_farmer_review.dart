import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/display_farmer_reviews/get_farmer_reviews.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/display_farmer_reviews/get_farmer_reviews2.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DisplayFarmerReviews extends StatefulWidget {
  const DisplayFarmerReviews({
    super.key,
    this.farmerId,
  });
  final String? farmerId;

  @override
  State<DisplayFarmerReviews> createState() => _DisplayFarmerReviewsState();
}

class _DisplayFarmerReviewsState extends State<DisplayFarmerReviews> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  ListinGetFarmerDetails farmerDetails2 = ListinGetFarmerDetails();
  int finalRating = 0;
  int finalRating2 = 0;
  double finalRating3 = 0;

  @override
  void initState() {
    super.initState();
    getFarmerRating();
  }

  @override
  Widget build(BuildContext context) {
    String userType =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("My Reviews"),
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
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: darkGreen),
              child: Column(
                children: [
                  poppinsText2(
                    "$finalRating3",
                    Colors.white,
                    30.sp,
                    FontWeight.w500,
                  ),
/*Using the finalRating, it is where the number of stars are being displayed */
                  (finalRating == 5)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            poppinsText2(
                              "(5/5)",
                              Colors.black,
                              13.sp,
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
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 25.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                poppinsText2(
                                  "(4/5)",
                                  Colors.white,
                                  13.sp,
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
                                      color: Colors.white,
                                      size: 25.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 25.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 25.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    poppinsText2(
                                      "(3/5)",
                                      Colors.white,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                )
                              : (finalRating < 3 && finalRating >= 2)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        poppinsText2(
                                          "(2/5)",
                                          Colors.white,
                                          13.sp,
                                          FontWeight.normal,
                                        ),
                                      ],
                                    )
                                  : (finalRating >= 1 && finalRating < 2)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 25.sp,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            poppinsText2(
                                              "(1/5)",
                                              Colors.white,
                                              13.sp,
                                              FontWeight.normal,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            poppinsText2(
                                              "(0/5)",
                                              Colors.white,
                                              13.sp,
                                              FontWeight.normal,
                                            ),
                                          ],
                                        ),
                  poppinsText(
                    "Overall Rating",
                    Colors.white,
                    17.sp,
                    FontWeight.normal,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              /*A condition nga mo ingon nga kung ang user type conumser is katong class na nag need og parameter 
              na farmerid atong gamiton, but kung dli gani consumer, awh katong class na wala nag need og parameter ato gamiton */
              child: (userType == "CONSUMER")
                  ? GetFarmerReview2(farmerId: widget.farmerId.toString())
                  : const GetFarmerReviews(),
            ),
          ],
        ),
      ),
      /*  bottomNavigationBar: Container(
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
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
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

  Future<void> getFarmerRating() async {
    String userType =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
    if (userType == "CONSUMER") {
      double rating =
          await farmerDetails2.getFarmerRating(widget.farmerId.toString());
      setState(() {
        finalRating = rating.toInt();
        finalRating3 = rating.roundToDouble();
      });
    } else {
      double rating = await farmerDetails2
          .getFarmerRating(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        finalRating3 = rating;
        finalRating = rating.toInt();
      });
    }
  }
}
