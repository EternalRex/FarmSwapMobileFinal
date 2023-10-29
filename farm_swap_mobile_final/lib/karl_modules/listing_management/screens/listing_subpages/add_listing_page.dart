import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    /*Ato gi initialize a function diri para ma update ning variable na firstname */
    getFarmerFirstName();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: Text(firstname),
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
}
