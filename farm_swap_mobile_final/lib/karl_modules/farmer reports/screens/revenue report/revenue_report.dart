import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/screens/profile%20visits/get_profile_visits.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/screens/revenue%20report/get_revenue_source.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/widgets/reports_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RevenueReport extends StatefulWidget {
  const RevenueReport({super.key});

  @override
  State<RevenueReport> createState() => _RevenueReportState();
}

class _RevenueReportState extends State<RevenueReport> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  double monthlyRevenu = 0;
  String monthlyRevenueString = '';
  double overallRevenu = 0;
  String overAllRevenueString = '';

  @override
  void initState() {
    super.initState();
    getTotalOverAllRevenue();
    getTotalMonthlyRevenue();
  }

  @override
  Widget build(BuildContext context) {
    overAllRevenueString = overallRevenu.toStringAsFixed(2);
    monthlyRevenueString = monthlyRevenu.toStringAsFixed(2);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Revenue",
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
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Row(
                children: [
                  Container(
                    width: 165.w,
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
                    child: (overallRevenu == 0)
                        ? Center(
                            child: poppinsText(
                              "No Reveneu Yet",
                              Colors.red,
                              13.sp,
                              FontWeight.normal,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 40.sp),
                                child: poppinsText(
                                    "All Time Revenue", Colors.black, 15.sp, FontWeight.bold),
                              ),
                              Center(
                                child: poppinsText(
                                  overAllRevenueString,
                                  farmSwapTitlegreen,
                                  20,
                                  FontWeight.bold,
                                ),
                              ),
                              Center(
                                child: poppinsText(
                                  "pesos",
                                  Colors.black54,
                                  13,
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 165.w,
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
                    child: (monthlyRevenu == 0)
                        ? Center(
                            child: poppinsText(
                              "No Reveneu Yet",
                              Colors.red,
                              13.sp,
                              FontWeight.normal,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 40.sp),
                                child: poppinsText(
                                    "Month Revenue", Colors.black, 15.sp, FontWeight.bold),
                              ),
                              Center(
                                child: poppinsText(
                                  monthlyRevenueString,
                                  farmSwapTitlegreen,
                                  20,
                                  FontWeight.bold,
                                ),
                              ),
                              Center(
                                child: poppinsText(
                                  "pesos",
                                  Colors.black54,
                                  13,
                                  FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const GetRevenueSource(),
            ),
            /* poppinsText(overAllRevenueString, Colors.black, 20, FontWeight.bold),
            poppinsText(monthlyRevenueString, Colors.black, 20, FontWeight.bold),*/
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
        child: const ReportsNavBar(),
      ),
    );
  }

  /*Function that will add the generated overall revenues*/
  Future<void> getTotalOverAllRevenue() async {
    double totalVisits = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_SellingTransactions')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
        if (doc.exists) {
          print("went here sa amount");
          // Assuming visitCount is a field in each document
          double visitCount = (doc.data()['addedFarmerWalletAmnt'] as num).toDouble() ?? 0;
          totalVisits += visitCount;
        }
      }
    } catch (e) {
      print('Error getting total profile visits: $e');
    }
    setState(() {
      overallRevenu = totalVisits;
    });
  }

  /*Function that will get the current month revenue*/
  Future<void> getTotalMonthlyRevenue() async {
    double totalVisits = 0;

    try {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_SellingTransactions')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('transactionDate', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('transactionDate', isLessThanOrEqualTo: lastDayOfMonth)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
        if (doc.exists) {
          print("di a dri ang boing");
          // Assuming visitCount is a field in each document
          double visitCount = (doc.data()['addedFarmerWalletAmnt'] as num).toDouble() ?? 0;
          totalVisits += visitCount;
        }
      }
    } catch (e) {
      print('Error getting total profile visits: $e');
    }
    setState(() {
      monthlyRevenu = totalVisits;
    });
  }
}
