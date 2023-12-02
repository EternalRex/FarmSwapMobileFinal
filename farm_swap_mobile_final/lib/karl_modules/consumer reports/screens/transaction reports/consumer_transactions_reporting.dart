import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/transaction%20reports/get_consumer_bartertransactions.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/transaction%20reports/get_consumer_buy_transactions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/customer_report_navbar.dart';

class ConsumerAllTransactionsReporting extends StatefulWidget {
  const ConsumerAllTransactionsReporting({super.key});

  @override
  State<ConsumerAllTransactionsReporting> createState() => _ConsumerAllTransactionsReportingState();
}

class _ConsumerAllTransactionsReportingState extends State<ConsumerAllTransactionsReporting> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  int buyTranasctions = 0;
  int barterTransactions = 0;

  @override
  void initState() {
    super.initState();
    countSoldListings();
    countBarteredListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Transactions",
              style: TextStyle(fontSize: 25.sp),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 300.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText(
                        buyTranasctions.toString(),
                        farmSwapTitlegreen,
                        40.sp,
                        FontWeight.bold,
                      ),
                      poppinsText(
                        "Buy Transac.",
                        Colors.black54,
                        25.sp,
                        FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            /*For Barter Transactions */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const ConsumerGetBuyTransactionsHistory(),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: Container(
                width: 300.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText(
                        barterTransactions.toString(),
                        farmSwapTitlegreen,
                        40.sp,
                        FontWeight.bold,
                      ),
                      poppinsText(
                        "Barter Transac.",
                        Colors.black54,
                        25.sp,
                        FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const ConsumerGetAllBarterListingsReports(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
          color: greenNormal,
          image: const DecorationImage(
            image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: farmSwapTitlegreen),
        ),
        child: const CustomerReportNavbar(),
      ),
    );
  }

  /*This is will count the total number of buy transactions */
  Future<void> countSoldListings() async {
    int totalListings = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_SellingTransactions')
          .where('consId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }
    setState(() {
      buyTranasctions = totalListings;
    });
  }

  /*This is will count the total number of buy transactions */
  Future<void> countBarteredListings() async {
    int totalListings = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterTransactions')
          .where('consumerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }
    setState(() {
      barterTransactions = totalListings;
    });
  }
}
