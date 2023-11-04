import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/sell_update_listing.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/registertxtfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../routes/routes.dart';

class UpdateSellListingStringValues extends StatefulWidget {
  const UpdateSellListingStringValues({super.key, required this.value, required this.url});

  /*Ato ning e pasa sa querry class para gamiton sa switch case statement */
  final String value;
  /*Akong gi kuha ang value sa url from the original drop down button class para akong ipasa ngadto napd sa class na
  mag querry sa database aron magamit ni as a unique identifier para sa atong condition */
  final String url;

  @override
  State<UpdateSellListingStringValues> createState() => _UpdateSellListingStringValuesState();
}

class _UpdateSellListingStringValuesState extends State<UpdateSellListingStringValues> {
/*Text Editing controllers*/
  TextEditingController nameController = TextEditingController();
  TextEditingController discController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController itemController = TextEditingController();

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  SellListingUpdate sellUpdate = SellListingUpdate();

  @override
  void dispose() {
    nameController.dispose();
    discController.dispose();
    priceController.dispose();
    quantityController.dispose();
    itemController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getFarmerUname();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /*Gigagmit nato ang value ni value variable para e determine kung unsa na title ang e displa */
      child: (widget.value == "LISTINGNAME")
          ? poppinsText("Listing Name", Colors.black, 15.sp, FontWeight.normal)
          : (widget.value == "LISTINGDISC")
              ? poppinsText("Discription", Colors.black, 15.sp, FontWeight.normal)
              : (widget.value == "LISTINGPRICE")
                  ? poppinsText("Equivalent Price", Colors.black, 15.sp, FontWeight.normal)
                  : poppinsText("Quantity", Colors.black, 15.sp, FontWeight.normal),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              /*Gigagmit nato ang value ni value variable para e determine kung unsa na title ang e displa */
              title: (widget.value == "LISTINGNAME")
                  ? const Text("New Listing Name")
                  : (widget.value == "LISTINGDISC")
                      ? const Text("New Discription")
                      : (widget.value == "LISTINGPRICE")
                          ? const Text("New Price")
                          : const Text("New Quantity"),

              /*So para dili kalas og page, sa pop up na dialog box nalang ta mag enter sa 
                        details nga para update */
              content: FarmSwapTextField(
                /*Gigagmit nato ang value ni value variable para e determine kung unsa na controller ang gamiton */
                controller: (widget.value == "LISTINGNAME")
                    ? nameController
                    : (widget.value == "LISTINGDISC")
                        ? discController
                        : (widget.value == "LISTINGPRICE")
                            ? priceController
                            : quantityController,
                label: poppinsText(
                  "Enter new value",
                  Colors.black,
                  10.sp,
                  FontWeight.normal,
                ),
                isPassword: false,
              ),
              actions: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      /*Gigagmit nato ang value ni value variable para e determine kung unsa na controller value ang e handos ngadto sa querry class */
                      (widget.value == "LISTINGNAME")
                          ? sellUpdate.updateListingStringValues(
                              newUname, widget.value, nameController.text, widget.url)
                          : (widget.value == "LISTINGDISC")
                              ? sellUpdate.updateListingStringValues(
                                  newUname, widget.value, discController.text, widget.url)
                              : (widget.value == "LISTINGPRICE")
                                  ? sellUpdate.updateListingStringValues(
                                      newUname, widget.value, priceController.text, widget.url)
                                  : sellUpdate.updateListingStringValues(
                                      newUname, widget.value, quantityController.text, widget.url);

                      successDisplay();
                    },
                    child: const FarmSwapGreenBtn(
                      text: "Update",
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String newUname = "";

  Future<void> getFarmerUname() async {
    String uname = await farmerDetails.getUname();
    setState(() {
      newUname = uname;
    });
  }

  void successDisplay() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Success",
            Colors.black,
            20.sp,
            FontWeight.bold,
          ),
          content: CircleAvatar(
            backgroundColor: farmSwapTitlegreen,
            child: const Icon(
              Icons.check,
              color: Colors.white70,
            ),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteManager.listingmainpage);
                },
                child: const FarmSwapGreenBtn(text: "Finish"),
              ),
            ),
          ],
        );
      },
    );
  }
}
