import 'package:flutter/material.dart';

class BestDealsDashboard extends StatefulWidget {
  const BestDealsDashboard({super.key});

  @override
  State<BestDealsDashboard> createState() => _BestDealsDashboardState();
}

class _BestDealsDashboardState extends State<BestDealsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Best Deals"),
      ],
    );
  }
}
