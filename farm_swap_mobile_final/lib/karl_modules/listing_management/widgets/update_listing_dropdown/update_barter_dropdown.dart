import 'package:farm_swap_mobile_final/karl_modules/listing_management/widgets/update_listing_dropdown/update_barter_dropdown_change_value.dart';
import 'package:flutter/material.dart';

class UpdateListingDropDownBtn extends StatefulWidget {
  const UpdateListingDropDownBtn({super.key, required this.profileUrl});
  /*Akong gi pangayo ang profile url ani para akong mapasa hantod sa class na mag querry sa database
  aron ako ning magamit as a condition sa querry na whoever barter document naa naay url na ing ani, mao
   to siya ang e update, since sa properties kay ang url man ang pinaka unique */
  final String profileUrl;

  @override
  State<UpdateListingDropDownBtn> createState() => _UpdateListingDropDownBtnState();
}

class _UpdateListingDropDownBtnState extends State<UpdateListingDropDownBtn> {
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
          child: UpdateBarterListingStringValues(
            value: "LISTINGNAME",
            url: widget.profileUrl,
          ),
        ),
        /*For Listing Discription */
        DropdownMenuItem(
          value: "LISTINGDISC",
          child: UpdateBarterListingStringValues(
            value: "LISTINGDISC",
            url: widget.profileUrl,
          ),
        ),
        /*For Listing Price */
        DropdownMenuItem(
          value: "LISTINGPRICE",
          child: UpdateBarterListingStringValues(
            value: "LISTINGPRICE",
            url: widget.profileUrl,
          ),
        ),
        /*For Listing Quantity */
        DropdownMenuItem(
          value: "LISTINGQUANTITY",
          child: UpdateBarterListingStringValues(
            value: "LISTINGQUANTITY",
            url: widget.profileUrl,
          ),
        ),
        /*For Listing Category */
        /*For Listing Preffered Item */
        DropdownMenuItem(
          value: "PREFFEREDITEM",
          child: UpdateBarterListingStringValues(
            value: "PREFFEREDITEM",
            url: widget.profileUrl,
          ),
        ),
      ],
    );
  }
}
