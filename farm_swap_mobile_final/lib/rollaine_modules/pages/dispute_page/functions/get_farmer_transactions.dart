import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/constants/colors_rollaine.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/farmer_report_barter.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/farmer/farmer_report_sale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerBarters extends StatefulWidget {
  const GetFarmerBarters({super.key});

  @override
  State<GetFarmerBarters> createState() => _GetFarmerBartersState();
}

class _GetFarmerBartersState extends State<GetFarmerBarters> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('sample_BarterTransactions')
          .where('farmerid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
                      (document) => _buildFCompleteBarterListItems(document))
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

  Widget _buildFCompleteBarterListItems(DocumentSnapshot document) {
    Map<String, dynamic> barter = document.data() as Map<String, dynamic>;

    String consumerId = barter["consumerid"];
    String consumerLname = barter['consumerLname'];
    String consumerUname = barter['consumerUname'];
    String consumerbarangay = barter['consumerbarangay'];
    String consumermunisipyo = barter['consumermunisipyo'];
    String consumername = barter['consumername'];
    double deductionConsu = (barter['deductedConsumerCoins'] as num).toDouble();
    double deductionFarm = (barter['deductedFarmerCoins'] as num).toDouble();
    String farmerLname = barter['farmerLname'];
    String farmerUname = barter['farmerUname'];
    String farmerbarangay = barter['farmerbarangay'];
    String farmermunicipality = barter['farmermunicipality'];
    String farmername = barter['farmername'];
    String itemUrl = barter['itemUrl'];
    String itemname = barter['itemname'];
    String itemvalue = barter['itemvalue'].toString();
    String listingUrl = barter['listingUrl'];
    String listingid = barter['listingid'];
    String listingname = barter['listingname'];
    String listingvalue = barter['listingvalue'].toString();
    String percentageFee = barter['percentageFee'];
    double averageValue = (barter["averagevalue"] as num).toDouble();
    bool disputed = barter["isDisputed"];

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp dateTimestamp = document['transactionDate'];

    //Converts this timestamp to a DateTime object.
    DateTime dateTime = dateTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String dateFinal = DateFormat('MM/dd/yyyy   HH:mm:ss').format(dateTime);

    //displaying a single row in a list
    if (disputed == false) {
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
                                    barter['itemUrl']),
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
                                  barter['itemname'],
                                  style: Poppins.contentText
                                      .copyWith(color: const Color(0xFF09051B)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      barter['consumerbarangay'],
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
                                      barter['consumermunisipyo'],
                                      style: Poppins.detailsText.copyWith(
                                          color: const Color(0xFF09051B)),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                barter['listingname'],
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FarmerReportBarter(
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
                                    lId: listingid,
                                    lValue: listingvalue,
                                    lUrl: listingUrl,
                                    pFee: percentageFee,
                                    consumerId: consumerId,
                                    average: averageValue,
                                    transactionTime: dateTime,
                                  ),
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
    } else {
      return Container();
    }
  }
}

class GetFarmerSales extends StatefulWidget {
  const GetFarmerSales({super.key});

  @override
  State<GetFarmerSales> createState() => _GetFarmerSalesState();
}

class _GetFarmerSalesState extends State<GetFarmerSales> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('sample_SellingTransactions')
          .where('farmerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                      (document) => _buildFCompleteSalesListItems(document))
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

  Widget _buildFCompleteSalesListItems(DocumentSnapshot document) {
    Map<String, dynamic> sell = document.data() as Map<String, dynamic>;

    String addedAmount = sell['addedFarmerWalletAmnt'].toString();
    String consBaranay = sell['consBaranay'];
    String consLName = sell['consLName'];
    String consMunicipality = sell['consMunicipality'];
    String consName = sell['consName'];
    String consProfileUrl = sell['consProfileUrl'];
    String consUname = sell['consUname'];
    double deductFarmer = (sell['deductedFarmerSwapCoins'] as num).toDouble();
    String farmerBarangay = sell['farmerBarangay'];
    String farmerLname = sell['farmerLname'];
    String farmerMunicipality = sell['farmerMunicipality'];
    String farmerName = sell['farmerName'];
    String farmerProfileUrl = sell['farmerProfileUrl'];
    String farmerUname = sell['farmerUname'];
    String listingName = sell['listingName'];
    String listingId = sell['listingId'];
    String listingPrice = sell['listingPrice'];
    String listingQuan = sell['listingQuan'];
    String listingStatus = sell['listingStatus'];
    String listingUrl = sell['listingUrl'];
    double purchasePrice = (sell['purchasePrice'] as num).toDouble();
    double purchaseQuan = (sell['purchaseQuan'] as num).toDouble();
    String consumerId = sell['consId'];
    String farmerId = sell['farmerId'];
    bool isDisputed = sell['isDisputed'];

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp dateTimestamp = document['transactionDate'];

    //Converts this timestamp to a DateTime object.
    DateTime dateTimeTransac = dateTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String transact =
        DateFormat('MM/dd/yyyy   HH:mm:ss').format(dateTimeTransac);

    //Extracts a timestamp called 'Activity Date' from the document.
    Timestamp purchaseTimestamp = document['purchaseTime'];

    //Converts this timestamp to a DateTime object.
    DateTime purchaseTime = purchaseTimestamp.toDate();

    //Formats the DateTime as a string in the 'MM/DD/yyyy HH:mm:ss' format
    String purchaseDate =
        DateFormat('MM/dd/yyyy   HH:mm:ss').format(purchaseTime);

    if (isDisputed == false) {
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
                                image: CachedNetworkImageProvider(sell['listingUrl']),
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
                                  sell['listingName'],
                                  style:
                                      Poppins.contentText.copyWith(color: const Color(0xFF09051B)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      sell['farmerBarangay'],
                                      style: Poppins.detailsText
                                          .copyWith(color: const Color(0xFF09051B)),
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
                              print(farmerProfileUrl);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FarmerDisputeSale(
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
                                    pQuan: purchaseQuan,
                                    consId: consumerId,
                                    farmerId: farmerId,
                                    transactionDate: dateTimeTransac,
                                    transactionDateString: transact,
                                  ),
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
    } else {
      return Container();
    }
  }
}
