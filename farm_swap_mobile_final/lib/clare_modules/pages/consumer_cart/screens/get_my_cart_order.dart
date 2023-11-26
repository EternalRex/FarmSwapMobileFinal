// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/consumer_cart/screens/my_cart_order_details.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/my_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../database/checkout_order.dart';

class GetMyCartOrders extends StatefulWidget {
  const GetMyCartOrders({
    super.key,
  });

  @override
  State<GetMyCartOrders> createState() => _GetMyCartOrdersState();
}

//for the check box check out
bool isChecked = false;

class _GetMyCartOrdersState extends State<GetMyCartOrders> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collectionGroup("sellcart")
          .where('consumerId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy('purchaseDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Text("Error");
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
          return const Text("No Data Found");
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String cId = data["consumerId"];
    String cFName = data["consumerName"];
    String cLname = data["consumerLname"];
    String cLUname = data["consumerUname"];
    String cBarangay = data["consumerBarangay"];
    String cMunicipal = data["consumerMunicipal"];

    String fId = data["farmerId"];
    String fName = data["farmerName"];
    String fLname = data["farmerLname"];
    String fUname = data["farmerUname"];
    String fBarangay = data["farmerBarangay"];
    String fMunicipal = data["farmerMunicipal"];
    bool isConsumerComplete = data["consumerCompleted"];

    String listingid = data["listingId"];
    String listingName = data["listingName"];
    String listingPrice = data["listingPrice"];
    String listingQuan = data["listingQuan"];
    String listingstatus = data["listingStatus"];
    String imageUrl = data["imgurl"];

    double purchasekilograms = (data["purchaseQuan"] as num).toDouble();
    double purchasePrice = (data["purchaseTotalPrice"] as num).toDouble();
    bool purchaseIsComplete = data["purchaseIsComplete"];
    bool confirmed = data["confirmed"];
    bool selected = data["selected"];
    bool declined = data["declined"];

/*Order time conversion*/
    Timestamp orderTime = data["purchaseDate"];
    DateTime newOrderTime = orderTime.toDate();
    String finalOrderTime = DateFormat('yyyy-MM-dd').format(newOrderTime);

    /*Confirmed time conversion */
    Timestamp confirmedTime = data["confirmedDate"];
    DateTime newConfirmedTime = confirmedTime.toDate();
    String finalConfirmedTime =
        DateFormat('yyyy-MM-dd').format(newConfirmedTime);

    /*Completed time conversion */
    // ignore: unused_local_variable
    Timestamp completedTime = data["confirmedDate"];
    DateTime newCompletedTime = confirmedTime.toDate();
    String finalCompletedTime =
        DateFormat('yyyy-MM-dd').format(newCompletedTime);
    ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
    consumerDetails.getWalletBalance();

    SaveConsumerCartOrder checkout = SaveConsumerCartOrder();
    RemoveConsumerCartOrder removecart = RemoveConsumerCartOrder();

    if ((listingstatus == "ACTIVE" || listingstatus == "REACTIVATED") &&
        (confirmed == false && selected == false && declined == false)) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
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
          height: 150.h,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MyCartDetails(
                      consName: cFName,
                      consLName: cLname,
                      consUname: cLUname,
                      consId: cId,
                      consBarangay: cBarangay,
                      consMunicipality: cMunicipal,
                      farmerName: fName,
                      farmerLName: fLname,
                      farmerUname: fUname,
                      farmerId: fId,
                      farmerBarangay: fBarangay,
                      farmerMunicipality: fMunicipal,
                      listingName: listingName,
                      listingId: listingid,
                      listingPrice: listingPrice,
                      listingQuantity: listingQuan,
                      purchaseQuantity: purchasekilograms,
                      purchaseTotalPrice: purchasePrice,
                      purchaseTime: finalOrderTime,
                      isCompletedPurchase: purchaseIsComplete,
                      isConfirmed: confirmed,
                      confirmedDate: finalConfirmedTime,
                      completeDate: finalCompletedTime,
                      listingStatus: listingstatus,
                      selected: selected,
                      declined: declined,
                      imageUrl: imageUrl,
                      consumerCompleted: isConsumerComplete,
                    );
                  },
                ),
              );
            },
            /*A column that contains the details being displayed */
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),

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
                      width: 5.sp,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150.sp,
                          child: Text(
                            listingName,
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
                            "${purchasekilograms.toString()} kilograms",
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
                            finalOrderTime,
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
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyCartDetails(
                                    consName: cFName,
                                    consLName: cLname,
                                    consUname: cLUname,
                                    consId: cId,
                                    consBarangay: cBarangay,
                                    consMunicipality: cMunicipal,
                                    farmerName: fName,
                                    farmerLName: fLname,
                                    farmerUname: fUname,
                                    farmerId: fId,
                                    farmerBarangay: fBarangay,
                                    farmerMunicipality: fMunicipal,
                                    listingName: listingName,
                                    listingId: listingid,
                                    listingPrice: listingPrice,
                                    listingQuantity: listingQuan,
                                    purchaseQuantity: purchasekilograms,
                                    purchaseTotalPrice: purchasePrice,
                                    purchaseTime: finalOrderTime,
                                    isCompletedPurchase: purchaseIsComplete,
                                    isConfirmed: confirmed,
                                    confirmedDate: finalConfirmedTime,
                                    completeDate: finalCompletedTime,
                                    listingStatus: listingstatus,
                                    selected: selected,
                                    declined: declined,
                                    imageUrl: imageUrl,
                                    consumerCompleted: isConsumerComplete,
                                  );
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            FontAwesomeIcons.eye,
                            color: farmSwapTitlegreen,
                          ),
                          iconSize: 20.sp,
                        ),
                        //this will remove the product in cart
                        IconButton(
                          onPressed: () {
                            removecart.removeCartOrder(
                              cFName,
                              cLname,
                              cLUname,
                              cId,
                              cBarangay,
                              cMunicipal,
                              fName,
                              fLname,
                              fUname,
                              fId,
                              fBarangay,
                              fMunicipal,
                              listingName,
                              listingid,
                              listingPrice,
                              listingQuan,
                              purchasekilograms,
                              purchasePrice,
                              DateTime.now(),
                              false,
                              listingstatus,
                              imageUrl,
                            );
                          },
                          icon: const Icon(
                            FontAwesomeIcons.remove,
                            color: Colors.redAccent,
                          ),
                          iconSize: 20.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isChecked)
                      Text(
                        'Price: $purchasePrice',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'YourFontFamily',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ElevatedButton.icon(
                        onPressed: () async {
                          if (isChecked == false) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Warning!'),
                                  content: const Text('Please check the box.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            double walletBalance =
                                await consumerDetails.getWalletBalance();

                            //check if the wallet balance is enough
                            if (walletBalance >= purchasePrice) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Checking Out!'),
                                    content: const Text(
                                        'Are you sure you want to place this order?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          checkout.saveCartOrder(
                                            cFName,
                                            cLname,
                                            cLUname,
                                            cId,
                                            cBarangay,
                                            cMunicipal,
                                            fName,
                                            fLname,
                                            fUname,
                                            fId,
                                            fBarangay,
                                            fMunicipal,
                                            listingName,
                                            listingid,
                                            listingPrice,
                                            listingQuan,
                                            purchasekilograms,
                                            purchasePrice,
                                            DateTime.now(),
                                            false,
                                            listingstatus,
                                            imageUrl,
                                          );

                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Success'),
                                                content: const Text(
                                                    'You successfully place order.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      //navigate to orders
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return const MyOrders();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                        'Go to Orders'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(walletBalance);
                              showNotWalletBalanceMessage();
                            }
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.listCheck),
                        label: const Text("Checkout")),
                    SizedBox(
                      width: 5.sp,
                    ),
                  ],
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

  /*Function to show that consumer has not enough balance */
  void showNotWalletBalanceMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You do not have enough wallet balance to continue the transaction, Please Cash in",
              Colors.black,
              15.sp,
              FontWeight.normal),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
