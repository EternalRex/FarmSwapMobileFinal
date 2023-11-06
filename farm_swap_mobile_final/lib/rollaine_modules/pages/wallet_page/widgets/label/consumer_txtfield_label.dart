import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:flutter/material.dart';

ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();

class CWalletTextFieldLabel {
  late Widget userId;
  late Widget firstName;
  late Widget lastName;
  late Widget contactNumber;
  late Widget address;

  CWalletTextFieldLabel({
    Widget? userId,
    Widget? firstName,
    Widget? lastName,
    Widget? contactNumber,
    Widget? address,
  }) {
    this.userId = userId ?? const Text("User Id");
    this.firstName = firstName ?? const Text("First Name");
    this.lastName = lastName ?? const Text("Last Name");
    this.contactNumber = contactNumber ?? const Text("Contact Number");
    this.address = address ?? const Text("Address");

    init();
  }
  bool isLoading =
      true; // Initially, set it to true to show the loading indicator.

  //kani na function tawagon sa cash in gesture na page para ma store ang data sa label
  //then if gi call ang firstName then makit na sa textfield set as label ang na get nga farmer first name
  Future<void> init() async {
    ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
    firstName = Text(await consumerDetails.getConsumerFirstname());
    lastName = Text(await consumerDetails.getConsumerLastName());

    isLoading = false; // Set isLoading to false to hide the loading indicator.
  }
}
