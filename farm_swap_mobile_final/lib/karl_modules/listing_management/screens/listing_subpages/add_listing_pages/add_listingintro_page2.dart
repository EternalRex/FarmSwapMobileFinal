import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_barter/add_barter_listing_page.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_selling/add_selling_listing_page.dart';
import 'package:farm_swap_mobile_final/provider/listing_addcategory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/colors.dart';
import '../../../../dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import '../../../widgets/listing_management_bottomnav.dart';

class AddListingPageInputDetails extends StatefulWidget {
  const AddListingPageInputDetails({super.key});

  @override
  State<AddListingPageInputDetails> createState() => _AddListingPageInputDetailsState();
}

class _AddListingPageInputDetailsState extends State<AddListingPageInputDetails> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    String listingType =
        Provider.of<AddListingCategoryProvider>(context, listen: false).getListingCategory;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: farmSwapTitlegreen,
        /*So mao nani ang condition nga mag depende sa value nga e hatag sa atong provider ang mo display
        nga label sa appbar */
        title: (listingType == "BARTER")
            ? const Text("Add Barter Listing")
            : const Text("Add Sell Listing"),
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
            /*Ang content ani na container kay mag agad sa value ni provider sama sa heading*/
            child: Container(
              color: Colors.white,
              child: (listingType == "BARTER")
                  ? const AddActualBarterListingDetils()
                  : const AddActualSellingListingDetails(),
            ),
          ),
          /*Expanded for the bottom navbar */
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: farmSwapTitlegreen,
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
