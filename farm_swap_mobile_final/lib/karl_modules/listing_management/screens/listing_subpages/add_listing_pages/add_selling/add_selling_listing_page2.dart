// ignore_for_file: use_build_context_synchronously

import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/provider/sell_listing_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/colors.dart';
import '../../../../../../common/upload_image_functions.dart';
import '../../../../../dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import '../../../../../user_signup/widgets/custom_image_picker.dart';
import '../../../../widgets/listing_management_bottomnav.dart';

class AddActualSellingListingDetails2 extends StatefulWidget {
  const AddActualSellingListingDetails2({super.key});

  @override
  State<AddActualSellingListingDetails2> createState() =>
      _AddActualSellingListingDetails2State();
}

class _AddActualSellingListingDetails2State
    extends State<AddActualSellingListingDetails2> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  /*Instance of the class that picks and saves picture */
  UploadImageFunctions upload = UploadImageFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: greenNormal,
        /*Aappbar background imag design */
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
        /*So mao nani ang condition nga mag depende sa value nga e hatag sa atong provider ang mo display
        nga label sa appbar */
        title: const Text("Add Sell Listing"),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      /*The drawer class */
      drawer: DashBoardDrawer(),
      body: Column(
        children: [
          /*Expanded for the contents */
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned.fill(
                    top: -400.sp,
                    bottom: 0.sp,
                    child: SvgPicture.asset(
                      "assets/karl_assets/icons/Pattern.svg",
                      height: 200,
                      width: 400,
                    ),
                  ),
                  /*This is the actual contents of the page are being displayed */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          poppinsText(
                            "Upload Listing Picture",
                            Colors.black,
                            20.sp,
                            FontWeight.bold,
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          /*For the pick image in gallery */
                          GestureDetector(
                            onTap: () async {
                              /*Calling the function that will select an image from gallery and assign its download url to a variable */
                              String? url =
                                  await upload.uploadImageToFirebaseGallery();
                              /*Putting the value of url inside our provider */
                              Provider.of<SellListingDetailsProvider>(context,
                                      listen: false)
                                  .setPhotoUrl(url.toString());
                              Navigator.of(context).pushNamed(
                                  RouteManager.addselllistingdetails3);
                            },
                            child: CustomPicturePicker(
                              height: MediaQuery.of(context).size.height,
                              width: 200.sp,
                              imagePath:
                                  "assets/karl_assets/images/Gallery.svg",
                              title: "From Gallery",
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          /*This is for picking image in the camera */
                          GestureDetector(
                            onTap: () async {
                              /*Calling the function that will select an image from camera and assign its download url to a variable */
                              String? url =
                                  await upload.uploadImageToFirebaseCamera();
                              /*Putting the value of url inside our provider */
                              Provider.of<SellListingDetailsProvider>(context,
                                      listen: false)
                                  .setPhotoUrl(url.toString());
                              Navigator.of(context).pushNamed(
                                  RouteManager.addselllistingdetails3);
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
                    ],
                  ),
                ],
              ),
            ),
          ),
          /*Expanded for the bottom navbar */
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: greenNormal,
                image: const DecorationImage(
                  image:
                      AssetImage("assets/karl_assets/images/appbarpattern.png"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: farmSwapTitlegreen),
              ),
              child: const ListingManagementBottomNav(),
            ),
          ),
        ],
      ),
    );
  }
}
