import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/screens/consumer%20profile%20reports/get_consumer_profiler_visits.dart';
import 'package:farm_swap_mobile_final/karl_modules/consumer%20reports/widgets/customer_report_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumerProfileReports extends StatefulWidget {
  const ConsumerProfileReports({super.key});

  @override
  State<ConsumerProfileReports> createState() => _ConsumerProfileReportsState();
}

class _ConsumerProfileReportsState extends State<ConsumerProfileReports> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  int overallVisit = 0;
  int monthlyVisits = 0;

  @override
  void initState() {
    super.initState();
    getTotalProfileVisits();
    getTotalProfileVisitsCurrentMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Profile Visits",
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
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  Container(
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
                            overallVisit.toString(),
                            farmSwapTitlegreen,
                            40.sp,
                            FontWeight.bold,
                          ),
                          poppinsText(
                            "All Time Visits",
                            Colors.black54,
                            25.sp,
                            FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
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
                              monthlyVisits.toString(),
                              orangeNormal,
                              40.sp,
                              FontWeight.bold,
                            ),
                            poppinsText(
                              "Monthly Visits",
                              Colors.black54,
                              25.sp,
                              FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            poppinsText3('Visitors', farmSwapTitlegreen, 20.sp, FontWeight.bold),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const GetConsumerProfileVisits(),
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

  String userid = FirebaseAuth.instance.currentUser!.uid;

  /*Function that will get the total profile visits */
  Future<void> getTotalProfileVisits() async {
    int totalVisits = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_ConsumerProfileVisits') // Replace with your main collection
          .doc('profileView$userid') // Replace with your document ID
          .collection('cProfileVisits')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
        if (doc.exists) {
          print("went here");
          // Assuming visitCount is a field in each document
          int visitCount = (doc.data()['fprofileVisitCount'] as num).toInt() ?? 0;
          totalVisits += visitCount;
        }
      }
    } catch (e) {
      print('Error getting total profile visits: $e');
    }
    setState(() {
      overallVisit = totalVisits;
    });
  }

  /*Function that will get the total profile visits of the current month*/
  Future<void> getTotalProfileVisitsCurrentMonth() async {
    int totalVisits = 0;

    try {
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
      DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_ConsumerProfileVisits') // Replace with your main collection
          .doc('profileView$userid') // Replace with your document ID
          .collection('cProfileVisits')
          .where('viewDate', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('viewDate', isLessThanOrEqualTo: lastDayOfMonth)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
        if (doc.exists) {
          print("Went in here2");
          // Assuming visitCount is a field in each document
          int visitCount = (doc.data()['fprofileVisitCount'] as num).toInt() ?? 0;
          totalVisits += visitCount;
        }
      }
    } catch (e) {
      print('Error getting total profile visits for current month: $e');
    }

    setState(() {
      monthlyVisits = totalVisits;
    });
  }
}
