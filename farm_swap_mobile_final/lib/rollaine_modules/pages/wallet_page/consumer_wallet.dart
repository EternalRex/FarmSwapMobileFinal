import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/get_specific_user_docid.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/screens/wallet_wrapper.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConsumerWallet extends StatefulWidget {
  const ConsumerWallet({super.key});

  final String userId = '';

  @override
  State<ConsumerWallet> createState() => _ConsumerWalletState();
}

class _ConsumerWalletState extends State<ConsumerWallet> {
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
        elevation: 0,
        title: Text(
          'Wallet',
          style: Poppins.pageTitle.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: farmSwapTitlegreen,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            /*Opening the drawer */
            openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: const DashBoardDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: 780.w,
              height: 180.h,
              child: SvgPicture.asset(
                'assets/karl_assets/images/profilebg.svg',
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                FutureBuilder<String>(
                  future: id.getConsumerDocumentId(
                      FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String data = snapshot.data!;
                      return ReadConsumerWallet(documentId: data);
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Color(0xFF14BE77),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            )
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
