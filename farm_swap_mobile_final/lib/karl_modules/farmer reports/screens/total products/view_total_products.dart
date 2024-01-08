import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/farmer%20reports/widgets/reports_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalNumberofProducts extends StatefulWidget {
  const TotalNumberofProducts({super.key});

  @override
  State<TotalNumberofProducts> createState() => _TotalNumberofProductsState();
}

class _TotalNumberofProductsState extends State<TotalNumberofProducts> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  int forbarter = 0;
  int forbarterFruits = 0;
  int forSell = 0;
  int forsellFruits = 0;
  int barteredProducts = 0;
  int barteredFruitsProducts = 0;
  int soldProducts = 0;

  @override
  void initState() {
    super.initState();
    countBarterListings();
    countBarterListingsFruits();
    countSellListings();
    countSellListingsFruits();
    countBarteredListings();
    countBarteredListingsFruits();
    countSoldListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Products",
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
            /*For barter products */
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: (forbarter == 0)
                          ? Center(
                              child: poppinsText(
                                'No Barter Listings',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    forbarter.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Vegetable Barter Listings",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: (forbarterFruits == 0)
                          ? Center(
                              child: poppinsText(
                                'No Barter Listings',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    forbarterFruits.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Fruit Barter Listings",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                  /*For sellign products */
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
                      child: (forSell == 0)
                          ? Center(
                              child: poppinsText(
                                'No Sell Listings',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    forSell.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Vegetable Sell Listings",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                  /*For sell fruits*/
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
                      child: (forSell == 0)
                          ? Center(
                              child: poppinsText(
                                'No Sell Listings',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    forsellFruits.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Fruit Sell Listings",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                  /*For barter transactions */
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
                      child: (barteredProducts == 0)
                          ? Center(
                              child: poppinsText(
                                'No Barter Transactions',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    barteredProducts.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText2(
                                  "Vegetable Barter Transactions",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
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
                      child: (barteredProducts == 0)
                          ? Center(
                              child: poppinsText(
                                'No Barter Transactions',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    barteredFruitsProducts.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Fruit Barter Transactions",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                  /*for sell transactions*/
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
                      child: (soldProducts == 0)
                          ? Center(
                              child: poppinsText(
                                'No Selling Transactions',
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: poppinsText(
                                    soldProducts.toString(),
                                    farmSwapTitlegreen,
                                    40.sp,
                                    FontWeight.bold,
                                  ),
                                ),
                                poppinsText(
                                  "Selling Transactions",
                                  Colors.black54,
                                  20.sp,
                                  FontWeight.bold,
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
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
        child: const ReportsNavBar(),
      ),
    );
  }

  /*Counting the number of posted products for barter that are vegetables*/
  Future<void> countBarterListings() async {
    int totalListings = 0;

    try {
      /*QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterListings') // Replace with your parent collection
          .doc('your_parent_document_id') // Replace with your parent document ID
          .collection('barter') // Subcollection name you want to count
          .get();*/
      /*Since isa raman ka collection group ang nag name og barter so kani lang na approach ako gamiton para shortcut */
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('barter')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listCategory', isEqualTo: "VEGETABLES")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      forbarter = totalListings;
    });
  }

/*Counting the barter listing that are fruites */
  Future<void> countBarterListingsFruits() async {
    int totalListings = 0;

    try {
      /*QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterListings') // Replace with your parent collection
          .doc('your_parent_document_id') // Replace with your parent document ID
          .collection('barter') // Subcollection name you want to count
          .get();*/
      /*Since isa raman ka collection group ang nag name og barter so kani lang na approach ako gamiton para shortcut */
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('barter')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listCategory', isEqualTo: "FRUITS")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      forbarterFruits = totalListings;
    });
  }

  /*Counsting the number of posted products for vegetable sell*/
  Future<void> countSellListings() async {
    int totalListings = 0;

    try {
      /*QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterListings') // Replace with your parent collection
          .doc('your_parent_document_id') // Replace with your parent document ID
          .collection('barter') // Subcollection name you want to count
          .get();*/
      /*Since isa raman ka collection group ang nag name og barter so kani lang na approach ako gamiton para shortcut */
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('sell')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listCategory', isEqualTo: "VEGETABLES")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      forSell = totalListings;
    });
  }

/*Count the number of posted Fruit products for sell */
  Future<void> countSellListingsFruits() async {
    int totalListings = 0;

    try {
      /*QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterListings') // Replace with your parent collection
          .doc('your_parent_document_id') // Replace with your parent document ID
          .collection('barter') // Subcollection name you want to count
          .get();*/
      /*Since isa raman ka collection group ang nag name og barter so kani lang na approach ako gamiton para shortcut */
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('sell')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listCategory', isEqualTo: "VEGETABLES")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      forsellFruits = totalListings;
    });
  }

/*Getting the total number of bartered products vegetables*/
  Future<void> countBarteredListings() async {
    int totalListings = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterTransactions')
          .where('farmerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listingCategory', isEqualTo: "VEGETABLES")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      barteredProducts = totalListings;
    });
  }

/*Count the number of bartered fruit procucts*/
  Future<void> countBarteredListingsFruits() async {
    int totalListings = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_BarterTransactions')
          .where('farmerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('listingCategory', isEqualTo: "FRUITS")
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }

    setState(() {
      barteredFruitsProducts = totalListings;
    });
  }

/*Getting the total number of selling products */
  Future<void> countSoldListings() async {
    int totalListings = 0;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('sample_SellingTransactions')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      totalListings = querySnapshot.size; // Get the number of documents in the subcollection
    } catch (e) {
      print('Error counting barter listings: $e');
    }
    setState(() {
      soldProducts = totalListings;
    });
  }
}
