import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_listingintro_page.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/all_listing_page/all_tmainpage_listing_page.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/archived_listing_page.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/promoted_listings/promoted_listings_page.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/listing_management_bottomnav.dart';
import 'package:farm_swap_mobile_final/provider/listing_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/*So mao ni siya ang class nga mo display sa ug unsa e select sa bottom nav, ang default
niya na e display kay ang all listings */

class ListingManagementMainPage extends StatefulWidget {
  const ListingManagementMainPage({super.key});

  @override
  State<ListingManagementMainPage> createState() => _ListingManagementMainPageState();
}

class _ListingManagementMainPageState extends State<ListingManagementMainPage> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

/*Create tag variable nya e initialize nato sa value nga MYLISTINGS para mao ni una mo display */
  String page = "MYLISTINGS";
  String farmerUname = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*Ato e pull out ang value naa naa sa provider nato para ma switch2 nato ang body og appbar ani na page 
nya ato dayn e set ang state sa page na variable para ma ilisan iyang default value sa value na naa ni provider*/

    String newpage = Provider.of<ListingPageProvider>(context, listen: false).getListingPage;
    setState(() {
      page = newpage;
    });

    return Scaffold(
      key: _scaffoldKey,
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
        title: (page == "MYLISTINGS")
            ? const Text("My Listings")
            : (page == "PROMOTEDLISTINGS")
                ? const Text("Promoted Listings")
                : (page == "ADDLISTING")
                    ? const Text("Add Listing")
                    : const Text("Archive Listings"),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      /*The drawer class */
      drawer: const DashBoardDrawer(),
      body: Column(
        children: [
          /*Expanded for the contents */
          Expanded(
            flex: 8,
            /*Ang content ani na container kay mag agad sa value ni provider sama sa heading*/
            child: Container(
              color: Colors.white,
              child: (page == "MYLISTINGS")
                  ? const AllListingsList()
                  : (page == "PROMOTEDLISTINGS")
                      ? const PromotedListingPage()
                      : (page == "ADDLISTING")
                          ? const AddListingPage()
                          : const ArchiveListingPage(),
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
