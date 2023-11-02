import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/provider/listing_addcategory_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 330.w,
                  height: 50.h,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 360.w,
                height: 50.h,
              ),
            ),
          ],
        ),
      ],
    );

    /*
    return Stack(
      children: [
        Positioned.fill(
          top: -600.sp,
          bottom: 0.sp,
          child: SvgPicture.asset(
            "assets/karl_assets/icons/Pattern.svg",
            height: 200,
            width: 400,
          ),
        ),
        Positioned.fill(
          top: 400.sp,
          bottom: -200.sp,
          child: SvgPicture.asset(
            "assets/karl_assets/icons/Pattern.svg",
            height: 200,
            width: 400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Conatainer for abarter option */
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        /*Setting the value of our provider as barter so that this page
                        will be redirected to add barter listing */
                        Provider.of<AddListingCategoryProvider>(context, listen: false)
                            .setListingCategory("BARTER");
                        Navigator.of(context).pushNamed(RouteManager.addlistingpage1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/karl_assets/icons/barteringLogo.svg",
                            height: 150.h,
                            width: 150.w,
                          ),
                          poppinsText("Add Barter Listing", greenDarkActive, 15.sp, FontWeight.bold)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        /*Setting the value of our provider as barter so that this page
                        will be redirected to add selling  listing */
                        Provider.of<AddListingCategoryProvider>(context, listen: false)
                            .setListingCategory("SELL");
                        Navigator.of(context).pushNamed(RouteManager.addlistingpage1);
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/karl_assets/icons/sellingLogo.svg",
                            height: 150.h,
                            width: 150.w,
                          ),
                          poppinsText(
                            "Add Selling Listing",
                            greenDarkActive,
                            15.sp,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );*/
  }
}
