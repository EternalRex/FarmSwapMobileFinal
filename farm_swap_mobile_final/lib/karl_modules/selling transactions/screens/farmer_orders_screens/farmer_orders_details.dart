import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/functions/compute_deductible_swapcoins.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/message_consumer/farmer_consumer_actualchat.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/database/update_confirmed.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/functions/compute_sell_deductible_swapcoins.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/screens/farmer_orders_screens/farmer_orders_list.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/widgets/accept_order_btn.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/widgets/deny_order_btn.dart';
import 'package:farm_swap_mobile_final/karl_modules/selling%20transactions/widgets/farmer_selling_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FarmerOrderDetails extends StatefulWidget {
  const FarmerOrderDetails({
    super.key,
    required this.consName,
    required this.consLName,
    required this.consUname,
    required this.consId,
    required this.consBarangay,
    required this.consMunicipality,
    required this.farmerName,
    required this.farmerLName,
    required this.farmerUname,
    required this.farmerId,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.listingName,
    required this.listingId,
    required this.listingPrice,
    required this.listingQuantity,
    required this.purchaseQuantity,
    required this.purchaseTotalPrice,
    required this.purchaseTime,
    required this.isCompletedPurchase,
    required this.isConfirmed,
    required this.confirmedDate,
    required this.completeDate,
    required this.listingStatus,
    required this.selected,
    required this.declined,
    required this.imageUrl,
  });

  /*Consumer Details */
  final String consName;
  final String consLName;
  final String consUname;
  final String consId;
  final String consBarangay;
  final String consMunicipality;

  /*Farmer Details */
  final String farmerName;
  final String farmerLName;
  final String farmerUname;
  final String farmerId;
  final String farmerBarangay;
  final String farmerMunicipality;

  /*listing details*/
  final String listingName;
  final String listingId;
  final String listingPrice;
  final String listingQuantity;

  /*Purchase details*/
  final double purchaseQuantity;
  final double purchaseTotalPrice;
  final String purchaseTime;
  final bool isCompletedPurchase;
  final bool isConfirmed;
  final String confirmedDate;
  final String completeDate;
  final String listingStatus;
  final bool selected;
  final bool declined;
  final String imageUrl;

  @override
  State<FarmerOrderDetails> createState() => _FarmerOrderDetailsState();
}

class _FarmerOrderDetailsState extends State<FarmerOrderDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
/*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  UpdateConfirmedOrder updateStatus = UpdateConfirmedOrder();
  ComputeSellDeductibleSwapCoins deductibleSP = ComputeSellDeductibleSwapCoins();
  UpdateConfirmedOrder updateConfirm = UpdateConfirmedOrder();

  String consumerPhoto = "";
  String farmerPhoto = "";
  double consumerWalletBalance = 0;
  double farmerSwapCoins = 0;
  double swapCoinsToDeduct = 0;
  double farmerWalletBalance = 0;
  String transactionFee = "";
  @override
  void initState() {
    super.initState();
    getConsumerDetails();
    getConsumerWalletBalance();
    getFarmerSwapCoins();
    getFarmerPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Order Details"),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: greenNormal,
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          /*Shoppping cart button */
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.cartShopping),
              iconSize: 30.sp,
            ),
          ),
        ],
      ),
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container that holds the image */
            Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            /*The listing name */
            poppinsText(
              widget.listingName,
              Colors.black,
              30.sp,
              FontWeight.w500,
            ),
            /*Underline */
            Padding(
              padding: EdgeInsets.only(right: 20.sp, left: 20.sp),
              child: Divider(
                color: FarmSwapGreen.darkGreen,
                thickness: 5,
              ),
            ),
            /*Row that holds listing price and quantity */
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText(
                    "${widget.listingPrice} pesos/kg :",
                    Colors.black54,
                    13.sp,
                    FontWeight.normal,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  poppinsText(
                    "${widget.listingQuantity} kilograms",
                    Colors.black54,
                    13.sp,
                    FontWeight.normal,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            /*Stacks that hold the profile photo of farmer and the messenger icon */
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(consumerPhoto),
                  radius: 100.r,
                ),
                Positioned(
                  top: 125.h,
                  left: 125.h,
                  child: IconButton(
                    onPressed: () {
                      (widget.isConfirmed == true && widget.selected == true)
                          ?
                          /*Messaging function*/
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FarmerConsumerActualChat(
                                    farmerId: widget.farmerId,
                                    farmerName: widget.farmerName,
                                    farmerUname: widget.farmerUname,
                                    farmerBarangay: widget.farmerBarangay,
                                    farmerMunicipality: widget.farmerMunicipality,
                                    consumerId: widget.consId,
                                    consumerFname: widget.consName,
                                    consumerLname: widget.consLName,
                                    consumerUname: widget.consUname,
                                    consumerBarangay: widget.consBarangay,
                                    consumerMunicipality: widget.consMunicipality,
                                    listingId: widget.listingId,
                                    listingName: widget.listingName,
                                  );
                                },
                              ),
                            )
                          : showNotConfirmedMessage();
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebookMessenger,
                      size: 40.sp,
                      color: FarmSwapGreen.normalGreen,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            poppinsText(
              "${widget.consName} ${widget.consLName} (${widget.consUname})",
              Colors.black,
              17.sp,
              FontWeight.normal,
            ),
            poppinsText(
              "Located at ${widget.consBarangay} ${widget.consMunicipality} ",
              Colors.black54,
              13.sp,
              FontWeight.normal,
            ),
            poppinsText(
              "Consumer",
              Colors.black54,
              13.sp,
              FontWeight.normal,
            ),
            SizedBox(
              height: 27.h,
            ),
            /*Row for the purchase Quantity and its equivalent value */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Purchase Quantity", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      "${widget.purchaseQuantity} kg",
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
/*Total price and it value */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Total Price", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      "${widget.purchaseTotalPrice} pesos",
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*Date of Order */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Order Date", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      widget.purchaseTime,
                      Colors.black,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*Status of Order */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Order Status", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: (widget.isConfirmed == true && widget.declined == false)
                        ? poppinsText("Confirmed", Colors.green, 15.sp, FontWeight.normal)
                        : (widget.isConfirmed == false && widget.declined == true)
                            ? poppinsText("Declined", Colors.red, 15.sp, FontWeight.normal)
                            : poppinsText("Waiting...", Colors.blue, 15.sp, FontWeight.normal),
                  ),
                ],
              ),
            ),
            /*Row for completed */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: poppinsText("Completed", Colors.black, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: const Icon(Icons.arrow_right),
                  ),
                  SizedBox(
                    width: 150.w,
                    child: poppinsText(
                      widget.isCompletedPurchase.toString(),
                      (widget.isCompletedPurchase == true) ? farmSwapTitlegreen : Colors.red,
                      15.sp,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            /*Row for accept and deny btn */
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      /*Computing the remaining swapcoins of farmer */
                      double finalDeductSp = farmerSwapCoins - swapCoinsToDeduct;
                      /*Computing the remaining wallet balance of consumer */
                      double remainingBalance = consumerWalletBalance - widget.purchaseTotalPrice;
                      /*Computing the new farmer wallet balance adding the purchase price amount */
                      double farmerAddedBalance = farmerWalletBalance + widget.purchaseTotalPrice;
                      /*Computing the remaining listing kilograms*/
                      double remainKilogram =
                          double.parse(widget.listingQuantity) - widget.purchaseQuantity;

                      computeSwapCoinsDeduction();
                      computeTransactionFeePercent();
                      /*If farmer has suffecient swap coins*/
                      if (farmerSwapCoins > swapCoinsToDeduct) {
                        /*Passing the values to the function that saves/update the data */
                        showConfirmedMessage(
                          finalDeductSp,
                          remainingBalance,
                          farmerAddedBalance,
                          remainKilogram,
                        );
                      } else {
                        /*If not enough swap coins */
                        showNotNotEnoughSwapCoins();
                      }
                    },
                    child: const AcceptOrderBtn(text: "Confirm"),
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  GestureDetector(
                    child: const DenyOrderBtn(text: "Decline"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.sp,
        decoration: BoxDecoration(
          color: greenNormal,
          image: const DecorationImage(
            image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: farmSwapTitlegreen),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: const FarmerSellingNavbar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const FarmerOrdersList();
            },
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

/*Get consumer profile photo */
  Future<void> getConsumerDetails() async {
    String consPhoto = await consumerDetails.getConsumerProfilePhotoWithParameter(widget.consId);
    setState(() {
      consumerPhoto = consPhoto;
    });
  }

/*Function that returns a warning message when farmer tries to use the chat option without confirming the order */
  void showNotConfirmedMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
              "You need to confirm the order first so that you can message the consumer!",
              Colors.black,
              15.sp,
              FontWeight.normal),
        );
      },
    );
  }

  /*Function that will get the wallet balance of Consumers */
  Future<void> getConsumerWalletBalance() async {
    double wallet = await consumerDetails.getWalletBalanceWithParameter(widget.consId);
    setState(() {
      consumerWalletBalance = wallet;
    });
  }

  /*Function that will get the swapcoins of farmers */
  Future<void> getFarmerSwapCoins() async {
    double swapCoins = await farmerDetails.getSwapCoins();
    setState(() {
      farmerSwapCoins = swapCoins;
    });
  }

  /*Function that will get the current farmer wallet balance */
  Future<void> getFarmerWalletBalance() async {
    double balance = await farmerDetails.getWalletBalance();
    setState(() {
      farmerWalletBalance = balance;
    });
  }

  /*This function will  calculate the deductible swap coins*/
  void computeSwapCoinsDeduction() {
    double swapCoins = deductibleSP.computeDeductibleSwapCoins(widget.purchaseTotalPrice);
    setState(() {
      swapCoinsToDeduct = swapCoins;
    });
  }

  /*Get the percentage range */
  void computeTransactionFeePercent() {
    String fee = deductibleSP.percentDeduction(widget.purchaseTotalPrice);
    setState(() {
      transactionFee = fee;
    });
  }

/*A confirmation message that has butttons where the actual saving of data is made */
  void showConfirmedMessage(
      double finalDeductSp, remainingConsumerBalance, farmerBalance, remainKilogram) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Information", Colors.blue, 20.sp, FontWeight.bold),
          content: poppinsText(
            "Your will be deducted $swapCoinsToDeduct swap coins for a $transactionFee of the total amount of ${widget.purchaseTotalPrice}",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    /*Update the selected and confirmed field */
                    updateConfirm.updateOrderConfirmed(widget.listingId, widget.consId);
                    /*Update for the remaining swapcoins */
                    updateConfirm.updateFarmerSwapCoins(widget.farmerId, finalDeductSp);
                    /*Updating the consumer wallet balance for his/her remaining balance*/
                    updateConfirm.updateConsumerWalletBalance(
                        widget.consId, remainingConsumerBalance);
                    /*Sending the payed purchase amount to farmers wallet */
                    updateConfirm.updateFarmerWalletBalance(widget.farmerId, farmerBalance);
                    /*Update the remaining balance of the listing kilograms*/
                    updateConfirm.updateRemainingListingQuantity(widget.imageUrl, remainKilogram);
                    /*Saving the transaction to the database */
                    updateConfirm.addSellingTransaction(
                      consumerPhoto,
                      widget.consName,
                      widget.consLName,
                      widget.consUname,
                      widget.consId,
                      widget.consBarangay,
                      widget.consMunicipality,
                      farmerPhoto,
                      widget.farmerName,
                      widget.farmerLName,
                      widget.farmerUname,
                      widget.farmerId,
                      widget.farmerBarangay,
                      widget.farmerMunicipality,
                      widget.listingName,
                      widget.listingId,
                      widget.listingPrice,
                      widget.listingQuantity,
                      widget.imageUrl,
                      widget.purchaseQuantity,
                      widget.purchaseTotalPrice,
                      DateTime.parse(widget.purchaseTime),
                      widget.isConfirmed,
                      DateTime.parse(widget.confirmedDate),
                      widget.listingStatus,
                      widget.selected,
                      widget.purchaseTotalPrice,
                      swapCoinsToDeduct,
                      DateTime.now(),
                    );

                    print("data saved");
                  },
                  child: poppinsText("Continue", farmSwapTitlegreen, 20.sp, FontWeight.normal),
                ),
                TextButton(
                  onPressed: () {},
                  child: poppinsText("Cancel", Colors.red, 20.sp, FontWeight.normal),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /*A function that shows not enough swapcoins*/
  void showNotNotEnoughSwapCoins() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Warning", Colors.red, 20.sp, FontWeight.bold),
          content: poppinsText(
            "Not enough swap coins, please add!",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
        );
      },
    );
  }

  /*Function that gets the farmer photo*/
  Future<void> getFarmerPhoto() async {
    String photo = await farmerDetails.getFarmerUserProfilePhoto();
    setState(() {
      farmerPhoto = photo;
    });
  }
}
