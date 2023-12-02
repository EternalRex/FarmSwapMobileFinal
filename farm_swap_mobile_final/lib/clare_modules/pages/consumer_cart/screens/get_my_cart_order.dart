// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/database/farmer_notif_query.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/farmer_notif_bid/provider/farmer_notif_provider.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/my_orders_screens/my_orders.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/checkout_order.dart';

class GetMyCartOrders extends StatefulWidget {
  const GetMyCartOrders({
    super.key,
  });

  @override
  State<GetMyCartOrders> createState() => _GetMyCartOrdersState();
}

class _GetMyCartOrdersState extends State<GetMyCartOrders> {
  // List to track checked state for each item
  List<bool> isCheckedList = [];

  // Map to group data by farmer name
  Map<String, List<DocumentSnapshot>> groupedData = {};

  // List to track checked state for each item of farmer
  Map<String, List<bool>> isCheckedListByFarmer = {};

// List to track checked state for each item prices
  Map<String, List<double>> pricesByFarmer = {};

  //create an instance for saving a cart order
  SaveConsumerCartOrder checkout = SaveConsumerCartOrder();

  //creating an instance for getting the consumer balance
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();

  //instance of farmer notif query
  FarmerNotificationQuerry farmernotif = FarmerNotificationQuerry();
  String senderId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collectionGroup("sellcart")
                .where('consumerId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .orderBy('purchaseDate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  /**If data is present, it calls a function groupDataByFarmer 
                   * to organize the data into a map where it's grouped by the farmer's name. */
                  groupedData = groupDataByFarmer(snapshot.data!.docs);

                  /**to display a list of farmers. For each farmer, it displays their 
                   * name and a nested ListView.builder for the individual items purchased. */
                  return ListView.builder(
                    itemCount: groupedData.length,
                    itemBuilder: (BuildContext context, int index) {
                      String farmerUname = groupedData.keys.elementAt(index);
                      List<DocumentSnapshot> farmerData =
                          groupedData[farmerUname]!;

                      if (!isCheckedListByFarmer.containsKey(farmerUname)) {
                        isCheckedListByFarmer[farmerUname] =
                            List<bool>.filled(farmerData.length, false);
                      }

                      /**It initializes the isCheckedListByFarmer and pricesByFarmer maps for each farmer. 
                      * These are used to track the state of checkboxes and prices for each item */
                      if (!pricesByFarmer.containsKey(farmerUname)) {
                        pricesByFarmer[farmerUname] = farmerData
                            .map<double>(
                                (doc) => doc['purchaseTotalPrice'] as double)
                            .toList();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Farmer: $farmerUname',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: farmerData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return accessDocumentContents(
                                farmerData[index],
                                farmerUname,
                                index,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Text("No Data Found");
              } else {
                return const Text("Loading...");
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //this will display the total selected index
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Text(
                'Total : ${calculateTotal()}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: poppins,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                print("isCheckedList: $isCheckedList");

                //if the checbox is not checked it will show this dialog
                if (!anyFarmerSelected()) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Warning!'),
                        content: const Text('Please check at least one item.'),
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
                }
                //it show this dialog if atleast one checkbox is checked
                else {
                  // Check if the consumer's balance is sufficient
                  double totalPurchaseAmount =
                      calculateTotal(); // Assuming you have a method for this

                  // Retrieve the consumer's balance
                  double consumerBalance =
                      await consumerDetails.getWalletBalance();
                  print("Consumers bal: $consumerBalance");

                  //if atleast one is checked then this will check if wallet balance is enough
                  if (consumerBalance >= totalPurchaseAmount) {
                    Map<String, List<int>> selectedIndicesByFarmer = {};

                    isCheckedListByFarmer.forEach((farmerName, farmerList) {
                      List<int> selectedIndices = [];

                      for (int i = 0; i < farmerList.length; i++) {
                        if (farmerList[i]) {
                          selectedIndices.add(i);
                        }
                      }

                      if (selectedIndices.isNotEmpty) {
                        selectedIndicesByFarmer[farmerName] = selectedIndices;
                      }
                    });

                    // Check if all selected items have the same farmer name
                    if (selectedIndicesByFarmer.keys.length == 1) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Checking Out!'),
                            content: const Text(
                                "Are you sure you want to proceed check out? \nNote: This will place the order directly."),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // Iterate over selected indices and save the corresponding orders
                                  selectedIndicesByFarmer
                                      .forEach((farmerName, indices) {
                                    for (int index in indices) {
                                      // Access the data using the index
                                      DocumentSnapshot document =
                                          groupedData[farmerName]![index];
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;

                                      String cId = data["consumerId"];
                                      String cFName = data["consumerName"];
                                      String cLname = data["consumerLname"];
                                      String cLUname = data["consumerUname"];
                                      String cBarangay =
                                          data["consumerBarangay"];
                                      String cMunicipal =
                                          data["consumerMunicipal"];

                                      String fId = data["farmerId"];
                                      String fName = data["farmerName"];
                                      String fLname = data["farmerLname"];
                                      String fUname = data["farmerUname"];
                                      String fBarangay = data["farmerBarangay"];
                                      String fMunicipal =
                                          data["farmerMunicipal"];
                                      bool isConsumerComplete =
                                          data["consumerCompleted"];

                                      String listingid = data["listingId"];
                                      String listingName = data["listingName"];
                                      String listingPrice =
                                          data["listingPrice"];
                                      String listingQuan = data["listingQuan"];
                                      String listingstatus =
                                          data["listingStatus"];
                                      String imageUrl = data["imgurl"];

                                      double purchasekilograms =
                                          (data["purchaseQuan"] as num)
                                              .toDouble();
                                      double purchasePrice =
                                          (data["purchaseTotalPrice"] as num)
                                              .toDouble();
                                      bool purchaseIsComplete =
                                          data["purchaseIsComplete"];
                                      bool confirmed = data["confirmed"];
                                      bool selected = data["selected"];
                                      bool declined = data["declined"];

                                      /*NOTIFICATION FOR ACCEPT BID*/
                                      farmernotif.sendNotification(
                                        senderId,
                                        fId,
                                        "You have an order from",
                                        cFName,
                                        cLname,
                                        DateTime.now(),
                                        "BUY_ORDER",
                                      );
                                      Provider.of<FarmerNotificationProvider>(
                                              context,
                                              listen: false)
                                          .setIncrement(fId);

                                      //this will save data in to the order database
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
                                    }
                                  });

                                  //this will show if the order is success
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Success'),
                                        content: const Text(
                                            'You successfully placed an order.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              // Navigate to orders
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const MyOrders();
                                                  },
                                                ),
                                              );
                                            },
                                            child: const Text('Go to Orders'),
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
                      // Show a warning if items selected have different farmer names
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Warning!'),
                            content: const Text(
                                'Please select items from the same farmer for checkout.'),
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
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Insufficient Balance'),
                          content: const Text(
                              'Your wallet balance is not enough to complete the purchase.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RouteManager.consumerwallet);
                              },
                              child: const Text('Go to Wallet'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              icon: const Icon(FontAwesomeIcons.listCheck),
              label: const Text("Checkout"),
            ),
            SizedBox(
              width: 5.sp,
            ),
          ],
        ),
      ],
    );
  }

  // Check if any checkbox is checked for each farmer
  bool anyFarmerSelected() {
    for (var farmerList in isCheckedListByFarmer.values) {
      if (farmerList.contains(true)) {
        return true;
      }
    }
    return false;
  }

  //this will calculate the selected index of a farmer
  double calculateTotal() {
    double total = 0.0;
    Map<String, List<int>> selectedIndices = {};

    isCheckedListByFarmer.forEach((name, farmerList) {
      List<int> indices = [];

      for (int i = 0; i < farmerList.length; i++) {
        if (farmerList[i]) {
          double price = pricesByFarmer[name]![i];
          total += price;
          indices.add(i);
        }
      }

      if (indices.isNotEmpty) {
        selectedIndices[name] = indices;
      }
    });

    print("Total: $total");
    print("Selected Indices: $selectedIndices");

    return total;
  }

  // Function to group data by its farmer name
  Map<String, List<DocumentSnapshot>> groupDataByFarmer(
      List<DocumentSnapshot> data) {
    Map<String, List<DocumentSnapshot>> groupedData = {};

    for (DocumentSnapshot document in data) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String farmerUname = data["farmerUname"];

      if (!groupedData.containsKey(farmerUname)) {
        groupedData[farmerUname] = [];
      }

      groupedData[farmerUname]!.add(document);
    }

    return groupedData;
  }

//this will display the listview datas
  Widget accessDocumentContents(
      DocumentSnapshot document, String farmerUname, int index) {
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
    Timestamp completedTime = data["confirmedDate"];
    DateTime newCompletedTime = confirmedTime.toDate();
    String finalCompletedTime =
        DateFormat('yyyy-MM-dd').format(newCompletedTime);

    RemoveConsumerCartOrder removecart = RemoveConsumerCartOrder();

    String kilogramString = "Kilograms";
    double kilogramdDouble = 1;
    String totalString = "Total Price";
    double totalDouble = 1;

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
          height: 100.h,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isCheckedListByFarmer[farmerUname]![index] =
                    !isCheckedListByFarmer[farmerUname]![index];
              });
            },
            /*A column that contains the details being displayed */
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isCheckedListByFarmer[farmerUname]![index],
                      onChanged: (value) {
                        setState(() {
                          isCheckedListByFarmer[farmerUname]![index] = value!;
                        });
                      },
                    ),

                    /*Container that contains the image */
                    Container(
                      padding: EdgeInsets.all(15.sp),
                      height: 90.h,
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
                        FontAwesomeIcons.trash,
                        color: Colors.redAccent,
                      ),
                      iconSize: 20.sp,
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
}
