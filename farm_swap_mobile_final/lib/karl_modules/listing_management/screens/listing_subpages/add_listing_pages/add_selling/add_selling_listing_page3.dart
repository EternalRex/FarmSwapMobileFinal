import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/provider/sell_listing_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/colors.dart';
import '../../../../../../common/green_btn.dart';
import '../../../../widgets/listing_management_bottomnav.dart';

class AddActualSellingListingDetails3 extends StatefulWidget {
  const AddActualSellingListingDetails3({super.key});

  @override
  State<AddActualSellingListingDetails3> createState() =>
      _AddActualSellingListingDetails3State();
}

class _AddActualSellingListingDetails3State
    extends State<AddActualSellingListingDetails3> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.sp,
                            ),
                            /*Displaying the uploaded Document*/
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: farmSwapSmoothGreen,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadow,
                                      blurRadius: 2,
                                      offset: const Offset(1, 5),
                                    )
                                  ]),
                              height: 500.sp,
                              width: 250.sp,
                              /*Pull outing the link or url of the image we uploaded from our provider
                              because the provider carries that link */
                              child: Consumer<SellListingDetailsProvider>(
                                builder: (context, value, child) {
                                  return Image.network(value.getPhoto);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20.sp,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteManager.addselllistingdetails4);
                              },
                              child: const FarmSwapGreenBtn(text: "Next"),
                            ),
                          ],
                        ),
                      ],
                    ),
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
