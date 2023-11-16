import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/selected_bid_get.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/unselected_bid_get.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/barter_bids_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnselectedBarterBids extends StatefulWidget {
  const UnselectedBarterBids({
    super.key,
    required this.farmerUname,
    required this.farmerId,
    required this.listingId,
  });

  final String farmerUname;
  final String farmerId;
  final String listingId;

  @override
  State<UnselectedBarterBids> createState() => _UnselectedBarterBidsState();
}

class _UnselectedBarterBidsState extends State<UnselectedBarterBids> {
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
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Unselected Bids",
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(
              width: 35.w,
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
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 525.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GetUnselectedBid(
                farmerId: widget.farmerId,
                farmerUname: widget.farmerUname,
                listingId: widget.listingId,
              ),
            ),
            Container(
              height: 55.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: greenNormal,
                image: const DecorationImage(
                  image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: farmSwapTitlegreen),
              ),
              child: BarterBidsNavBar(
                farmerId: widget.farmerId,
                farmerUname: widget.farmerUname,
                listingId: widget.listingId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
