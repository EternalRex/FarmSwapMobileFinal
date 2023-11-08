import 'package:farm_swap_mobile_final/karl_modules/listing_management/database/sell_listing_saving.dart';
import 'package:farm_swap_mobile_final/provider/sell_listing_details_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../common/colors.dart';
import '../../../../../../common/farmer_individual_details.dart';
import '../../../../../../common/green_btn.dart';
import '../../../../../../common/poppins_text.dart';
import '../../../../../dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import '../../../../widgets/listing_management_bottomnav.dart';

class AddActualSellingListingDetails4 extends StatefulWidget {
  const AddActualSellingListingDetails4({super.key});

  @override
  State<AddActualSellingListingDetails4> createState() => _AddActualSellingListingDetails4State();
}

class _AddActualSellingListingDetails4State extends State<AddActualSellingListingDetails4> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  /*Instance of the class that will save our data into the database*/
  SellListingSaving sellSave = SellListingSaving();

  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();

/*Variables that will hold the individual data of farmer */
  String firstname = "";
  String lastname = "";
  String municipality = "";
  String baranggay = "";
  String uname = "";

/*Initializign the function that will get the farmer individual data */
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
        title: const Text("Add Sell Listing"),
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
            child: Container(
              color: Colors.white,
              child: Stack(
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
                  /*This is the actual contents of the page are being displayed */
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Column na nag pa vertically align og sequence sa contents */
                        Padding(
                          padding: EdgeInsets.only(top: 90.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              poppinsText(
                                "Listing Expiration Date",
                                Colors.black,
                                20.sp,
                                FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _selectDate();
                                    },
                                    child: Image.asset(
                                      "assets/karl_assets/images/calendar_image.png",
                                      height: 250.h,
                                      width: 300.w,
                                    ),
                                  ),
                                  Positioned(
                                    top: 190.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: 200.sp,
                                        height: 50.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: shadow,
                                              blurRadius: 2,
                                              offset: const Offset(1, 5),
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: poppinsText(
                                            endDateString,
                                            Colors.black,
                                            10.sp,
                                            FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 250.sp,
                                    child: poppinsText(
                                      "(Selected expiration date)",
                                      Colors.black,
                                      9.sp,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<SellListingDetailsProvider>(context, listen: false)
                                      .setEndDate(endListingDate);
                                  showFinalData();
                                },
                                child: const FarmSwapGreenBtn(text: "Review"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

/*THIS ARE THE FUNCTION THAT WE USE IN THIS CLASS */

  DateTime endListingDate = DateTime.now();
  String endDateString = "Press icon to select date";

/*To select the date*/
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endListingDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null && pickedDate != endListingDate) {
      setState(() {
        endDateString = pickedDate.toString();
        endListingDate = pickedDate;
      });
    }
  }

/*To show the data that the farmer entered for review */
  void showFinalData() {
/*Converting the time*/

    DateTime date = Provider.of<SellListingDetailsProvider>(context, listen: false).getEndDate;
    String finalDate = DateFormat('yyyy-MM-dd').format(date);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Listing Data"),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 250.w,
              height: 250.h,
              child: Consumer<SellListingDetailsProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      /*The row for Listing Name and its Value */
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: poppinsText(
                              value.getListingName,
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      /*This row is for the Listing Discription */
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: poppinsText(
                              value.getListingDisc,
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      /*This row is for the product quantity*/
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: poppinsText(
                              "${value.getquantity} " " kg",
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      /*This  row is for the product Price*/
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: poppinsText(
                              "${value.getPrice} " " /kg",
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      /*This row is for the expiration date*/
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: poppinsText(
                              finalDate,
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showDoneMessage();
                },
                child: const FarmSwapGreenBtn(text: "Finish"),
              ),
            ),
          ],
        );
      },
    );
  }

/*To finalize everything, save the data to the database and tell the
farmer that data is saved */
  void showDoneMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          child: AlertDialog(
            title: poppinsText(
              "Congratulations!",
              Colors.black,
              20.sp,
              FontWeight.bold,
            ),
            content: poppinsText(
              "You have successfully added a listing for sale, Check your listings now!",
              Colors.black,
              15.sp,
              FontWeight.normal,
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    /*Saving the data */
                    sellSave.saveSellingListing(
                      Provider.of<SellListingDetailsProvider>(context, listen: false)
                          .getListingName,
                      Provider.of<SellListingDetailsProvider>(context, listen: false)
                          .getListingDisc,
                      Provider.of<SellListingDetailsProvider>(context, listen: false).getquantity,
                      Provider.of<SellListingDetailsProvider>(context, listen: false).getPrice,
                      "SELL",
                      Provider.of<SellListingDetailsProvider>(context, listen: false).getPhoto,
                      firstname,
                      lastname,
                      municipality,
                      baranggay,
                      uname,
                      DateTime.now(),
                      Provider.of<SellListingDetailsProvider>(context, listen: false).getEndDate,
                    );
                    Navigator.of(context).pushNamed(RouteManager.listingmainpage);
                  },
                  child: const FarmSwapGreenBtn(text: "Listings"),
                ),
              ),
            ],
          ),
        );
      },
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
