import 'package:flutter/material.dart';

class ConsumerDisputeLabel {
  late Widget consumerDisputeText;

  ConsumerDisputeLabel({
    Widget? consumerDisputeText,
  }) {
    this.consumerDisputeText = consumerDisputeText ?? const Text('Write your message here');
  }
}
