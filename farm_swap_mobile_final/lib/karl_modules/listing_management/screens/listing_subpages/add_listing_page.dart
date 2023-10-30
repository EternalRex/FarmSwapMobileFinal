import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/provider/listing_addcategory_provider.dart';
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
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();

  String firstname = "";
  String lastname = "";
  String municipality = "";
  String baranggay = "";
  String uname = "";

  @override
  void initState() {
    super.initState();
    /*Ato gi initialize a function diri para ma update ning variable na firstname */
    getFarmerFirstName();
    getFarmerBarrangay();
    getFarmerMunicipality();
    getFarmerUserName();
    getFarmerLastName();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Conatainer for abarter option */
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(0),
                  ),
                  /*PUTTING BOX SHADOW ON THE CONTAINER */
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    /*Setting the value of our provider as barter so that this page
                    will be redirected to add barter listing */
                    Provider.of<AddListingCategoryProvider>(context, listen: false)
                        .setListingCategory("BARTER");
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(0),
                  ),
                  /*PUTTING BOX SHADOW ON THE CONTAINER */
                  boxShadow: [
                    BoxShadow(
                      color: shadow,
                      blurRadius: 2,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    /*Setting the value of our provider as barter so that this page
                    will be redirected to add selling  listing */
                    Provider.of<AddListingCategoryProvider>(context, listen: false)
                        .setListingCategory("SELL");
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/karl_assets/icons/sellingLogo.svg",
                        height: 150.h,
                        width: 150.w,
                      ),
                      poppinsText("Add Selling Listing", greenDarkActive, 15.sp, FontWeight.bold)
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
    );
  }

/*Himo tag function nga mo call atong function nga mag access sa property values
ni farmer kato ning class nga  ListinGetFarmerDetails*/
  Future<void> getFarmerFirstName() async {
    /*Diri na part nato gi kuha jud a value sa firstname, from the function 
    nga ni return og future string sa katong class na  istinGetFarmerDetails */
    String fname = await farmerDetails.getFarmerFirstname();
    setState(() {
      /*Atong gi set ang new value sa atong firtname na variable para ato siyang gamiton sa 
      pag displat sa name sa farmer sa atong user interface */
      firstname = fname;
    });
  }

  Future<void> getFarmerLastName() async {
    String lname = await farmerDetails.getLastName();
    setState(() {
      lastname = lname;
    });
  }

  Future<void> getFarmerMunicipality() async {
    String munisipyo = await farmerDetails.getMunicipalityFirstname();
    setState(() {
      municipality = munisipyo;
    });
  }

  Future<void> getFarmerBarrangay() async {
    String barangay = await farmerDetails.getBaranggay();
    setState(() {
      baranggay = barangay;
    });
  }

  Future<void> getFarmerUserName() async {
    String username = await farmerDetails.getUname();
    setState(() {
      uname = username;
    });
  }
}
