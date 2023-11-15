import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/common/upload_image_functions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/custom_image_picker.dart';
import 'package:farm_swap_mobile_final/provider/bartering_item_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadBarterItemPicture extends StatefulWidget {
  const UploadBarterItemPicture({super.key});

  @override
  State<UploadBarterItemPicture> createState() => _UploadBarterItemPictureState();
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
    return Scaffold(
      key: _scaffoldKey,
      /*Start of appbar */
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Dashboard"),
            SizedBox(
              width: 80.w,
            ),
            /*Shoppping cart button */
            IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.cartShopping),
              iconSize: 30.sp,
            ),
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
                          String? picUrl = await upload.uploadImageToFirebaseGallery();
                          // ignore: use_build_context_synchronously
                          Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                              .setItemUrl(picUrl.toString());
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed(RouteManager.entertobarteritem3);
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
                          String? picUrl = await upload.uploadImageToFirebaseCamera();
                          // ignore: use_build_context_synchronously
                          Provider.of<BartertingItemDetailsProvider>(context).setItemUrl(
                            picUrl.toString(),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed(RouteManager.entertobarteritem3);
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
    );
  }
}
