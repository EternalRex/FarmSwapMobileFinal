import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/listing_management_bottomnav.dart';

class BarterAllListingDetails extends StatefulWidget {
  const BarterAllListingDetails({super.key});

  @override
  State<BarterAllListingDetails> createState() => _BarterAllListingDetailsState();
}

class _BarterAllListingDetailsState extends State<BarterAllListingDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      /*App bar og iyang style */
      appBar: AppBar(
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
        /*So mao nani ang condition nga mag depende sa value nga e hatag sa atong provider ang mo display
        nga label sa appbar */
        title: const Text("Barter Listing Details"),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: DashBoardDrawer(),
      /*Body og ang iyang style */
      body: Column(
        children: [
          /*Expanded for the contents */
          Expanded(
            flex: 8,
            /*Ang content ani na container kay mag agad sa value ni provider sama sa heading*/
            child: Container(
              color: Colors.white,
            ),
          ),
          /*Expanded for the bottom navbar */
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: greenNormal,
                image: const DecorationImage(
                  image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
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
