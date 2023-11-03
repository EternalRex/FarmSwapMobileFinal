import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/controllers/listings_textcontrollers.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/add_listing_textbox.dart';
import 'package:farm_swap_mobile_final/provider/barter_listing_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddActualBarterListingDetils extends StatefulWidget {
  const AddActualBarterListingDetils({super.key});

  @override
  State<AddActualBarterListingDetils> createState() => _AddActualBarterListingDetilsState();
}

class _AddActualBarterListingDetilsState extends State<AddActualBarterListingDetils> {
  AddBarterListingTextEditingControllers controllers = AddBarterListingTextEditingControllers();

  @override
  void dispose() {
    controllers.nameBController.dispose();
    controllers.discriptionBController.dispose();
    controllers.priceBController.dispose();
    controllers.quantityBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.sp),
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
                      controller: controllers.quantityBController,
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
                      controller: controllers.priceBController,
                      text: poppinsText(
                        "Equivalent Product Price",
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
                  /*Preffered item part */
                  SizedBox(
                    height: 80.sp,
                    width: 300.sp,
                    child: AddListingTexField(
                      controller: controllers.prefferedController,
                      text: poppinsText(
                        "Preffered Item to Barter",
                        Colors.black,
                        13.sp,
                        FontWeight.w200,
                      ),
                      size: 15.sp,
                      icon: Icon(
                        FontAwesomeIcons.box,
                        color: darkGreen,
                      ),
                      keyboard: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  GestureDetector(
                    /*Putting the values in the provider para gamiton nato later charot */
                    onTap: () {
                      Provider.of<BarterListingDetailsProvider>(context, listen: false)
                          .setListingName(controllers.nameBController.text);

                      Provider.of<BarterListingDetailsProvider>(context, listen: false)
                          .setListingDisc(controllers.discriptionBController.text);

                      Provider.of<BarterListingDetailsProvider>(context, listen: false)
                          .setquantitiy(double.parse(controllers.quantityBController.text));

                      Provider.of<BarterListingDetailsProvider>(context, listen: false)
                          .setPrice(double.parse(controllers.priceBController.text));

                      Provider.of<BarterListingDetailsProvider>(context, listen: false)
                          .setPrefferedItem(controllers.prefferedController.text);

                      Navigator.of(context).pushNamed(RouteManager.addbarterlisttingdetails2);
                    },
                    child: const FarmSwapGreenBtn(text: "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
