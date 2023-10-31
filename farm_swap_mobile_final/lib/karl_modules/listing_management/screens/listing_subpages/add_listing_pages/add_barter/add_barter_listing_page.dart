import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/controllers/listings_textcontrollers.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/add_listing_textbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddActualBarterListingDetils extends StatefulWidget {
  const AddActualBarterListingDetils({super.key});

  @override
  State<AddActualBarterListingDetils> createState() => _AddActualBarterListingDetilsState();
}

class _AddActualBarterListingDetilsState extends State<AddActualBarterListingDetils> {
  AddBarterListingTextEditingControllers controllers = AddBarterListingTextEditingControllers();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.sp),
            child: Column(
              children: [
                /*For the enter listing name */
                SizedBox(
                  height: 80.sp,
                  width: 300.sp,
                  child: AddListingTexField(
                      controller: controllers.nameBController,
                      text: poppinsText(
                        "Enter Listing Name",
                        Colors.black,
                        13.sp,
                        FontWeight.w200,
                      ),
                      size: 15.sp,
                      icon: Icon(
                        FontAwesomeIcons.list,
                        color: darkGreen,
                      )),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                /*Enter listing discription */
                SizedBox(
                  height: 200.sp,
                  width: 300.sp,
                  child: AddListingTexField(
                    controller: controllers.discriptionBController,
                    text: poppinsText(
                      "Enter Listing Discription",
                      Colors.black,
                      13.sp,
                      FontWeight.w200,
                    ),
                    size: 15.sp,
                    icon: const Icon(null),
                    maxLines: 100,
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                /*Listin quantity */
                SizedBox(
                  height: 80.sp,
                  width: 300.sp,
                  child: AddListingTexField(
                    controller: controllers.nameBController,
                    text: poppinsText(
                      "Product Quantity in kilograms",
                      Colors.black,
                      13.sp,
                      FontWeight.w200,
                    ),
                    size: 15.sp,
                    icon: Icon(
                      FontAwesomeIcons.list,
                      color: darkGreen,
                    ),
                    keyboard: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                /*Listing price per kilogram */
                SizedBox(
                  height: 80.sp,
                  width: 300.sp,
                  child: AddListingTexField(
                    controller: controllers.nameBController,
                    text: poppinsText(
                      "Product Price/kg",
                      Colors.black,
                      13.sp,
                      FontWeight.w200,
                    ),
                    size: 15.sp,
                    icon: Icon(
                      FontAwesomeIcons.list,
                      color: darkGreen,
                    ),
                    keyboard: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                GestureDetector(
                  onTap: () {},
                  child: const FarmSwapGreenBtn(text: "Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
