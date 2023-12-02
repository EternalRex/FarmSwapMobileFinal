import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetConsumerProfileVisits extends StatefulWidget {
  const GetConsumerProfileVisits({super.key});

  @override
  State<GetConsumerProfileVisits> createState() => _GetConsumerProfileVisitsState();
}

class _GetConsumerProfileVisitsState extends State<GetConsumerProfileVisits> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup('cProfileVisits')
          /*This is conusmerid suppose to be but i failed to rename it in database so i leave it as it is */
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
    String viwerUname = data['viewerUname'];
    String viewersUrl = data['viewerUrl'];
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
                backgroundImage: NetworkImage(viewersUrl),
                radius: 40.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText3(viwerUname, Colors.black, 20.sp, FontWeight.w400),
                  poppinsText3(viewDateString, Colors.black54, 15.sp, FontWeight.normal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
