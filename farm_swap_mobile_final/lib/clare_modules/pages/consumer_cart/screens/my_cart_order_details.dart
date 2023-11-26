import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/message_consumer/consumer_farmer_actualchat.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/rating%20page/screens/consumer_selling_rating_farmer.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/database/update_confirmed.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/confirmed_farmer_orders.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/consumer_confirmed_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'consumer_cart.dart';

class MyCartDetails extends StatefulWidget {
  const MyCartDetails({
    super.key,
    required this.consName,
    required this.consLName,
    required this.consUname,
    required this.consId,
    required this.consBarangay,
    required this.consMunicipality,
    required this.farmerName,
    required this.farmerLName,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.listingName,
    required this.listingId,
    required this.listingPrice,
    required this.listingQuantity,
    required this.purchaseQuantity,
    required this.purchaseTotalPrice,
    required this.purchaseTime,
    required this.isCompletedPurchase,
    required this.isConfirmed,
    required this.confirmedDate,
    required this.completeDate,
    required this.listingStatus,
    required this.selected,
    required this.declined,
    required this.imageUrl,
    required this.consumerCompleted,
  });

  /*Consumer Details */
  final String consName;
  final String consLName;
  final String consUname;
  final String consId;
  final String consBarangay;
  final String consMunicipality;

  /*Farmer Details */
  final String farmerName;
  final String farmerLName;
  final String farmerUname;
  final String farmerId;
  final String farmerBarangay;
  final String farmerMunicipality;

  /*listing details*/
  final String listingName;
  final String listingId;
  final String listingPrice;
  final String listingQuantity;

  /*Purchase details*/
  final double purchaseQuantity;
  final double purchaseTotalPrice;
  final String purchaseTime;
  final bool isCompletedPurchase;
  final bool isConfirmed;
  final String confirmedDate;
  final String completeDate;
  final String listingStatus;
  final bool selected;
  final bool declined;
  final String imageUrl;
  final bool consumerCompleted;

  @override
  State<MyCartDetails> createState() => _MyCartDetailsState();
}

class _MyCartDetailsState extends State<MyCartDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  UpdateConfirmedOrder update = UpdateConfirmedOrder();
  String farmerPhoto = "";
  int finalRating = 0;

  @override
  void initState() {
    super.initState();
    getFarmerDetails();
    getFarmerRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Cart Details"),
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
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container that holds the image */
            Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            /*The listing name */
            poppinsText(
              widget.listingName,
              Colors.black,
              30.sp,
              FontWeight.w500,
            ),
            /*Underline */
            Padding(
              padding: EdgeInsets.only(right: 20.sp, left: 20.sp),
              child: Divider(
                color: FarmSwapGreen.darkGreen,
                thickness: 5,
              ),
            ),
            /*Row that holds listing price and quantity */
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText(
                    "${widget.listingPrice} pesos/kg :",
                    Colors.black54,
                    13.sp,
                    FontWeight.normal,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  poppinsText(
                    "${widget.listingQuantity} kilograms",
                    Colors.black54,
                    13.sp,
                    FontWeight.normal,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            /*Stacks that hold the profile photo of farmer and the messenger icon */
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(farmerPhoto),
                  radius: 100.r,
                ),
                Positioned(
                  top: 125.h,
                  left: 125.h,
                  child: IconButton(
                    onPressed: () {
                      /*A condition that says the consumer cant use the chat functionality once the farmer declines the */
                      (widget.declined == true)
                          ? showCantDoChatMessage()
                          :
                          /*Messaging function*/
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ConsumerFarmerActualChat(
                                  farmerId: widget.farmerId,
                                  farmerName: widget.farmerName,
                                  farmerUname: widget.farmerUname,
                                  farmerBarangay: widget.farmerBarangay,
                                  farmerMunicipality: widget.farmerMunicipality,
                                  consumerId: widget.consId,
                                  consumerFname: widget.consName,
                                  consumerLname: widget.consLName,
                                  consumerUname: widget.consUname,
                                  consumerBarangay: widget.consBarangay,
                                  consumerMunicipality: widget.consMunicipality,
                                  listingId: widget.listingId,
                                  listingName: widget.listingName,
                                );
                              },
                            ));
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebookMessenger,
                      size: 40.sp,
                      color: FarmSwapGreen.normalGreen,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            poppinsText(
              "${widget.farmerName} ${widget.farmerLName} (${widget.farmerUname})",
              Colors.black,
              17.sp,
              FontWeight.normal,
            ),
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
                            "(4/5)",
                            Colors.black,
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
                                "(3/5)",
                                Colors.black,
                                13.sp,
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
                                    "(2/5)",
                                    Colors.black,
                                    13.sp,
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
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  poppinsText2(
                                    "(1/5)",
                                    Colors.black,
                                    13.sp,
                                    FontWeight.normal,
                                  ),
                                ],
                              ),
            poppinsText(
              "Located at ${widget.farmerBarangay} ${widget.farmerMunicipality} ",
              Colors.black54,
              13.sp,
              FontWeight.normal,
            ),
            poppinsText(
              "Farmer",
              Colors.black54,
              13.sp,
              FontWeight.normal,
            ),
            SizedBox(
              height: 27.h,
            ),
            /*Row for the purchase Quantity and its equivalent value */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Purchase Quantity", Colors.black, 15.sp,
                        FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      "${widget.purchaseQuantity} kg",
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
/*Total price and it value */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                        "Total Price", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      "${widget.purchaseTotalPrice} pesos",
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*Date of Order */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                        "Order Date", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      widget.purchaseTime,
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*Status of Order */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                        "Order Status", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  /*Condition ni nga atong ilisan ang text kung ma selected ma siya */
                  SizedBox(
                    width: 150.w,
                    child: (widget.isConfirmed == true &&
                            widget.declined == false)
                        ? poppinsText(
                            "Confirmed", Colors.green, 15.sp, FontWeight.normal)
                        : (widget.isConfirmed == false &&
                                widget.declined == true)
                            ? poppinsText("Declined", Colors.red, 15.sp,
                                FontWeight.normal)
                            : poppinsText("Waiting...", Colors.blue, 15.sp,
                                FontWeight.normal),
                  ),
                ],
              ),
            ),
            /*Row for completed */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                        "Completed", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      widget.isCompletedPurchase.toString(),
                      (widget.isCompletedPurchase == true)
                          ? farmSwapTitlegreen
                          : Colors.red,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*If dli pa gani accepted or confirmed ang order ni consumer, wala say mark as done ang transaction display lang ang container */
            (widget.selected == true && widget.isConfirmed == true)
                ?
                /*To Mark the transaction as done */
                (widget.consumerCompleted == true)
                    ? poppinsText("Transaction Marked as Done", Colors.red, 20,
                        FontWeight.normal)
                    : Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              showRemoveMessage();
                            },
                            child: Container(
                              height: 50,
                              width: 145,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF53E78B),
                                    Color(0xFF14BE77)
                                  ],
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
                                        15.sp,
                                        FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return SellConsumerRatingFarmer(
                                    farmerId: widget.farmerId,
                                    farmerName: widget.farmerName,
                                    farmerLname: widget.farmerLName,
                                    farmerUname: widget.farmerUname,
                                    farmerBarangay: widget.farmerBarangay,
                                    farmerMunicipal: widget.farmerMunicipality,
                                    consId: widget.consId,
                                    consName: widget.consName,
                                    consUname: widget.consUname,
                                    consLname: widget.consLName,
                                    consBarangay: widget.consBarangay,
                                    consMunicipal: widget.consMunicipality,
                                    listingUrl: widget.imageUrl,
                                    listingid: widget.listingId,
                                  );
                                },
                              ));
                            },
                            child: Container(
                              height: 50,
                              width: 145,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFE0000),
                                    Color(0xFFD83F31)
                                  ],
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
                                        Icons.star_border,
                                        color: Colors.white,
                                      ),
                                      poppinsText(
                                        "Rate Farmer",
                                        Colors.white,
                                        15.sp,
                                        FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                : Container(),
            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const ConsumerCartOrders();
              },
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

  /*Function that will get the details of farmer */
  Future<void> getFarmerDetails() async {
    String farmerProfile = await farmerDetails
        .getFarmerUserProfilePhotoWithParameter(widget.farmerId);
    setState(() {
      farmerPhoto = farmerProfile;
    });
  }

  void showRemoveMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              poppinsText("Information", Colors.blue, 20.sp, FontWeight.w500),
          content: poppinsText(
            "This transaction will be removed from confirmed order list, Go to dispute page to dispute this transaction",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    /*Updates the consumer update field into true*/
                    update.updateOrderCompletedConsumer(
                        widget.listingId, widget.consId);
                    /*Navigate back to the confirmed orders page */
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ConfirmedOrders();
                        },
                      ),
                    );
                  },
                  child: poppinsText(
                      "Continue", farmSwapTitlegreen, 17.sp, FontWeight.normal),
                ),
                TextButton(
                  onPressed: () {
                    /*Navigate back to the confirmed orders page */
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ConsumerConfirmedOrder();
                        },
                      ),
                    );
                  },
                  child: poppinsText(
                      "Cancel", farmSwapTitlegreen, 17.sp, FontWeight.normal),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

/*Function that will return a message saying that the chat functionality can't be used because he is denied*/
  void showCantDoChatMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.w500),
          content: poppinsText(
            "You cannot message the farmer because your order was declined",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

  Future<void> getFarmerRating() async {
    double rating = await farmerDetails.getFarmerRating(widget.farmerId);
    setState(() {
      finalRating = rating.toInt();
    });
  }
}
