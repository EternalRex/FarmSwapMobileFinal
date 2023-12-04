import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/f_sell_resolutions/f_sell_resolution_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerSellingResolution extends StatefulWidget {
  const GetFarmerSellingResolution({super.key});

  @override
  State<GetFarmerSellingResolution> createState() => _GetFarmerSellingResolutionState();
}

class _GetFarmerSellingResolutionState extends State<GetFarmerSellingResolution> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sample_FSellResolution')
          .orderBy('resolutionDate', descending: true)
          .where('farmerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // ignore: avoid_print
          print(snapshot.error);
          return const Text("Indexing Problem");
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs
                .map((document) => _buildFCompleteBarterListItems(document))
                .toList(),
          );
          /* return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>((document) => _buildFCompleteBarterListItems(document))
                  .toList(),
            ); */
        } else {
          return const Center(
            child: Text("No Reports Yet"),
          );
        }
      },
    );
  }

  Widget _buildFCompleteBarterListItems(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    String listingUrl = data['listUrl'];
    String adminEmail = data['adminemail'];
    String consumerid = data['consumerid'];
    String farmerid = data['farmerid'];
    String penaltyMessage = data['penaltyMessage'];
    Timestamp resolDate = data['resolutionDate'];
    String resolutionMessage = data['resolutionMessage'];
    String reported = data['reportedUser'];
    String reporting = data['reportingUser'];
    String reportedRole = data['reportedRole'];
    String reportingRole = data['reportingRole'];

    /*Time conversion */
    DateTime resolDateDateTime = resolDate.toDate();
    String resolDateString = DateFormat('dd-yyyy-MM').format(resolDateDateTime);

    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FarmerSellResolutionDetails(
                    listingUrl: listingUrl,
                    adminEmail: adminEmail,
                    consumerid: consumerid,
                    farmerid: farmerid,
                    penaltyMessage: penaltyMessage,
                    resolDate: resolDateDateTime,
                    resolDateString: resolDateString,
                    resolutionMessage: resolutionMessage,
                    reported: reported,
                    reporting: reporting,
                    reportedRole: reportedRole,
                    reportingRole: reportingRole);
              },
            ),
          );
        },
        child: Container(
          height: 100.h,
          width: 10.w,
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
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(listingUrl),
                  radius: 50.r,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        poppinsText2(
                          penaltyMessage,
                          Colors.black,
                          13.sp,
                          FontWeight.normal,
                        ),
                        poppinsText2(
                          "Reported User",
                          Colors.black54,
                          13.sp,
                          FontWeight.normal,
                        ),
                        poppinsText2(
                          resolDateString,
                          Colors.black54,
                          13.sp,
                          FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
