import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/search_bar.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/screens/farmer_chat_screen_main.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmerConsumerChat extends StatefulWidget {
  const FarmerConsumerChat({super.key});

  @override
  State<FarmerConsumerChat> createState() => _FarmerConsumerChatState();
}

class _FarmerConsumerChatState extends State<FarmerConsumerChat> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  TextEditingController searchController = TextEditingController();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: greenNormal,
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        title: Row(
          children: [
            const Text("Chat Consumers"),
            SizedBox(
              width: 21.w,
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const FarmerMainChatScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      /*The drawer class */
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          /*Column that will hold the center content */
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.sp),
                /*Row that holds the search functionality */
                child: Row(
                  children: [
                    SizedBox(
                      width: 280.w,
                      child: MobileSearchBar(controller: searchController),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          searchValue = searchController.text;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFFDA6317),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
