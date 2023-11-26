import 'package:flutter/material.dart';

class FarmerDisputeLabel {
  late Widget farmerDisputeText;

  FarmerDisputeLabel({
    Widget? farmerDisputeText,
  }) {
    this.farmerDisputeText = farmerDisputeText ?? const Text('Write your message here');
  }
}
