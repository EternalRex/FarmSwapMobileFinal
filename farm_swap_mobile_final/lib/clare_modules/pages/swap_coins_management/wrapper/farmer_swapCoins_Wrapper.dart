// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/swap_coins_management/wrapper/topup_SwapCoins_ShowDialog.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../farmer_wallet_management/widgets/text/sub_header_pendingtransaction.dart';

class DisplayFarmerSwapCoinsWrapper extends StatefulWidget {
  const DisplayFarmerSwapCoinsWrapper({super.key, required this.documentId});

  final String documentId;

  @override
  State<DisplayFarmerSwapCoinsWrapper> createState() =>
      _DisplayFarmerSwapCoinsWrapperState();
}

class _DisplayFarmerSwapCoinsWrapperState
    extends State<DisplayFarmerSwapCoinsWrapper> {
  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");

    return FutureBuilder(
      future: reference.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          //creating a variable for the current user uid to pass sa builderlist
          final userId = FirebaseAuth.instance.currentUser!.uid;

          return Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              /*naay duha ka column sa sizedbox then gi center
              inside sa column naay align para sa text na SWAPCOINS
              second column kay para sa data nga swampcoins sa farmer              
              */
              Center(
                child: SizedBox(
                  width: 325.w,
                  height: 120.h,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Swap Coins : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      //this will display sa balance ni farmer
                      Text(
                        "P ${data["swapcoins"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              //calling the top up button
              const Center(
                child: TopUpButton(),
              ),
              SizedBox(
                height: 20.h,
              ),
              /**
               * this center kay nag consist sa header para sa transactions
               * then diri makita ang transactions if pending or completed na
               * then maka search sa lists of transaction and if i click
               * ang specific list tile naay mugawas dialog box para sa transaction details
               */
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 350.w,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 10,
                            offset: Offset(3, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Transactions',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.50,
                                ),
                              ),
                              SizedBox(
                                width: 55.w,
                              ),
                              //sizedbox for search textfield
                              SizedBox(
                                width: 160.w,
                                height: 25.h,
                                child: TextField(
                                  controller: searchController,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFDA6317),
                                    height: 1.5.h,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(5),
                                    filled: true,
                                    fillColor: const Color(0xFFF9A84D)
                                        .withOpacity(0.10),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Search here',
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          searchValue = searchController.text;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        color: const Color(0xFFDA6317),
                                        size: 18.sp,
                                      ),
                                    ),
                                    prefixIconColor: const Color(0xFFDA6317),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    //lists of pending transactions here
                    Container(
                      width: 350.w,
                      height: 300.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 10,
                            offset: Offset(3, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          //header sa information na i display
                          const SubHeaderPendingTransaction1(),
                          SizedBox(
                            height: 10.h,
                          ),

                          Container(
                            width: 350.w,
                            height: 250.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            /**
                            * the streambuilder will listen the changes
                            * of SwapCoinsLogs collection in the firebase 
                            */
                            child: _buildUserList(userId),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
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

  Widget _buildUserList(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sample_SwapCoinsLogs')
          .where('userId', isEqualTo: userId)
          .where('userRole', isEqualTo: 'FARMER')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
              return _buildUserListItems(document);
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildUserListItems(DocumentSnapshot document) {
    /*We are accessing a document that was passed here one by one, and map it into 
    String and dynamic, to look the same in the firebase strcuture */
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp dateTimestamp = document["dateTime"];
    DateTime dateTime = dateTimestamp.toDate();
    String dateFinal = DateFormat('MM-dd-yyyy HH:mm:ss').format(dateTime);

    //the searched transaction will display here
    if (searchValue.isNotEmpty) {
      if (data["swapcoins"] == searchValue ||
          data["status"] == searchValue ||
          data["dateTime"] == searchValue) {
        return Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              30,
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
          child: ListTile(
            title: GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: 130.w,
                      child: Text(
                        dateFinal,
                        style: Poppins.adminName.copyWith(
                          color: const Color(0xFF09041B),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${document["swapcoins"]} ",
                        style: Poppins.adminName.copyWith(
                          color: const Color(0xFF09041B),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "${document["status"]} ",
                        style: Poppins.adminName.copyWith(
                          color: const Color(0xFF09041B),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
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
                        height: 100.h,
                        child: Column(
                          children: [
                            //row for transaction date
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
                                  "${document["userId"]} ",
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
                                  "${document["swapcoins"]} ",
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
                                    "${document["status"]} ",
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
            ),
          ),
        );
      }
    }

    //if search bar is empty this one will display
    else {
      return Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            30,
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
        child: ListTile(
          title: GestureDetector(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 130.w,
                    child: Text(
                      dateFinal,
                      style: Poppins.adminName.copyWith(
                        color: const Color(0xFF09041B),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${document["swapcoins"]} ",
                      style: Poppins.adminName.copyWith(
                        color: const Color(0xFF09041B),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${document["status"]} ",
                      style: Poppins.adminName.copyWith(
                        color: const Color(0xFF09041B),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
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
                      height: 100.h,
                      child: Column(
                        children: [
                          //row for transaction date
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
                                "${document["userId"]} ",
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
                                "${document["swapcoins"]} ",
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
                                  "${document["status"]} ",
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
          ),
        ),
      );
    }

    return Container();
  }
}
