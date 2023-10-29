import 'package:flutter/material.dart';

class PromotedListingPage extends StatefulWidget {
  const PromotedListingPage({super.key});

  @override
  State<PromotedListingPage> createState() => _PromotedListingPageState();
}

class _PromotedListingPageState extends State<PromotedListingPage> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Center(
          child: Text("Promoted"),
        ),
      ],
    );
  }
}
