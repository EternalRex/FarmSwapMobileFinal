import 'package:flutter/material.dart';

class SellDashboard extends StatefulWidget {
  const SellDashboard({super.key});

  @override
  State<SellDashboard> createState() => _SellDashboardState();
}

class _SellDashboardState extends State<SellDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Sell"),
      ],
    );
  }
}
