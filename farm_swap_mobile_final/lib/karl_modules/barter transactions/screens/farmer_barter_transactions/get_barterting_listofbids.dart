import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GetBarteringListOfBids extends StatefulWidget {
  const GetBarteringListOfBids({
    super.key,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerListingId,
    required this.listingUrl,
  });
  final String farmerUname;
  final String farmerId;
  final String farmerListingId;
  final String listingUrl;

  @override
  State<GetBarteringListOfBids> createState() => _GetBarteringListOfBidsState();
}

class _GetBarteringListOfBidsState extends State<GetBarteringListOfBids> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collectionGroup('barterbids')
          .where('listingId', isEqualTo: widget.farmerListingId)
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
    bool isSelected = data["selected"];
    bool isCompleted = data["completed"];

    /*Listing data*/
    String listingId = data["listingId"];
    String listingName = data["listingName"];
    String listingQuan = data["listingQuantity"].toString();
    String listingPrice = data["listingPrice"].toString();
    String listStatus = data["listingStatus"];

    /*Consumer data*/
    String consumername = data["consumerName"];
    String consumerid = data["consumerId"];
    String consumerLname = data["consumerLName"];
    String consumeruname = data["consumerUname"];
    String consumerBarangay = data["consumerBaranggay"];
    String consumerMunicipality = data["consumerMuniciplaity"];

/*Bid time conversion*/
    Timestamp bidtime = data["itemBidTime"];
    DateTime newbidTime = bidtime.toDate();
    String finalbidTime = DateFormat('yyyy-MM-dd').format(newbidTime);

    if ((listingStatus == "ACTIVE" || listingStatus == "REACTIVATED") &&
        (isBartered == false && isSelected == false)) {
      print(isBartered.toString());
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
                  builder: (context) => FarmerListOfBidsDetils(
                    imgurl: imageUrl,
                    itemname: itemName,
                    itemquan: itemquantity,
                    itemVal: itemValue,
                    itemCond: itemCondition,
                    itemDisc: itemDisc,
                    bidTime: finalbidTime,
                    listId: listingId,
                    listName: listingName,
                    listStat: listStatus,
                    listPrice: listingPrice,
                    listQuan: listingQuan,
                    consname: consumername,
                    consid: consumerid,
                    conslname: consumerLname,
                    consuname: consumeruname,
                    consbarangay: consumerBarangay,
                    consmunicipal: consumerMunicipality,
                    selected: isSelected,
                    bartered: isBartered,
                    completed: isCompleted,
                    listUrl: widget.listingUrl,
                  ),
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
                          builder: (context) => FarmerListOfBidsDetils(
                            imgurl: imageUrl,
                            itemname: itemName,
                            itemquan: itemquantity,
                            itemVal: itemValue,
                            itemCond: itemCondition,
                            itemDisc: itemDisc,
                            bidTime: finalbidTime,
                            listId: listingId,
                            listName: listingName,
                            listStat: listStatus,
                            listPrice: listingPrice,
                            listQuan: listingQuan,
                            consname: consumername,
                            consid: consumerid,
                            conslname: consumerLname,
                            consuname: consumeruname,
                            consbarangay: consumerBarangay,
                            consmunicipal: consumerMunicipality,
                            selected: isSelected,
                            bartered: isBartered,
                            completed: isCompleted,
                            listUrl: widget.listingUrl,
                          ),
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
