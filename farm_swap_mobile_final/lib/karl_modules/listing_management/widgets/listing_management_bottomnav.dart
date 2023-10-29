import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/provider/listing_page_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

/*Mao ni class na nag oontain sa buttons sa bottom navbar, nya naa pd diri ang
kung unsay mahitabo ig press sa botton */

class ListingManagementBottomNav extends StatelessWidget {
  const ListingManagementBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
      child: Row(
        children: [
          /*Icon for Display All Active Listings */
          SizedBox(
            width: 50.w,
            child: IconButton(
              onPressed: () {
                /*So atong gi set a current value ni provider to MYLISINGS if e press ni na button
                aron ang ma display nga page sa atong main page is katong page sa all listings */
                Provider.of<ListingPageProvider>(context, listen: false)
                    .setListingPage("MYLISTINGS");
                Navigator.of(context).pushNamed(RouteManager.listingmainpage);
              },
              icon: const Icon(
                FontAwesomeIcons.list,
                color: Colors.white,
              ),
            ),
          ),
          /*Promoted Listings */
          SizedBox(
            width: 17.w,
          ),
          SizedBox(
            width: 50.w,
            child: IconButton(
              onPressed: () {
                /*So atong gi set a current value ni provider to MYLISINGS if e press ni na button
                aron ang ma display nga page sa atong main page is katong page sa all listings */
                Provider.of<ListingPageProvider>(context, listen: false)
                    .setListingPage("PROMOTEDLISTINGS");
                Navigator.of(context).pushNamed(RouteManager.listingmainpage);
              },
              icon: const Icon(
                FontAwesomeIcons.tag,
                color: Colors.white,
              ),
            ),
          ),
          /*Add A Listing */
          SizedBox(
            width: 17.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30.sp,
            child: SizedBox(
              width: 50.w,
              child: IconButton(
                onPressed: () {
                  /*So atong gi set a current value ni provider to MYLISINGS if e press ni na button
                aron ang ma display nga page sa atong main page is katong page sa all listings */
                  Provider.of<ListingPageProvider>(context, listen: false)
                      .setListingPage("ADDLISTING");
                  Navigator.of(context).pushNamed(RouteManager.listingmainpage);
                },
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: farmSwapTitlegreen,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 17.w,
          ),
          /*Archive Listings */
          SizedBox(
            width: 50.w,
            child: IconButton(
              onPressed: () {
                /*So atong gi set a current value ni provider to MYLISINGS if e press ni na button
                aron ang ma display nga page sa atong main page is katong page sa all listings */
                Provider.of<ListingPageProvider>(context, listen: false)
                    .setListingPage("ARCHIVELISTING");
                Navigator.of(context).pushNamed(RouteManager.listingmainpage);
              },
              icon: const Icon(
                FontAwesomeIcons.archive,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 17.w,
          ),
          /*Back to Dashboard button */
          SizedBox(
            width: 50.w,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.activeDashboard);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
