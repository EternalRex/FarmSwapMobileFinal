import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/get_specific_user_docid.dart';
import '../../../../karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import '../wrapper/getdisplayuserdata.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

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
        title: const Text("Wallet"),
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
            SizedBox(
              width: 780.w,
              height: 165.h,
              child: const Image(
                image: AssetImage(
                    'assets/karl_assets/images/walletbackground.png'),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                //this will display the farmer profile information
                FutureBuilder<String>(
                  future: id.getFarmerDocumentId(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String data = snapshot.data!;
                      return DisplayWalletData(documentId: data);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.activeDashboard);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.home_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
