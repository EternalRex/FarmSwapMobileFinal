import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/save_barter_bid.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_sell_promotions.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/provider/bartering_item_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EnterToBarterItem3 extends StatefulWidget {
  const EnterToBarterItem3({super.key});

  @override
  State<EnterToBarterItem3> createState() => _EnterToBarterItem3State();
}

class _EnterToBarterItem3State extends State<EnterToBarterItem3> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  SaveBarterBid bid = SaveBarterBid();

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
                padding: EdgeInsets.all(10.sp),
                child: SingleChildScrollView(
                  child: Column(
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
                        child: Consumer<BartertingItemDetailsProvider>(
                          builder: (context, value, child) {
                            return Image.network(value.getItemUrl);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      GestureDetector(
                        onTap: () {
                          /*Actual saving of data*/
                          bid.saveBarterBid(
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerUname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerId,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerFname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerLname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerBrgy,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getFarmerMunisipyo,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerId,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerFname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerLname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerUname,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerBaranggay,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getConsumerMunisipyo,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getListingId,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getListingName,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getListDisc,
                            double.parse(
                                Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                    .getListingPrice),
                            double.parse(
                                Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                    .getListingQuan),
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getListingStatus,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemName,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemDisc,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemCondition,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemQuantity,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemUrl,
                            Provider.of<BartertingItemDetailsProvider>(context, listen: false)
                                .getItemValue,
                            false,
                          );
                          showDoneMessage();
                        },
                        child: const FarmSwapGreenBtn(text: "Bid"),
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

  /*functions that will output a message that the barter bid has already been placed*/
  void showDoneMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 17.sp, FontWeight.bold),
          content: poppinsText(
            "Your bid is placed successfull, wait for the farmers respond, you might be the lucky chosen bidder!",
            Colors.black,
            13.sp,
            FontWeight.normal,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.activeDashboard);
              },
              child: poppinsText("Finish", farmSwapTitlegreen, 17.sp, FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
