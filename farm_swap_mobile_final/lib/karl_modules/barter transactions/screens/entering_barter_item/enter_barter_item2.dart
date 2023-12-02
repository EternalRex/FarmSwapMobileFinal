// ignore_for_file: use_build_context_synchronously

import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/common/upload_image_functions.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/entering_barter_item/enter_barter_item.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/entering_barter_item/enter_barter_item3.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/custom_image_picker.dart';
import 'package:farm_swap_mobile_final/provider/bartering_item_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadBarterItemPicture extends StatefulWidget {
  const UploadBarterItemPicture({
    super.key,
    required this.itemvalue2,
    required this.listingvalue2,
  });
  final double? itemvalue2;
  final double? listingvalue2;

  /*The data we needed from the lisiting */
  final String listingIdNeed = '';
  final String listingNameNeed = '';
  final String listingDiscNeed = '';
  final String listingEquivalentPriceNeed = '';
  final String listingQuantityNeed = ' = ';
  final String listingStatusNeed = '';

/*The data that we need from farmer*/
  final String farmerFNameNeed = '';
  final String farmerLnameNeed = '';
  final String farmerUnameNeed = '';
  final String farmerBaranggayNeed = '';
  final String farmerMunicaplityNeed = '';
  final String farmerId = '';

  @override
  State<UploadBarterItemPicture> createState() =>
      _UploadBarterItemPictureState();
}

class _UploadBarterItemPictureState extends State<UploadBarterItemPicture> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  /*Other class instances used in this class */
  UploadImageFunctions upload = UploadImageFunctions();

  @override
  Widget build(BuildContext context) {
    String farmerId =
        Provider.of<BartertingItemDetailsProvider>(context, listen: false)
            .getFarmerId;
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
                padding: EdgeInsets.only(top: 30.sp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      poppinsText(
                        "Upload Item Picture",
                        Colors.black,
                        20.sp,
                        FontWeight.w500,
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      /*For the pick image in gallery */
                      GestureDetector(
                        onTap: () async {
                          // Start loading state
                          _showLoadingDialog(context);

                          String? picUrl =
                              await upload.uploadImageToFirebaseGallery();

                          // End loading state
                          Navigator.pop(context);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemUrl(picUrl.toString());

                          print(farmerId);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return EnterToBarterItem3(
                                farmerId: farmerId,
                                itemValue: widget.itemvalue2,
                                listingValue: widget.listingvalue2,
                              );
                            },
                          ));
                        },
                        child: CustomPicturePicker(
                          height: MediaQuery.of(context).size.height,
                          width: 200.sp,
                          imagePath: "assets/karl_assets/images/Gallery.svg",
                          title: "From Gallery",
                        ),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      /*This is for picking image in the camera */
                      GestureDetector(
                        onTap: () async {
                          // Start loading state
                          _showLoadingDialog(context);
                          String? picUrl =
                              await upload.uploadImageToFirebaseCamera();
                          // End loading state
                          Navigator.pop(context);
                          Provider.of<BartertingItemDetailsProvider>(context,
                                  listen: false)
                              .setItemUrl(
                            picUrl.toString(),
                          );

                          print(farmerId);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return EnterToBarterItem3(
                                farmerId: farmerId,
                                itemValue: widget.itemvalue2,
                                listingValue: widget.listingvalue2,
                              );
                            },
                          ));
                        },
                        child: CustomPicturePicker(
                          height: MediaQuery.of(context).size.height,
                          width: 200.sp,
                          imagePath: "assets/karl_assets/images/camera.svg",
                          title: "From Camera",
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EnterToBarterItem(
                  listingIdNeed: widget.listingIdNeed,
                  listingNameNeed: widget.listingNameNeed,
                  listingDiscNeed: widget.listingDiscNeed,
                  listingEquivalentPriceNeed: widget.listingEquivalentPriceNeed,
                  listingQuantityNeed: widget.listingQuantityNeed,
                  listingStatusNeed: widget.listingStatusNeed,
                  farmerFNameNeed: widget.farmerFNameNeed,
                  farmerUnameNeed: widget.farmerUnameNeed,
                  farmerLnameNeed: widget.farmerLnameNeed,
                  farmerBaranggayNeed: widget.farmerBaranggayNeed,
                  farmerMunicaplityNeed: widget.farmerMunicaplityNeed,
                  farmerId: widget.farmerId),
            ),
          );
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

  // Display loading dialog
  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
              SizedBox(width: 16),
              Text("Uploading..."),
            ],
          ),
        );
      },
    );
  }
}
