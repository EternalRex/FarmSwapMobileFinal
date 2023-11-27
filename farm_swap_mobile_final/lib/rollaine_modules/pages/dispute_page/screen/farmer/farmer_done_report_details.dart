import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/navbar/farmer_dispute_page_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FarmerDoneReportsDetails extends StatefulWidget {
  const FarmerDoneReportsDetails({
    super.key,
    required this.consumerName,
    required this.consumerId,
    required this.consumerUname,
    required this.consumserLastName,
    required this.consumerBarangay,
    required this.consumerMunicipality,

    /*Item details */
    required this.itemName,
    required this.itemValue,
    required this.itemUrl,
    required this.listingName,
    required this.listingId,
    required this.listingPrice,
    required this.listingUrl,
    required this.isResolved,
    required this.farmerDisputeStatus,
    required this.farmerDisputeText,
    required this.farmerDisputeUrl,
    required this.deductedFarmerCoins,
    required this.deductedConsumerCoins,
    required this.averageValue,
    required this.percentage,
    required this.transactionDate,
    required this.disputeDateFile,
    required this.trnsactionDateString,
    required this.disputeDateFileString,
  });

  /*Consumer Details */
  final String consumerName;
  final String consumerId;
  final String consumerUname;
  final String consumserLastName;
  final String consumerBarangay;
  final String consumerMunicipality;

  /*Item details */
  final String itemName;
  final double itemValue;
  final String itemUrl;
  final String listingName;
  final String listingId;
  final String listingPrice;
  final String listingUrl;
  final bool isResolved;
  final String farmerDisputeStatus;
  final String farmerDisputeText;
  final String farmerDisputeUrl;
  final double deductedFarmerCoins;
  final double deductedConsumerCoins;
  final double averageValue;
  final String percentage;
  final DateTime transactionDate;
  final DateTime disputeDateFile;
  final String trnsactionDateString;
  final String disputeDateFileString;

  @override
  State<FarmerDoneReportsDetails> createState() => _FarmerDoneReportsDetailsState();
}

class _FarmerDoneReportsDetailsState extends State<FarmerDoneReportsDetails> {
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
            poppinsText(
              "Report Details",
              Colors.white,
              20.sp,
              FontWeight.bold,
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
      /*Scrollable ang  center page */
      body: SingleChildScrollView(
        /*Container nga nag lokop sa tibook center page */
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 740.h,
          decoration: const BoxDecoration(color: Colors.white),
          /*Column na mag display sa content sa center page vertically */
          child: Column(
            children: [
              /*Row that will contain both the bartered items */
              Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Container of the listing picture */
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.listingUrl),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadow,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Icon(
                          Icons.compare_arrows_rounded,
                          size: 100.sp,
                          color: farmSwapTitlegreen,
                        ),
                      ),
                      /*Container of the item picture */
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.itemUrl),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: shadow,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              /*The item name and listing name */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  poppinsText3(widget.listingName, Colors.black, 20.sp, FontWeight.normal),
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 30.sp,
                        color: farmSwapTitlegreen,
                      ),
                    ),
                  ),
                  poppinsText4(widget.itemName, Colors.black, 20.sp, FontWeight.normal),
                ],
              ),
              Divider(
                thickness: 2.sp,
              ),
              poppinsText2("Listing & Item Name", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*The respective values */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  poppinsText3(widget.listingPrice, Colors.black, 20.sp, FontWeight.normal),
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 30.sp,
                        color: farmSwapTitlegreen,
                      ),
                    ),
                  ),
                  poppinsText4(widget.itemValue.toString(), Colors.black, 20.sp, FontWeight.normal),
                ],
              ),
              Divider(
                thickness: 2.sp,
              ),
              poppinsText2(
                  "Listing & Item Estimated Values", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*Respective value range */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*Condition to check of what is the value range */
                  (widget.averageValue < 10000)
                      ? poppinsText3("1 - 10K", Colors.black, 20.sp, FontWeight.normal)
                      : (widget.averageValue > 10000 && widget.averageValue <= 30000)
                          ? poppinsText3("11K - 30K", Colors.black, 20.sp, FontWeight.normal)
                          : (widget.averageValue > 30000 && widget.averageValue <= 60000)
                              ? poppinsText3("31K - 60K", Colors.black, 20.sp, FontWeight.normal)
                              : (widget.averageValue > 60000 && widget.averageValue <= 100000)
                                  ? poppinsText3(
                                      "61K - 99K", Colors.black, 20.sp, FontWeight.normal)
                                  : poppinsText3(
                                      "abov 100K",
                                      Colors.black,
                                      20.sp,
                                      FontWeight.normal,
                                    ),
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 30.sp,
                        color: farmSwapTitlegreen,
                      ),
                    ),
                  ),
                  (widget.averageValue < 10000)
                      ? poppinsText3("1 - 10K", Colors.black, 20.sp, FontWeight.normal)
                      : (widget.averageValue > 10000 && widget.averageValue <= 30000)
                          ? poppinsText3("11K - 30K", Colors.black, 20.sp, FontWeight.normal)
                          : (widget.averageValue > 30000 && widget.averageValue <= 60000)
                              ? poppinsText3("31K - 60K", Colors.black, 20.sp, FontWeight.normal)
                              : (widget.averageValue > 60000 && widget.averageValue <= 100000)
                                  ? poppinsText3(
                                      "61K - 99K", Colors.black, 20.sp, FontWeight.normal)
                                  : poppinsText3(
                                      "abov 100K",
                                      Colors.black,
                                      20.sp,
                                      FontWeight.normal,
                                    ),
                ],
              ),
              Divider(
                thickness: 2.sp,
              ),
              poppinsText2("Value Range Category", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*Total swap coins deducted */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  poppinsText3(widget.deductedFarmerCoins.toString(), Colors.black, 20.sp,
                      FontWeight.normal),
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: Icon(
                        FontAwesomeIcons.circleCheck,
                        size: 30.sp,
                        color: farmSwapTitlegreen,
                      ),
                    ),
                  ),
                  poppinsText4(widget.deductedConsumerCoins.toString(), Colors.black, 20.sp,
                      FontWeight.normal),
                ],
              ),
              Divider(
                thickness: 2.sp,
              ),
              poppinsText2("Deducted Swap Coins", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*For the transaction Fee */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText3(
                    widget.percentage,
                    Colors.black,
                    20.sp,
                    FontWeight.normal,
                  ),
                ],
              ),
              Divider(
                thickness: 2.sp,
              ),
              poppinsText2("Transaction fee percentage", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
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
        child: const FarmerBarterDisputesNavBar(),
      ),
    );
  }
}
