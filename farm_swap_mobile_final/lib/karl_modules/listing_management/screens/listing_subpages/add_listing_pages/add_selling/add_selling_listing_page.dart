import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/controllers/listings_textcontrollers.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/add_listing_textbox.dart';
import 'package:farm_swap_mobile_final/provider/sell_listing_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/poppins_text.dart';

class AddActualSellingListingDetails extends StatefulWidget {
  const AddActualSellingListingDetails({super.key});

  @override
  State<AddActualSellingListingDetails> createState() => _AddActualSellingListingDetailsState();
}

class _AddActualSellingListingDetailsState extends State<AddActualSellingListingDetails> {
  AddSellListingTextEditingControllers controllers = AddSellListingTextEditingControllers();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: -400.sp,
          bottom: 0.sp,
          child: SvgPicture.asset(
            "assets/karl_assets/icons/Pattern.svg",
            height: 200,
            width: 400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.sp),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80.sp,
                      width: 300.sp,
                      child: AddListingTexField(
                          controller: controllers.nameSController,
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
                        controller: controllers.discriptionSController,
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
                        controller: controllers.quantitySController,
                        text: poppinsText(
                          "Product Quantity in kilograms",
                          Colors.black,
                          13.sp,
                          FontWeight.w200,
                        ),
                        size: 15.sp,
                        icon: Icon(
                          FontAwesomeIcons.weightScale,
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
                        controller: controllers.priceSController,
                        text: poppinsText(
                          "Product Price/kg",
                          Colors.black,
                          13.sp,
                          FontWeight.w200,
                        ),
                        size: 15.sp,
                        icon: Icon(
                          FontAwesomeIcons.tag,
                          color: darkGreen,
                        ),
                        keyboard: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    /*Saving to the provider the data we got here*/
                    GestureDetector(
                      onTap: () {
                        Provider.of<SellListingDetailsProvider>(context, listen: false)
                            .setListingName(controllers.nameSController.text);

                        Provider.of<SellListingDetailsProvider>(context, listen: false)
                            .setListingDisc(controllers.discriptionSController.text);

                        Provider.of<SellListingDetailsProvider>(context, listen: false)
                            .setquantitiy(
                          double.parse(controllers.quantitySController.text),
                        );

                        Provider.of<SellListingDetailsProvider>(context, listen: false).setPrice(
                          double.parse(controllers.priceSController.text),
                        );

                        Navigator.of(context).pushNamed(RouteManager.addselllistingdetails2);
                      },
                      child: const FarmSwapGreenBtn(text: "Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
