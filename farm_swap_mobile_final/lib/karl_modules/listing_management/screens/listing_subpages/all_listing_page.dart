import 'package:flutter/material.dart';

class AllListingsList extends StatefulWidget {
  const AllListingsList({super.key});

  @override
  State<AllListingsList> createState() => _AllListingsListState();
}

class _AllListingsListState extends State<AllListingsList> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("All Listings"),
        )
      ],
    );
  }
}
