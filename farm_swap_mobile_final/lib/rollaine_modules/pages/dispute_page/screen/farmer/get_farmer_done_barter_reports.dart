import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/farmer_done_report_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerDoneBarterReports extends StatefulWidget {
  const GetFarmerDoneBarterReports({super.key});

  @override
  State<GetFarmerDoneBarterReports> createState() => _GetFarmerDoneBarterReportsState();
}

class _GetFarmerDoneBarterReportsState extends State<GetFarmerDoneBarterReports> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup('fBarterDispute')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('disputeDateFile', descending: true)
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

/*

Ako lang sa ni e comment kat wa man nako ni ma need, kung sa future mag need sa farmer details, pwde
rani e uncomment
    /*Farmer Details */
    String farmerName = data['farmerName'];
    String farmerId = data['farmerId'];
    String farmerLastName = data['farmerLname'];
    String farmerUname = data['farmerUname'];
    String farmerBarangay = data['farmerBarangay'];
    String farmerMunicipality = data['farmerMunicipality'];*/

    /*Consumer Details */
    String consumerName = data['consumerName'];
    String consumerId = data['consumerId'];
    String consumerUname = data['consumerUname'];
    String consumserLastName = data['consumerLname'];
    String consumerBarangay = data['consumerBarangay'];
    String consumerMunicipality = data['consumerMunicipality'];

    /*Item details */
    String itemName = data['itemName'];

    double itemValue = (data['itemValue'] as num).toDouble();

    String itemUrl = data['itemUrl'];
    String listingName = data['listingName'];
    String listingId = data['listingId'];
    String listingPrice = data['listingPrice'];
    String listingUrl = data['listingUrl'];
    bool isResolved = data['isResolved'];
    String farmerDisputeStatus = data['farmerDisputeStatus'];
    String farmerDisputeText = data['farmerDisputeText'];
    String farmerDisputeUrl = data['farmerDisputeUrl'];
    double deductedFarmerCoins = (data['deductedFarmerCoins'] as num).toDouble();
    double deductedConsumerCoins = (data['deductedConsumerCoins'] as num).toDouble();
    double averageValue = (data['valueRange'] as num).toDouble();
    String percentage = data['percentageFee'];
    Timestamp transactionDate = data['transactionDate'];
    Timestamp disputeDateFile = data['disputeDateFile'];

    /*Converting date time into String valuue */
    DateTime tansacDate = transactionDate.toDate();
    String finalTransacDate = DateFormat('dd-MM-yyyy').format(tansacDate);

    DateTime reportDate = disputeDateFile.toDate();
    String finalReportDate = DateFormat('dd-MM-yyyy').format(reportDate);

    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: GestureDetector(
        onTap: () {
          /*Redirect to the page that displays the whole details of the report*/
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FarmerDoneReportsDetails(
                  consumerName: consumerName,
                  consumerId: consumerId,
                  consumerUname: consumerUname,
                  consumserLastName: consumserLastName,
                  consumerBarangay: consumerBarangay,
                  consumerMunicipality: consumerMunicipality,
                  itemName: itemName,
                  itemValue: itemValue,
                  itemUrl: itemUrl,
                  listingName: listingName,
                  listingId: listingId,
                  listingPrice: listingPrice,
                  listingUrl: listingUrl,
                  isResolved: isResolved,
                  farmerDisputeStatus: farmerDisputeStatus,
                  farmerDisputeText: farmerDisputeText,
                  farmerDisputeUrl: farmerDisputeUrl,
                  deductedFarmerCoins: deductedFarmerCoins,
                  deductedConsumerCoins: deductedConsumerCoins,
                  averageValue: averageValue,
                  percentage: percentage,
                  transactionDate: tansacDate,
                  disputeDateFile: reportDate,
                  trnsactionDateString: finalTransacDate,
                  disputeDateFileString: finalReportDate,
                );
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
                          "$consumerName $consumserLastName ($consumerUname)",
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
                          finalReportDate,
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
