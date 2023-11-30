import 'package:farm_swap_mobile_final/clare_modules/pages/consumer_cart/screens/consumer_cart.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/barter_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/best_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/sell_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_bottom_navbar.dart';
import 'package:farm_swap_mobile_final/provider/dashboard_type_provider.dart';
import 'package:farm_swap_mobile_final/provider/login_usertype_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

/*Mao ni ang active dashboard, ma display diri ang mga listings */

class ActiveDashboard extends StatelessWidget {
  ActiveDashboard({super.key});

/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    //accessing the value of our provider that provides what dashboard type to display
    String dashboardType =
        Provider.of<DashboardTypeProvider>(context, listen: false)
            .getDashboardType;
    String userType =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;

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
              onPressed: () {
                if (userType == "CONSUMER") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const ConsumerCartOrders();
                      },
                    ),
                  );
                }
              },
              icon: const Icon(FontAwesomeIcons.cartShopping),
              iconSize: 30.sp,
            ),
          ),
        ],
      ),
      /*End of appbar */
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      /*Start of body */
      body: Column(
        children: [
          /*Expanded that will contain the flashing of best deals */
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /* borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),*/
                    /*PUTTING BOX SHADOW ON THE CONTAINER */
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 2,
                        offset: const Offset(1, 5),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 500.h,
                  child: (dashboardType == "SALE")
                      ? const GetAllSellPromotions()
                      : const GetAllBarterPromotions(),
                ),
              )),
          /*Expanded that will contain the products in the middle*/
          Expanded(
            flex: 20,
            child: Container(
              color: Colors.white,
              /*Condition that will switch the display of the child depending upon the value that we 
                get from our dashboard type provider */
              child: (dashboardType == "SALE")
                  ? const SellDashboard()
                  : (dashboardType == "BEST")
                      ? const BestDealsDashboard()
                      : const BarterDashboard(),
            ),
          ),
          /*Expanded(
            flex: 2,
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
              child: const DashboardButtomNavBar(),
            ),
          ),*/
        ],
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
        child: const DashboardButtomNavBar(),
      ),
    );
  }
}
