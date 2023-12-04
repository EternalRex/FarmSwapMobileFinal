import "package:cloud_firestore/cloud_firestore.dart";
import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_barter_resolutions/consumer_dispute_barter_resol_details.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";

class GetBarterConsumerResolution extends StatefulWidget {
  const GetBarterConsumerResolution({super.key});

  @override
  State<GetBarterConsumerResolution> createState() => _GetBarterConsumerResolutionState();
}

class _GetBarterConsumerResolutionState extends State<GetBarterConsumerResolution> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('sample_CBarterResolution')
          .orderBy('resolutionDate', descending: true)
          .where('consumerid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
    String itemUrl = data['itemUrl'];
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
          /*Redirect to the page that displays the whole details of the report*/
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ConsumerBarterResolutionDetails(
                itemUrl: itemUrl,
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
                reportingRole: reportingRole,
              );
            },
          ));
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
                  backgroundImage: NetworkImage(itemUrl),
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
