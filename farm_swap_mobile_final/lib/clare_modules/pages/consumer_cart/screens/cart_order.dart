import 'package:farm_swap_mobile_final/clare_modules/pages/consumer_cart/screens/consumer_cart.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/widgets/consumer_buying_navbar.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../database/save_cart_order.dart';

class ConsumerCart extends StatefulWidget {
  const ConsumerCart({
    super.key,
    required this.farmerName,
    required this.farmerLName,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerBarangay,
    required this.farmerMunicipal,
    required this.listingUrl,
    required this.listingName,
    required this.listingPrice,
    required this.listingQuan,
    required this.listingId,
    required this.listingStatus,
    required this.imageUrl,
  });
  /*Mga properties na needed para sa place order */
  final String farmerName;
  final String farmerLName;
  final String farmerUname;
  final String farmerId;
  final String farmerBarangay;
  final String farmerMunicipal;
  final String listingUrl;
  final String listingName;
  final String listingPrice;
  final String listingQuan;
  final String listingId;
  final String listingStatus;
  final String imageUrl;

  @override
  State<ConsumerCart> createState() => _ConsumerCartState();
}

class _ConsumerCartState extends State<ConsumerCart> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  SaveCartOrder cart = SaveCartOrder();
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();

/*Variables na mo hold sa information ni consumer*/
  String consName = "";
  String consLName = "";
  String consUname = "";
  String consId = FirebaseAuth.instance.currentUser!.uid;
  String consBarangay = "";
  String consMunicipality = "";
  double consWallet = 0;

  String kilogramString = "Kilograms";
  double kilogramdDouble = 1;
  String totalString = "Total Price";
  double totalDouble = 1;

  @override
  void initState() {
    super.initState();
    getConsumerData();
  }

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Place Order"),
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
          if (userRole == "CONSUMER")
            /*Shoppping cart button */
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const ConsumerCartOrders();
                      },
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.cartShopping),
                iconSize: 30.sp,
              ),
            ),
        ],
      ),
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: Column(
        children: [
          /*This is for the listing name */
          Padding(
            padding: EdgeInsets.only(top: 15.sp),
            child: Center(
              child: poppinsText(
                  widget.listingName, Colors.black, 30.sp, FontWeight.w500),
            ),
          ),
          /*This is for the listing price per kilogram */
          Padding(
            padding: EdgeInsets.only(top: 5.sp),
            child: Center(
              child: poppinsText("${widget.listingPrice} pesos /kg",
                  Colors.black54, 17.sp, FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.sp),
            child: Center(
              child: poppinsText("${widget.listingQuan} kg available",
                  Colors.black54, 10.sp, FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: 300.w,
            height: 280.h,
            decoration: BoxDecoration(
              color: Colors.white,
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
            child: Column(
              children: [
                /*For the price field*/
                Padding(
                  padding: EdgeInsets.only(top: 20.sp),
                  child: SizedBox(
                    width: 200.w,
                    child: Center(
                      child: Column(
                        children: [
                          poppinsText("$totalString pesos", Colors.black, 20.sp,
                              FontWeight.normal),
                          const Divider(),
                          poppinsText(
                            "Total amount payable",
                            Colors.black54,
                            12.sp,
                            FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                /*For the kilograms */
                SizedBox(
                  width: 200.w,
                  child: Center(
                    child: Column(
                      children: [
                        poppinsText("$kilogramString kg", Colors.black, 20.sp,
                            FontWeight.normal),
                        const Divider(),
                        poppinsText(
                          "Total kilograms payable",
                          Colors.black54,
                          12.sp,
                          FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                /*Icon Button for adding how many kilograms*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*For incrementing the number of kilograms */
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          if (kilogramdDouble ==
                              double.tryParse(widget.listingQuan)!.toDouble()) {
                            showExceedMessage();
                          } else {
                            setState(() {
                              kilogramdDouble = kilogramdDouble + 1;
                              kilogramString = kilogramdDouble.toString();

                              double payable = kilogramdDouble *
                                  double.tryParse(widget.listingPrice)!
                                      .toDouble();
                              totalDouble = payable;
                              totalString = payable.toString();
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
                      onPressed: () {
                        /*this will check if the totalDouble or the price is 
                        still one therefore the increment and decrement button arent touhced by users
                        */
                        if (totalDouble == 1) {
                          showInvalidMessage();
                        } else {
                          //this will save directly to the cart order
                          /*Actual saving of data */
                          cart.saveCartOrder(
                            consName,
                            consLName,
                            consUname,
                            consId,
                            consBarangay,
                            consMunicipality,
                            widget.farmerName,
                            widget.farmerLName,
                            widget.farmerUname,
                            widget.farmerId,
                            widget.farmerBarangay,
                            widget.farmerMunicipal,
                            widget.listingName,
                            widget.listingId,
                            widget.listingPrice,
                            widget.listingQuan,
                            kilogramdDouble,
                            totalDouble,
                            DateTime.now(),
                            false,
                            widget.listingStatus,
                            widget.imageUrl,
                          );
                          showSuccessMessage();
                        }
                      },
                      child: poppinsText("Add to cart", farmSwapTitlegreen,
                          20.sp, FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    /*For decrementing the number of kilograms*/
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        onPressed: () {
                          if (kilogramdDouble == 1) {
                            showDeceedMessage();
                          } else {
                            setState(() {
                              kilogramdDouble = kilogramdDouble - 1;
                              print(kilogramdDouble.toString());
                              kilogramString = kilogramdDouble.toString();

                              double payable = kilogramdDouble *
                                  double.tryParse(widget.listingPrice)!
                                      .toDouble();
                              totalDouble = payable;
                              totalString = payable.toString();
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
          SizedBox(
            height: 30.h,
          ),
        ],
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

  /*A function that will show a message if the amount of kilograms exceeded with the available kilograms*/
  void showExceedMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You cannot exceed the number of available kilograms",
              Colors.black,
              15.sp,
              FontWeight.normal),
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
          content: poppinsText("You have reached the minimum kilogram",
              Colors.black, 15.sp, FontWeight.normal),
        );
      },
    );
  }

  /*A function that will show a message that the order has been successfully placed and awaiting for farmer confirmation*/
  void showSuccessMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 20.sp, FontWeight.bold),
          content: poppinsText(
            "You successfully added the product into your cart.",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const ConsumerCartOrders();
                      },
                    ),
                  );
                },
                child: const Text("Go to Cart"))
          ],
        );
      },
    );
  }

  void showInvalidMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning!", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
            "Please adjust the kilogram/s",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

  /*Function that will get  the needed consumer data*/
  Future<void> getConsumerData() async {
    String consumserName = await consumerDetails.getConsumerFirstname();
    String consumerLname = await consumerDetails.getConsumerLastName();
    String consumerUname = await consumerDetails.getUname();
    String consumerBarangay = await consumerDetails.getBaranggay();
    String consumerMunisipyo = await consumerDetails.getMunicipalityFirstname();
    double consumerWalletBalance = await consumerDetails.getWalletBalance();

    setState(() {
      consName = consumserName;
      consLName = consumerLname;
      consUname = consumerUname;
      consBarangay = consumerBarangay;
      consMunicipality = consumerMunisipyo;
      consWallet = consumerWalletBalance;
    });
  }

  /*Function to show that consumer has not enough balance */
  /*A function that will show a message if the amount of kilograms being purchased is less than 1 kilogram*/
  void showNotWalletBalanceMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You do not have enough wallet balance to continue the transaction, Please Cash in",
              Colors.black,
              15.sp,
              FontWeight.normal),
        );
      },
    );
  }
}
