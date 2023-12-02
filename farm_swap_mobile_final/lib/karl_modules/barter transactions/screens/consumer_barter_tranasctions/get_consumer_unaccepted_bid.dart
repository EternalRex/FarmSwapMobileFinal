import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/consumer_barter_tranasctions/get_consumer_bid_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GetConsumerUnselected extends StatefulWidget {
  const GetConsumerUnselected({super.key});

  @override
  State<GetConsumerUnselected> createState() => _GetConsumerUnselectedState();
}

class _GetConsumerUnselectedState extends State<GetConsumerUnselected> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore
          .collectionGroup('barterbids')
          .where('consumerId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('itemBidTime', descending: true)
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
          return const Text("No Bidings Two...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String listingStatus = data["listingStatus"];

    /*Item Data */
    String imageUrl = data["itemPicUrl"];
    String itemName = data["itemName"];
    String itemquantity = data["itemQuantity"].toString();
    String itemValue = data["itemValue"].toString();
    String itemCondition = data["itemCondition"];
    String itemDisc = data["itemDisc"];
    bool isBartered = data["isBarteredOut"];
    bool selected = data["selected"];
    bool isCompleted = data["completed"];
    bool isConsComplete = data["consumerCompleted"];

    /*Listing data*/
    String listingId = data["listingId"];
    String listingName = data["listingName"];
    String listingQuan = data["listingQuantity"].toString();
    String listingPrice = data["listingPrice"].toString();
    // ignore: unused_local_variable
    String listStatus = data["listingStatus"];

    /*Consumer data*/
    String farmerId = data["farmerId"];
    String farmerName = data["farmerName"];
    String farmerLname = data["farmerLName"];
    String farmerUname = data["farmerUname"];
    String farmerBarangay = data["farmerBaranggay"];
    String farmerMunisipyo = data["farmerMunisipyo"];
    bool isBarteredOut = data['isBarteredOut'];

/*Bid time conversion*/
    Timestamp bidtime = data["itemBidTime"];
    DateTime newbidTime = bidtime.toDate();
    String finalbidTime = DateFormat('yyyy-MM-dd').format(newbidTime);

/*Ang mo display diri kay katong mga listings na wala napili-e ni farmer */
    if ((listingStatus == "ACTIVE" || listingStatus == "REACTIVATED") &&
        (selected == false && isBartered == true)) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        /*The oval container*/
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
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
          width: 190.w,
          height: 100.h,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return GetConsumerBidDetails(
                      imgurl: imageUrl,
                      itemname: itemName,
                      itemquan: itemquantity,
                      itemVal: itemValue,
                      itemCond: itemCondition,
                      itemDisc: itemDisc,
                      bartered: isBartered,
                      bidTime: finalbidTime,
                      listId: listingId,
                      listName: listingName,
                      listStat: listingStatus,
                      listPrice: listingPrice,
                      listQuan: listingQuan,
                      farmerid: farmerId,
                      farmername: farmerName,
                      farmerlname: farmerLname,
                      farmeruname: farmerUname,
                      farmerbarangay: farmerBarangay,
                      farmermunicipal: farmerMunisipyo,
                      selected: selected,
                      completed: isCompleted,
                      isConsCompleted: isConsComplete,
                      isBarteredOut: isBarteredOut,
                    );
                  },
                ),
              );
            },
            /*A column that contains the details being displayed */
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*Container that contains the image */
                Container(
                  padding: EdgeInsets.all(15.sp),
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    /*PUTTING BOX SHADOW ON THE CONTAINER */
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        itemName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: farmSwapTitlegreen,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        "$itemquantity item",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 150.sp,
                      child: Text(
                        finalbidTime,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.sp),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return GetConsumerBidDetails(
                              imgurl: imageUrl,
                              itemname: itemName,
                              itemquan: itemquantity,
                              itemVal: itemValue,
                              itemCond: itemCondition,
                              itemDisc: itemDisc,
                              bartered: isBartered,
                              bidTime: finalbidTime,
                              listId: listingId,
                              listName: listingName,
                              listStat: listingStatus,
                              listPrice: listingPrice,
                              listQuan: listingQuan,
                              farmerid: farmerId,
                              farmername: farmerName,
                              farmerlname: farmerLname,
                              farmeruname: farmerUname,
                              farmerbarangay: farmerBarangay,
                              farmermunicipal: farmerMunisipyo,
                              selected: selected,
                              completed: isCompleted,
                              isConsCompleted: isConsComplete,
                              isBarteredOut: isBarteredOut,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      FontAwesomeIcons.eye,
                      color: farmSwapTitlegreen,
                    ),
                    iconSize: 25.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
