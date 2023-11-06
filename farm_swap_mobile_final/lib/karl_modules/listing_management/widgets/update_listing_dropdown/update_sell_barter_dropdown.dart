import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/update_listing_dropdown/update_sell_dropdown_changevalue.dart';
import 'package:flutter/material.dart';

class UpdateSellListingDropdownBtn extends StatefulWidget {
  const UpdateSellListingDropdownBtn({super.key, required this.profileurl});
  final String profileurl;

  @override
  State<UpdateSellListingDropdownBtn> createState() => _UpdateSellListingDropdownBtnState();
}

class _UpdateSellListingDropdownBtnState extends State<UpdateSellListingDropdownBtn> {
  String selectedValue = "LISTINGNAME";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
      items: [
        /*For Listing Name */
        DropdownMenuItem(
          value: "LISTINGNAME",
          child: UpdateSellListingStringValues(
            value: "LISTINGNAME",
            url: widget.profileurl,
          ),
        ),
        /*For Listing Discription */
        DropdownMenuItem(
          value: "LISTINGDISC",
          child: UpdateSellListingStringValues(
            value: "LISTINGDISC",
            url: widget.profileurl,
          ),
        ),
        /*For Listing Price */
        DropdownMenuItem(
          value: "LISTINGPRICE",
          child: UpdateSellListingStringValues(
            value: "LISTINGPRICE",
            url: widget.profileurl,
          ),
        ),
        /*For Listing Quantity */
        DropdownMenuItem(
          value: "LISTINGQUANTITY",
          child: UpdateSellListingStringValues(
            value: "LISTINGQUANTITY",
            url: widget.profileurl,
          ),
        ),
        /*For Listing Category */
        /*For Listing Preffered Item */
      ],
    );
  }
}
