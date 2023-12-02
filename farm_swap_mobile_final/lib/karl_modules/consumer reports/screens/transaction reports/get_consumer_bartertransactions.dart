import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ConsumerGetAllBarterListingsReports extends StatefulWidget {
  const ConsumerGetAllBarterListingsReports({super.key});

  @override
  State<ConsumerGetAllBarterListingsReports> createState() =>
      _ConsumerGetAllBarterListingsReportsState();
}

class _ConsumerGetAllBarterListingsReportsState extends State<ConsumerGetAllBarterListingsReports> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sample_BarterTransactions')
          .where('consumerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('transactionDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // ignore: avoid_print
          print(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>((document) => accessDocumentContents(document))
                  .toList(),
            );
          }
          return const Text("No Bidings One");
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: farmSwapTitlegreen,
              strokeWidth: 5,
            ),
          );
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Timestamp transacTime = data['transactionDate'];
    DateTime transacDate = transacTime.toDate();
    String transacDateString = DateFormat('dd-MM-yyyyy').format(transacDate);

    String listingUrl = data['listingUrl'];
    String listingname = data['listingname'];
    String itemName = data['itemname'];
    String itemUrl = data['itemUrl'];

    return Padding(
      padding: EdgeInsets.all(3.sp),
      child: Container(
        width: 190.w,
        height: 100.h,
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
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(listingUrl),
                radius: 40.r,
              ),
              SizedBox(
                width: 20.w,
              ),
              SizedBox(
                width: 100.w,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText2(listingname, Colors.black, 13.sp, FontWeight.w400),
                      const Icon(Icons.compare_arrows_rounded),
                      poppinsText2(itemName, Colors.black, 13.sp, FontWeight.w400),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(itemUrl),
                radius: 40.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
