import "package:flutter/material.dart";

class BarterDashboard extends StatefulWidget {
  const BarterDashboard({super.key});

  @override
  State<BarterDashboard> createState() => _BarterDashboardState();
}

class _BarterDashboardState extends State<BarterDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          child: Text("Hi"),
        )
      ],
    );
  }
}
