import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_barter_resolutions/get_c_barter_penalties.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_barter_resolutions/get_consumer_dispute_barter_resol.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_sell_resolutions/get_c_sell_penalties.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/screen/consumer_resolutions/c_sell_resolutions/get_consumer_dispute_sell_resol.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/navbar/consumer_dispute_page_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsumerBarterResolutions extends StatefulWidget {
  const ConsumerBarterResolutions({super.key});

  @override
  State<ConsumerBarterResolutions> createState() => _ConsumerBarterResolutionsState();
}

class _ConsumerBarterResolutionsState extends State<ConsumerBarterResolutions> {
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
            poppinsText(
              "Resolutions",
              Colors.white,
              20.sp,
              FontWeight.bold,
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
            Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: Container(
                height: 375.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  //Box shadow of container
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'My Barter Resolutions',
                        style: Poppins.farmerName.copyWith(
                          color: greenDark,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 320.h,
                        width: MediaQuery.of(context).size.width,
                        child: const GetBarterConsumerResolution(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: Container(
                height: 375.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  //Box shadow of container
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'My Sale Resolutions',
                        style: Poppins.farmerName.copyWith(
                          color: greenDark,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 320.h,
                        width: MediaQuery.of(context).size.width,
                        child: const GetConsumerSellResolution(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*For the penalties received*/
            Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: Container(
                height: 375.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  //Box shadow of container
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'My Barter Penalties',
                        style: Poppins.farmerName.copyWith(
                          color: greenDark,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 320.h,
                        width: MediaQuery.of(context).size.width,
                        child: const CBarterPenalties(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0.sp),
              child: Container(
                height: 375.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  //Box shadow of container
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'My Purchase Penalties',
                        style: Poppins.farmerName.copyWith(
                          color: greenDark,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 320.h,
                        width: MediaQuery.of(context).size.width,
                        child: const GetCSellPenalties(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        child: const ConsumerDisputePageNavBar(),
      ),
    );
  }
}
