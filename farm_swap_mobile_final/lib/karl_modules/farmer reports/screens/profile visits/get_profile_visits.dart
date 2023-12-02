import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerProfileVisits extends StatefulWidget {
  const GetFarmerProfileVisits({super.key});

  @override
  State<GetFarmerProfileVisits> createState() => _GetFarmerProfileVisitsState();
}

class _GetFarmerProfileVisitsState extends State<GetFarmerProfileVisits> {
  String photo = "";
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup('fProfileVisits')
          .where('farmerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('viewDate', descending: true)
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
    String consUname = data['consumerUname'];
    String consUrl = data['consumerUrl'];
    Timestamp time = data['viewDate'];
    DateTime viewDate = time.toDate();
    String viewDateString = DateFormat('dd-MM-yyyyy').format(viewDate);

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
                  poppinsText3(viewDateString, Colors.black54, 15.sp, FontWeight.normal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getConsumerProfileUrl(consumerID) async {
    String consumerProfileUrl =
        await consumerDetails.getConsumerProfilePhotoWithParameter(consumerID);
    setState(() {
      photo = consumerProfileUrl;
    });
  }
}
