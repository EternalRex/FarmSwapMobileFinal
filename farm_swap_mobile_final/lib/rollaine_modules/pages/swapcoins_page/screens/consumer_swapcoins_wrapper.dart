import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/constants/colors_rollaine.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/screens/consumer_topup_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ReadConsumerSwapCoins extends StatefulWidget {
  const ReadConsumerSwapCoins({super.key, required this.documentId});

  final String documentId;

  @override
  State<ReadConsumerSwapCoins> createState() => _ReadConsumerSwapCoinsState();
}

class _ReadConsumerSwapCoinsState extends State<ReadConsumerSwapCoins> {
  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_ConsumerUsers");

    return FutureBuilder(
      future: reference.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          //creating a variable for the current user uid to pass on the builderList
          final userId = FirebaseAuth.instance.currentUser!.uid;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      height: 180.h,
                      width: 700.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Swap Coins:',
                              style: Poppins.commuTitle.copyWith(
                                color: const Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            '₱ ${data['swapcoins']}',
                            style: Poppins.number.copyWith(
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: ConsumerTopUpPage(),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 750.w,
                      height: 45.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Transactions',
                              style: GoogleFonts.viga(
                                textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  color: const Color(0xFF09041B),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 750.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 2.w, color: greenNormal),
                          bottom: BorderSide(width: 2.w, color: greenNormal),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    'Date',
                                    style: Poppins.userName.copyWith(
                                      color: const Color(0xFF09041B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    'Amount',
                                    style: Poppins.userName.copyWith(
                                      color: const Color(0xFF09041B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    'Status',
                                    style: Poppins.userName.copyWith(
                                      color: const Color(0xFF09041B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 500.h,
                        child: _buildSwapcoinsList(userId),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildSwapcoinsList(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sample_SwapCoinsLogs')
          .where('userId', isEqualTo: userId)
          .where('userRole', isEqualTo: 'CONSUMER')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                color: greenNormalHover,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final logs = snapshot.data!.docs;

          if (logs.isEmpty) {
            return const Center(
              child: Text('No transaction history available for this user.'),
            );
          }
          return ListView(
            children: logs.map<Widget>((document) {
              return _buildSwapCoinsListItems(document);
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildSwapCoinsListItems(DocumentSnapshot document) {
    /*We are accessing a document that was passed here one by one, and map it into 
    String and dynamic, to look the same in the firebase strcuture */
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Timestamp dateTimestamp = document["dateTime"];
    DateTime dateTime = dateTimestamp.toDate();
    String dateFinal = DateFormat('MM/dd/yyyy').format(dateTime);

    if (searchValue.isNotEmpty) {
      if (data['swapcoins'] == searchValue ||
          data['status'] == searchValue ||
          data['dateTime'] == searchValue) {
        return ListTile(
          title: GestureDetector(
            child: Container(
              width: 750.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadow,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        dateFinal,
                        style: Poppins.detailsText.copyWith(
                          color: const Color(0xFF09041B),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "${data["swapcoins"]}",
                        style: Poppins.detailsText.copyWith(
                          color: const Color(0xFF09041B),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 35, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //status
                            SizedBox(
                              height: 25.h,
                              width: 55.w,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color.fromARGB(255, 159, 206, 18),
                                      Color.fromARGB(255, 159, 206, 18),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Center(
                                    child: Text(
                                      "${data["status"]}",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Container(
                    height: 20.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        5,
                      )),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x21000000),
                          blurRadius: 10,
                          offset: Offset(3, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                  ),
                  content: SizedBox(
                    height: 90.h,
                    child: Column(
                      children: [
                        //row for transaction data
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Date : ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              dateFinal,
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        //row for user uid
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "User ID: ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${data["userId"]} ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        //row for type of transaction just calling the request from the db
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Top Up Swap Coins : ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${data["swapcoins"]} ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        //row for the transaction status
                        Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Text(
                                "Status: ",
                                style: Poppins.adminName.copyWith(
                                  color: const Color(0xFF09041B),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "${data["status"]} ",
                                style: Poppins.adminName.copyWith(
                                  color: const Color(0xFF09041B),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Close the second AlertDialog
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      }
    }

    //if search bar is empty this one will display
    else {
      return ListTile(
        title: GestureDetector(
          child: Container(
            width: 750.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadow,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      dateFinal,
                      style: Poppins.detailsText.copyWith(
                        color: const Color(0xFF09041B),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "${data["swapcoins"]}",
                      style: Poppins.detailsText.copyWith(
                        color: const Color(0xFF09041B),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 35, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //status
                          SizedBox(
                            height: 25.h,
                            width: 55.w,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 159, 206, 18),
                                    Color.fromARGB(255, 159, 206, 18),
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Center(
                                  child: Text(
                                    "${data["status"]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Container(
                  height: 20.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      5,
                    )),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x21000000),
                        blurRadius: 10,
                        offset: Offset(3, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Transaction Details',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.50,
                      ),
                    ),
                  ),
                ),
                content: SizedBox(
                  height: 90.h,
                  child: Column(
                    children: [
                      //row for transaction data
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Date : ",
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateFinal,
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      //row for user uid
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "User ID: ",
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${data["userId"]} ",
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //row for type of transaction just calling the request from the db
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Top Up Swap Coins : ",
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${data["swapcoins"]} ",
                            style: Poppins.adminName.copyWith(
                              color: const Color(0xFF09041B),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      //row for the transaction status
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              "Status: ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "${data["status"]} ",
                              style: Poppins.adminName.copyWith(
                                color: const Color(0xFF09041B),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Close the second AlertDialog
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
    return Container();
  }
}
