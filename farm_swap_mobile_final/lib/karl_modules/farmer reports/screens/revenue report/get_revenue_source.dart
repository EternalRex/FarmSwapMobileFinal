import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class GetRevenueSource extends StatefulWidget {
  const GetRevenueSource({super.key});

  @override
  State<GetRevenueSource> createState() => _GetRevenueSourceState();
}

class _GetRevenueSourceState extends State<GetRevenueSource> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sample_SellingTransactions')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
    String consUname = data['consUname'];
    String consUrl = data['consProfileUrl'];
    Timestamp time = data['transactionDate'];
    DateTime transacDate = time.toDate();
    String transacDateString = DateFormat('dd-MM-yyyyy').format(transacDate);
    double amount = (data['addedFarmerWalletAmnt'] as num).toDouble();
    String amountString = amount.toStringAsFixed(2);

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
                backgroundImage: NetworkImage(consUrl),
                radius: 40.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText3(consUname, Colors.black, 20.sp, FontWeight.w400),
                  poppinsText3(transacDateString, Colors.black54, 15.sp, FontWeight.normal),
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              const Icon(FontAwesomeIcons.pesoSign),
              poppinsText3(amountString, Colors.black54, 15.sp, FontWeight.normal),
            ],
          ),
        ),
      ),
    );
  }
}
