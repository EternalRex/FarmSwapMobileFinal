import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_list_of_bids.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/selected_bid_get.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/barter_bids_navbar.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedBids extends StatefulWidget {
  const SelectedBids({
    super.key,
    required this.farmerId,
    required this.listingId,
    required this.farmerUname,
    required this.listingUrl,
  });

  final String farmerId;
  final String listingId;
  final String farmerUname;
  final String listingUrl;

  @override
  State<SelectedBids> createState() => _SelectedBidsState();
}

class _SelectedBidsState extends State<SelectedBids> {
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
              "Selected Bids",
              style: TextStyle(fontSize: 25.sp),
            ),
            SizedBox(
              width: 20.w,
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
      ),
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 750.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GetSelectedBid(
                farmerId: widget.farmerId,
                farmerUname: widget.farmerUname,
                listingId: widget.listingId,
                listingUrl: widget.listingUrl,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          listUrl: widget.listingUrl,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FarmerListOfBids(
                farmerUname: widget.farmerUname,
                farmerId: widget.farmerId,
                listingId: widget.listingId,
                listingUrl: widget.listingUrl,
              ),
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
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
