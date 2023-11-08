import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/barter_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/best_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/sell_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/other%20widgets/dashboard_bottom_navbar.dart';
import 'package:farm_swap_mobile_final/provider/dashboard_type_provider.dart';
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
        Provider.of<DashboardTypeProvider>(context, listen: false).getDashboardType;
    print(dashboardType);

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
        /*Start of body */
        body: Column(
          children: [
            /*Expanded that will contain the flashing of best deals */
            Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.green,
                  child: const GetAllBarterPromotions(),
                )),
            /*Expanded that will contain the products in the middle*/
            Expanded(
              flex: 13,
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
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: greenNormal,
                  image: const DecorationImage(
                    image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: farmSwapTitlegreen),
                ),
                child: const DashboardButtomNavBar(),
              ),
            ),
          ],
        ));
  }
}
