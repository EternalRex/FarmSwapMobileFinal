import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';

class ActiveDashboard extends StatelessWidget {
  ActiveDashboard({super.key});

/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Active Dashboard"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      /*Displaying the drawer */
      drawer: const DashBoardDrawer(),
      body: const Center(
        child: Text("Hi Mega"),
      ),
    );
  }
}
