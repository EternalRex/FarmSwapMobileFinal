import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConsumerBuyPart1 extends StatefulWidget {
  const ConsumerBuyPart1({
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

  @override
  State<ConsumerBuyPart1> createState() => _ConsumerBuyPart1State();
}

class _ConsumerBuyPart1State extends State<ConsumerBuyPart1> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

/*Variables na mo hold sa information ni consumer*/
  String consName = "";
  String consLName = "";
  String consUname = "";
  String consId = FirebaseAuth.instance.currentUser!.uid;
  String consBarangay = "";

  String kilogramString = "Kilograms";
  double kilogramdDouble = 0;
  String totalString = "Total Price";
  double totalDouble = 0;

  @override
  Widget build(BuildContext context) {
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
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: Column(
        children: [
          /*This is for the listing name */
          Padding(
            padding: EdgeInsets.only(top: 15.sp),
            child: Center(
              child: poppinsText(widget.listingName, Colors.black, 30.sp, FontWeight.w500),
            ),
          ),
          /*This is for the listing price per kilogram */
          Padding(
            padding: EdgeInsets.only(top: 5.sp),
            child: Center(
              child: poppinsText(
                  "${widget.listingPrice} pesos /kg", Colors.black54, 17.sp, FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.sp),
            child: Center(
              child: poppinsText(
                  "${widget.listingQuan} kg available", Colors.black54, 10.sp, FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: 300.w,
            height: 250.h,
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
                          poppinsText("$totalString pesos", Colors.black, 20.sp, FontWeight.normal),
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
                        poppinsText("$kilogramString kg", Colors.black, 20.sp, FontWeight.normal),
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
                          if (kilogramdDouble == double.tryParse(widget.listingQuan)!.toDouble()) {
                            showExceedMessage();
                          } else {
                            setState(() {
                              kilogramdDouble = kilogramdDouble + 1;
                              kilogramString = kilogramdDouble.toString();

                              double payable = kilogramdDouble *
                                  double.tryParse(widget.listingPrice)!.toDouble();
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
                                  double.tryParse(widget.listingPrice)!.toDouble();
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
          TextButton(
            onPressed: () {},
            child: poppinsText("Buy", farmSwapTitlegreen, 26.sp, FontWeight.bold),
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
        child: const DashboardButtomNavBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          content: poppinsText("You cannot exceed the number of available kilograms", Colors.black,
              15.sp, FontWeight.normal),
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
}
