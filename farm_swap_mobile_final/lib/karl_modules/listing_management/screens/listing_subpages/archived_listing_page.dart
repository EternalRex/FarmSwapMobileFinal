import 'package:flutter/material.dart';

class ArchiveListingPage extends StatefulWidget {
  const ArchiveListingPage({super.key});

  @override
  State<ArchiveListingPage> createState() => _ArchiveListingPageState();
}

class _ArchiveListingPageState extends State<ArchiveListingPage> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Center(
          child: Text("Archive Page"),
        )
      ],
    );
  }
}
