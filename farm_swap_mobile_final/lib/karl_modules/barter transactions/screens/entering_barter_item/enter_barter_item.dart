import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/common/upload_image_functions.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/entering_barter_item/enter_barter_item2.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/barter_txt_field.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/provider/bartering_item_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EnterToBarterItem extends StatefulWidget {
  const EnterToBarterItem({
    super.key,
    required this.listingIdNeed,
    required this.listingNameNeed,
    required this.listingDiscNeed,
    required this.listingEquivalentPriceNeed,
    required this.listingQuantityNeed,
    required this.listingStatusNeed,
    required this.farmerFNameNeed,
    required this.farmerUnameNeed,
    required this.farmerLnameNeed,
    required this.farmerBaranggayNeed,
    required this.farmerMunicaplityNeed,
    required this.farmerId,
  });

  /*The data we needed from the lisiting */
  final String listingIdNeed;
  final String listingNameNeed;
  final String listingDiscNeed;
  final String listingEquivalentPriceNeed;
  final String listingQuantityNeed;
  final String listingStatusNeed;

/*The data that we need from farmer*/
  final String farmerFNameNeed;
  final String farmerLnameNeed;
  final String farmerUnameNeed;
  final String farmerBaranggayNeed;
  final String farmerMunicaplityNeed;
  final String farmerId;

  @override
  State<EnterToBarterItem> createState() => _EnterToBarterItemState();
}

class _EnterToBarterItemState extends State<EnterToBarterItem> {
/*Data that wee need from consumer details */
  String cId = "";
  String cFname = "";
  String cLastName = "";
  String cUname = "";
  String cBarangay = "";
  String cMunicipality = "";

/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

/*Text Editing Controllers */
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDiscController = TextEditingController();
  TextEditingController? itemValueController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController itemConditionController = TextEditingController();

  /*Labels*/
  Text itemNameLabel = poppinsText(
    "Enter item name",
    Colors.black45,
    15.sp,
    FontWeight.normal,
  );
  Text itemDiscLabel = poppinsText(
    "Enter item description",
    Colors.black45,
    15.sp,
    FontWeight.normal,
  );
  Text itemValueLabel = poppinsText(
    "Enter item value (optional)",
    Colors.black45,
    15.sp,
    FontWeight.normal,
  );
  Text itemQuantityLabel = poppinsText(
    "Enter item quantity",
    Colors.black45,
    15.sp,
    FontWeight.normal,
  );
  Text itemConditionLabel = poppinsText(
    "Enter item condition",
    Colors.black45,
    15.sp,
    FontWeight.normal,
  );

  /*Other classes used here*/
  UploadImageFunctions uploadImage = UploadImageFunctions();
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();

/*Initializing our functions so that they will generate value before the main widget method is run */
  @override
  void initState() {
    super.initState();
    getConsumerId();
    getConsumerFname();
    getConsumerLastName();
    getConsumerUname();
    getConsumerBaranggay();
    getConsumerMunicipality();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemDiscController.dispose();
    itemValueController!.dispose();
    itemQuantityController.dispose();
    itemConditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Dashboard"),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: greenNormal,
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                  "assets/karl_assets/images/appbarpattern.png"),
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
            /*Expanded for the advertisment */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90.h,
              decoration: BoxDecoration(
                color: Colors.white,
                /*PUTTING BOX SHADOW ON THE CONTAINER */
                boxShadow: [
                  BoxShadow(
                    color: shadow,
                    blurRadius: 2,
                    offset: const Offset(1, 5),
                  ),
                ],
              ),
              child: const GetAllBarterPromotions(),
            ),
            /*Expanded for the main content*/
            Container(
              height: 390.h,
              decoration: const BoxDecoration(
                color: Colors.white38,
              ),
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /*item Name */
                      BarterTextField(
                        controller: itemNameController,
                        label: itemNameLabel,
                        input: TextInputType.text,
                        prefixIcon: Icon(
                          FontAwesomeIcons.list,
                          color: farmSwapSmoothGreen,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      /*item  Discription*/
                      BarterTextField(
                        controller: itemDiscController,
                        label: itemDiscLabel,
                        input: TextInputType.text,
                        prefixIcon: Icon(
                          FontAwesomeIcons.pencil,
                          color: farmSwapSmoothGreen,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      /*item Condition */
                      BarterTextField(
                        controller: itemConditionController,
                        label: itemConditionLabel,
                        input: TextInputType.text,
                        prefixIcon: Icon(
                          FontAwesomeIcons.listCheck,
                          color: farmSwapSmoothGreen,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      /* item value*/
                      BarterTextField(
                        controller: itemValueController!,
                        label: itemValueLabel,
                        input: TextInputType.number,
                        prefixIcon: Icon(
                          FontAwesomeIcons.tags,
                          color: farmSwapSmoothGreen,
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      /*item quantity */
                      BarterTextField(
                        controller: itemQuantityController,
                        label: itemQuantityLabel,
                        input: TextInputType.number,
                        prefixIcon: Icon(
                          FontAwesomeIcons.weightHanging,
                          color: farmSwapSmoothGreen,
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextButton(
                        onPressed: () {
                          /*Item Details */
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemName(itemNameController.text);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemDisc(itemDiscController.text);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemCondition(itemConditionController.text);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemQuantity(
                                  double.parse(itemQuantityController.text));
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setitemValue(
                                  double.parse(itemValueController!.text));
                          /*Listing Details*/
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingName(widget.listingNameNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingDisc(widget.listingDiscNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingId(widget.listingIdNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingPrice(
                                  widget.listingEquivalentPriceNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingQuan(widget.listingQuantityNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setListingStatus(widget.listingStatusNeed);
                          /*Farmer Details*/
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerId(widget.farmerId);
                          print(widget.farmerId);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerFname(widget.farmerFNameNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerLname(widget.farmerLnameNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerUname(widget.farmerUnameNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerBaranggay(widget.farmerBaranggayNeed);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setFarmerMunisipyo(widget.farmerMunicaplityNeed);
                          /*Details we need from consumer*/
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setConsumerId(cId);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setConsumerFname(cFname);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setConsumerLname(cLastName);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setCOnsumerUname(cUname);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setConsumerBaranggay(cBarangay);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setConsumerMunisipyo(cMunicipality);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return UploadBarterItemPicture(
                                itemvalue2:
                                    double.tryParse(itemValueController!.text),
                                listingvalue2: double.tryParse(
                                    widget.listingEquivalentPriceNeed),
                              );
                            },
                          ));
                        },
                        child: poppinsText(
                          "Upload Picture",
                          FarmSwapGreen.darkGreen,
                          15.sp,
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*Expanded for the advertisement */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 90.h,
              decoration: BoxDecoration(
                color: Colors.white,
                /*PUTTING BOX SHADOW ON THE CONTAINER */
                boxShadow: [
                  BoxShadow(
                    color: shadow,
                    blurRadius: 2,
                    offset: const Offset(1, -5),
                  ),
                ],
              ),
              child: const GetAllSellPromotions(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

/*Functions that will  get the consumer data*/
  Future<void> getConsumerId() async {
    String userid = await consumerDetails.getConsumerUserId();
    setState(() {
      cId = userid;
    });
  }

  Future<void> getConsumerFname() async {
    String userFname = await consumerDetails.getConsumerFirstname();
    setState(() {
      cFname = userFname;
    });
  }

  Future<void> getConsumerLastName() async {
    String userLname = await consumerDetails.getConsumerLastName();
    setState(() {
      cLastName = userLname;
    });
  }

  Future<void> getConsumerUname() async {
    String userUname = await consumerDetails.getUname();
    setState(() {
      cUname = userUname;
    });
  }

  Future<void> getConsumerBaranggay() async {
    String barangay = await consumerDetails.getBaranggay();
    setState(() {
      cBarangay = barangay;
    });
  }

  Future<void> getConsumerMunicipality() async {
    String municipality = await consumerDetails.getMunicipalityFirstname();
    setState(() {
      cMunicipality = municipality;
    });
  }
}
