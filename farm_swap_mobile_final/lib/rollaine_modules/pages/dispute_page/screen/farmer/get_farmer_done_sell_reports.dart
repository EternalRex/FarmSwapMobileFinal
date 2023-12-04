import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/farmer_done_sell_report_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerDoneSellReports extends StatefulWidget {
  const GetFarmerDoneSellReports({super.key});

  @override
  State<GetFarmerDoneSellReports> createState() => _GetFarmerDoneSellReportsState();
}

class _GetFarmerDoneSellReportsState extends State<GetFarmerDoneSellReports> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup('fSaleDispute')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('disputeDate', descending: true)
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
    String farmerUrl = data['farmerUrl'];
    String farmerName = data['farmerName'];
    String farmerId = data['farmerId'];
    String farmerLastName = data['farmerLName'];
    String farmerUname = data['farmerUname'];
    String farmerBarangay = data['farmerBarangay'];
    String farmerMunicipality = data['farmerMuniciplaity'];*/

    /*Consumer Details */
    String consumerUrl = data["consumerUrl"];
    String consumerName = data['consumerName'];
    String consumerId = data['consumerId'];
    String consumerUname = data['consumerUname'];
    String consumserLastName = data['consumerLName'];
    String consumerBarangay = data['consumerBarangay'];
    String consumerMunicipality = data['consumerMuniciplaity'];

    /*listing details */
    String listingName = data['listingName'];
    String listingId = data['listingId'];
    double listingPrice = (data['listingPrice'] as num).toDouble();
    String listingUrl = data['listingUrl'];
    double listinQuan = (data['listingQuan'] as num).toDouble();

    double purchaseQuan = (data['purchaseQuantity'] as num).toDouble();
    double purchasePrice = (data['purchasePrice'] as num).toDouble();
    double swapCoinsPay = (data['purchaseSwapCoinsPay'] as num).toDouble();
    bool isDisputed = data['isDisputed'];

    /*Transaction date */
    Timestamp transDate = data['transactionDate'];
    DateTime transDate2 = transDate.toDate();
    String transDate3 = DateFormat('dd-MM-yyyy').format(transDate2);

    /*Dispute date */
    Timestamp disputeDate = data['disputeDate'];
    DateTime disputeDate2 = disputeDate.toDate();
    String disputeDate3 = DateFormat('dd-MM-yyyy').format(disputeDate2);

    String disputeStatus = data['disputeStatus'];
    String disputeUrl = data['disputeUrl'];
    String disputeText = data['disputeText'];

    if (disputeStatus == "PENDING") {
      return Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: GestureDetector(
          onTap: () {
            /*Redirect to the page that displays the whole details of the report*/
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FarmerDoneSellReportDetails(
                    consumerUrl: consumerUrl,
                    consumerName: consumerName,
                    consumerId: consumerId,
                    consumerUname: consumerUname,
                    consumserLastName: consumserLastName,
                    consumerBarangay: consumerBarangay,
                    consumerMunicipality: consumerMunicipality,
                    listingName: listingName,
                    listingId: listingId,
                    listingPrice: listingPrice,
                    listingUrl: listingUrl,
                    listinQuan: listinQuan,
                    purchaseQuan: purchaseQuan,
                    purchasePrice: purchasePrice,
                    swapCoinsPay: swapCoinsPay,
                    isDisputed: isDisputed,
                    transDate2: transDate2,
                    disputeDate2: disputeDate2,
                    disputeStatus: disputeStatus,
                    disputeUrl: disputeUrl,
                    disputeText: disputeText,
                    disputeDate3: disputeDate3,
                    transDate3: transDate3,
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
                            transDate3,
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
    } else {
      return Container();
    }
  }
}
