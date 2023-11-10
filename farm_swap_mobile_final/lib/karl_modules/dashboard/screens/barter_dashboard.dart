import "package:farm_swap_mobile_final/karl_modules/dashboard/functions/get_all_barter_listings.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class BarterDashboard extends StatefulWidget {
  const BarterDashboard({super.key});

  @override
  State<BarterDashboard> createState() => _BarterDashboardState();
}

class _BarterDashboardState extends State<BarterDashboard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 395.h,
              child: const DashBoardGetAllBarterListings(),
            ),
          ),
        ),
      ],
    );
  }
}

/*
class TwoItemsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: yourDataList.length, // Replace with your data list length
      itemBuilder: (context, index) {
        // Check if the current index is even or odd to display two items in a row.
        if (index.isEven) {
          return Row(
            children: <Widget>[
              Expanded(
                child: yourItemWidget(index),
              ),
              Expanded(
                child: yourItemWidget(index + 1),
              ),
            ],
          );
        }
        return Divider(); // You can use a divider or separator between rows.
      },
    );
  }

  Widget yourItemWidget(int index) {
    // Create your item widget based on the index.
    return ListTile(
      title: Text('Item $index'),
      // Customize this widget based on your data.
    );
  }

  List<String> yourDataList = List.generate(20, (index) => 'Item $index');
}*/
