import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/account_management_farmer/widgets/getdisplayfarmerdata.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/get_specific_user_docid.dart';

class FarmerProfileDashboard extends StatelessWidget {
  FarmerProfileDashboard({super.key});

/*Instance of the class that will get a specific document id*/
  final GetSpecificUserDocumentId id = GetSpecificUserDocumentId();

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
        backgroundColor: greenNormal,
        title: const Text("Account Management"),
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/karl_assets/images/pattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
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
      drawer: DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              width: 780,
              height: 165,
              child: Image(
                image: AssetImage('assets/karl_assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                //this will display the farmer profile information
                FutureBuilder<String>(
                  future: id.getFarmerDocumentId(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String data = snapshot.data!;
                      return DisplayFarmerProfileData(documentId: data);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const Text(
                          "Loading..."); // You can use a loading indicator here.
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
