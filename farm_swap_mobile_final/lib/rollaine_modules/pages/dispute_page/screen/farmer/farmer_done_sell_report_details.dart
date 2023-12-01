import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/navbar/farmer_dispute_page_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FarmerDoneSellReportDetails extends StatefulWidget {
  const FarmerDoneSellReportDetails({
    super.key,
    required this.consumerUrl,
    required this.consumerName,
    required this.consumerId,
    required this.consumerUname,
    required this.consumserLastName,
    required this.consumerBarangay,
    required this.consumerMunicipality,
    required this.listingName,
    required this.listingId,
    required this.listingPrice,
    required this.listingUrl,
    required this.listinQuan,
    required this.purchaseQuan,
    required this.purchasePrice,
    required this.swapCoinsPay,
    required this.isDisputed,
    required this.transDate2,
    required this.disputeDate2,
    required this.disputeStatus,
    required this.disputeUrl,
    required this.disputeText,
    required this.disputeDate3,
    required this.transDate3,
  });

/*Consumer Details */
  final String consumerUrl;
  final String consumerName;
  final String consumerId;
  final String consumerUname;
  final String consumserLastName;
  final String consumerBarangay;
  final String consumerMunicipality;

  /*listing details */
  final String listingName;
  final String listingId;
  final double listingPrice;
  final String listingUrl;
  final double listinQuan;

  final double purchaseQuan;
  final double purchasePrice;
  final double swapCoinsPay;
  final bool isDisputed;
  /*Transaction date */
  final DateTime transDate2;
  final String transDate3;
  /*Dispute date */
  final DateTime disputeDate2;
  final String disputeDate3;
  final String disputeStatus;
  final String disputeUrl;
  final String disputeText;

  @override
  State<FarmerDoneSellReportDetails> createState() => _FarmerDoneSellReportDetailsState();
}

class _FarmerDoneSellReportDetailsState extends State<FarmerDoneSellReportDetails> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    getConsumerPic();
  }

  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  String consumerProfilePic = '';

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
          height: 1980.h,
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
                          Icons.attach_money,
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
                            image: NetworkImage(widget.consumerUrl),
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
              /*
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
                height: 30.h,
              ),*/
              /*Listing Name */
              poppinsText2(widget.listingName, Colors.black, 20.sp, FontWeight.w500),
              const Divider(),
              poppinsText2("Listing Name", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              poppinsText2(widget.purchaseQuan.toString(), Colors.black, 20.sp, FontWeight.w500),
              const Divider(),
              poppinsText2(
                  "Number of kilograms purchased", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              poppinsText2(widget.listingPrice.toString(), Colors.black, 20.sp, FontWeight.w500),
              const Divider(),
              poppinsText2("Price per kilogram", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*Total price payed */
              poppinsText2(widget.purchasePrice.toString(), Colors.black, 20.sp, FontWeight.w500),
              const Divider(),
              poppinsText2("Total paid price", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              /*Transaction range*/
              /*Condition to check of what is the value range */
              (widget.purchasePrice < 10000)
                  ? poppinsText2("1 - 10K", Colors.black, 20.sp, FontWeight.normal)
                  : (widget.purchasePrice > 10000 && widget.purchasePrice <= 30000)
                      ? poppinsText2("11K - 30K", Colors.black, 20.sp, FontWeight.normal)
                      : (widget.purchasePrice > 30000 && widget.purchasePrice <= 60000)
                          ? poppinsText2("31K - 60K", Colors.black, 20.sp, FontWeight.normal)
                          : (widget.purchasePrice > 60000 && widget.purchasePrice <= 100000)
                              ? poppinsText2("61K - 99K", Colors.black, 20.sp, FontWeight.normal)
                              : poppinsText2(
                                  "abov 100K",
                                  Colors.black,
                                  20.sp,
                                  FontWeight.normal,
                                ),
              poppinsText2("Value range", Colors.black54, 15.sp, FontWeight.normal),
              const Divider(),
              /*This is for the transaction fee percentage*/
              (widget.purchasePrice < 10000)
                  ? poppinsText2("2% transaction fee", Colors.black, 20.sp, FontWeight.normal)
                  : (widget.purchasePrice > 10000 && widget.purchasePrice <= 30000)
                      ? poppinsText2("4% transaction fee", Colors.black, 20.sp, FontWeight.normal)
                      : (widget.purchasePrice > 30000 && widget.purchasePrice <= 60000)
                          ? poppinsText2(
                              "6% transaction fee", Colors.black, 20.sp, FontWeight.normal)
                          : (widget.purchasePrice > 60000 && widget.purchasePrice <= 100000)
                              ? poppinsText2(
                                  "8% transaction fee", Colors.black, 20.sp, FontWeight.normal)
                              : poppinsText2(
                                  "10% transaction fee",
                                  Colors.black,
                                  20.sp,
                                  FontWeight.normal,
                                ),
              poppinsText2("Value range", Colors.black54, 15.sp, FontWeight.normal),
              const Divider(),
              /*Swap coins transaction fee */
              poppinsText2(widget.swapCoinsPay.toString(), Colors.black, 20.sp, FontWeight.w500),
              const Divider(),
              poppinsText2("Swap coins transaction fee", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              /*The picture proof of the report */
              Container(
                height: 500.h,
                width: 300.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.disputeUrl),
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
              const Divider(),
              poppinsText2("Picture Proof", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 20.h,
              ),
              /*Mao ni ang report or ang reklamo */
              SizedBox(
                width: 300.w,
                child: poppinsText2(widget.disputeText, Colors.black, 15.sp, FontWeight.normal),
              ),
              const Divider(),
              poppinsText2("Actual Report", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 20.h,
              ),
              /*Date sa apg reklamo */
              SizedBox(
                width: 300.w,
                child: poppinsText2(
                  widget.disputeDate3,
                  Colors.black,
                  15.sp,
                  FontWeight.normal,
                ),
              ),
              const Divider(),
              poppinsText2("Report Date Filed", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 40.h,
              ),

              /*Picture of the consumer */
              CircleAvatar(
                backgroundImage: NetworkImage(consumerProfilePic),
                radius: 90.r,
              ),
              const Divider(),
              poppinsText2("Reported Consumer Profile", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 20.h,
              ),
              /*Name of the consumer*/
              poppinsText2(
                "${widget.consumerName} ${widget.consumserLastName} (${widget.consumerUname}) ",
                Colors.black,
                20.sp,
                FontWeight.normal,
              ),
              const Divider(),
              poppinsText2("Reported Consumer name", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 20.h,
              ),
              /*location of customer */
              poppinsText2(
                " Barangay ${widget.consumerBarangay}, ${widget.consumerMunicipality}",
                Colors.black,
                20.sp,
                FontWeight.normal,
              ),
              const Divider(),
              poppinsText2("Reported Consumer Location", Colors.black54, 15.sp, FontWeight.normal),
              SizedBox(
                height: 50.h,
              ),
              /*Indication of the report status */
              (widget.disputeStatus == "PENDING")
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: orangeDarkActive,
                        boxShadow: [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                          child:
                              poppinsText2("INVESTIGATING", Colors.white, 20.sp, FontWeight.bold)),
                    )
                  /*This will display when report is resoled */
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*View resolution when it is availanble */
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "View Resolution",
                            style: TextStyle(
                              color: darkGreen,
                              fontSize: 17.sp,
                              decoration: TextDecoration.underline,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: farmSwapTitlegreen,
                            boxShadow: [
                              BoxShadow(
                                color: shadow,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: poppinsText2("RESOLVED", Colors.white, 20.sp, FontWeight.bold),
                          ),
                        ),
                      ],
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

  /*Getting the picture of the consumer*/
  Future<void> getConsumerPic() async {
    String profurl = await consumerDetails.getConsumerProfilePhotoWithParameter(widget.consumerId);
    setState(() {
      consumerProfilePic = profurl;
    });
  }
}
