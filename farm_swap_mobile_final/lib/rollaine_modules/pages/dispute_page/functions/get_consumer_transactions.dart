import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer/consumer_report_barter.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer/consumer_report_sale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetConsumerBarters extends StatefulWidget {
  const GetConsumerBarters({super.key});

  @override
  State<GetConsumerBarters> createState() => _GetConsumerBartersState();
}

class _GetConsumerBartersState extends State<GetConsumerBarters> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('sample_BarterTransactions')
          .where('consumerid',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('transactionDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>(
                      (document) => _buildCCompleteBarterListItems(document))
                  .toList(),
            );
          }
        }
        return const Center(
          child: Text('No Transactions'),
        );
      },
    );
  }

  Widget _buildCCompleteBarterListItems(DocumentSnapshot document) {
    Map<String, dynamic> barter = document.data() as Map<String, dynamic>;

    String consumerLname = barter['consumerLname'];
    String consumerUname = barter['consumerUname'];
    String consumerbarangay = barter['consumerbarangay'];
    String consumermunisipyo = barter['consumermunisipyo'];
    String consumername = barter['consumername'];
    String deductionConsu = barter['deductedConsumerCoins'].toString();
    String deductionFarm = barter['deductedFarmerCoins'].toString();
    String farmerLname = barter['farmerLname'];
    String farmerUname = barter['farmerUname'];
    String farmerbarangay = barter['farmerbarangay'];
    String farmermunicipality = barter['farmermunicipality'];
    String farmername = barter['farmername'];
    String itemUrl = barter['itemUrl'];
    String itemname = barter['itemname'];
    String itemvalue = barter['itemvalue'].toString();
    String listingId = barter['listingid'];
    String listingUrl = barter['listingUrl'];
    String listingname = barter['listingname'];
    String listingvalue = barter['listingvalue'].toString();
    String percentageFee = barter['percentageFee'];

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp dateTimestamp = document['transactionDate'];

    //Converts this timestamp to a DateTime object.
    DateTime dateTime = dateTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String dateFinal = DateFormat('MM/dd/yyyy   HH:mm:ss').format(dateTime);

    //displaying a single row in a list
    return ListTile(
      title: Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  barter['listingUrl']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                barter['listingname'],
                                style: Poppins.contentText
                                    .copyWith(color: const Color(0xFF09051B)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text(
                                    barter['farmerbarangay'],
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                  Text(
                                    ',',
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Text(
                                    barter['farmermunicipality'],
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              barter['listingvalue'].toString(),
                              style: Poppins.buttonText
                                  .copyWith(color: const Color(0xFF09051B)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConsumerReportBarter(
                                  cBarangay: consumerbarangay,
                                  cLname: consumerLname,
                                  cMunicipality: consumermunisipyo,
                                  cName: consumername,
                                  cUname: consumerUname,
                                  deductFarm: deductionFarm,
                                  deductCons: deductionConsu,
                                  fBarangay: farmerbarangay,
                                  fLname: farmerLname,
                                  fMunicipality: farmermunicipality,
                                  fName: farmername,
                                  lName: listingname,
                                  fUname: farmerUname,
                                  iName: itemname,
                                  iUrl: itemUrl,
                                  iValue: itemvalue,
                                  lId: listingId,
                                  lValue: listingvalue,
                                  lUrl: listingUrl,
                                  pFee: percentageFee),
                            ));
                          },
                          icon: const Icon(
                            Icons.report_rounded,
                            color: Colors.red,
                          ),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GetConsumerSales extends StatefulWidget {
  const GetConsumerSales({super.key});

  @override
  State<GetConsumerSales> createState() => _GetConsumerSalesState();
}

class _GetConsumerSalesState extends State<GetConsumerSales> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('sample_SellingTransactions')
          .where('consId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('transactionDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>(
                      (document) => _buildCCompleteSalesListItems(document))
                  .toList(),
            );
          }
        }
        return const Center(
          child: Text('No Transactions'),
        );
      },
    );
  }

  Widget _buildCCompleteSalesListItems(DocumentSnapshot document) {
    Map<String, dynamic> sell = document.data() as Map<String, dynamic>;

    String addedAmount = sell['addedFarmerWalletAmnt'].toString();
    String consBaranay = sell['consBaranay'];
    String consLName = sell['consLName'];
    String consMunicipality = sell['consMunicipality'];
    String consName = sell['consName'];
    String consProfileUrl = sell['consProfileUrl'];
    String consUname = sell['consUname'];
    String deductFarmer = sell['deductedFarmerSwapCoins'].toString();
    String farmerBarangay = sell['farmerBarangay'];
    String farmerLname = sell['farmerLname'];
    String farmerMunicipality = sell['farmerMunicipality'];
    String farmerName = sell['farmerName'];
    String farmerProfileUrl = sell['farmerProfileUrl'];
    String farmerUname = sell['farmerUname'];
    String listingId = sell['listingId'];
    String listingName = sell['listingName'];
    String listingPrice = sell['listingPrice'];
    String listingQuan = sell['listingQuan'];
    String listingStatus = sell['listingStatus'];
    String listingUrl = sell['listingUrl'];
    String purchasePrice = sell['purchasePrice'].toString();
    String purchaseQuan = sell['purchaseQuan'].toString();

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp dateTimestamp = document['transactionDate'];

    //Converts this timestamp to a DateTime object.
    DateTime dateTime = dateTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String transact = DateFormat('MM/dd/yyyy   HH:mm:ss').format(dateTime);

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp purchaseTimestamp = document['purchaseTime'];

    //Converts this timestamp to a DateTime object.
    DateTime purchaseTime = purchaseTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String purchaseDate =
        DateFormat('MM/dd/yyyy   HH:mm:ss').format(purchaseTime);

    //displaying a single row in a list
    return ListTile(
      title: Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  sell['farmerProfileUrl']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                sell['farmerName'] + ' ' + sell['farmerLname'],
                                style: Poppins.contentText
                                    .copyWith(color: const Color(0xFF09051B)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text(
                                    sell['farmerBarangay'],
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                  Text(
                                    ',',
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    sell['farmerMunicipality'],
                                    style: Poppins.detailsText.copyWith(
                                        color: const Color(0xFF09051B)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              transact,
                              style: Poppins.buttonText
                                  .copyWith(color: const Color(0xFF09051B)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ConsumerDisputeSale(
                                    addedAmnt: addedAmount,
                                    cBarangay: consBaranay,
                                    cLname: consLName,
                                    cMunicipality: consMunicipality,
                                    cName: consName,
                                    cUrl: consProfileUrl,
                                    cUname: consUname,
                                    deductFarm: deductFarmer,
                                    fBarangay: farmerBarangay,
                                    fLname: farmerLname,
                                    fMunicipality: farmerMunicipality,
                                    fName: farmerName,
                                    fUname: farmerUname,
                                    fUrl: farmerProfileUrl,
                                    lId: listingId,
                                    lName: listingName,
                                    lPrice: listingPrice,
                                    lQuan: listingQuan,
                                    lStatus: listingStatus,
                                    lUrl: listingUrl,
                                    pPrice: purchasePrice,
                                    pQuan: purchaseQuan),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.report_rounded,
                            color: Colors.red,
                          ),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
