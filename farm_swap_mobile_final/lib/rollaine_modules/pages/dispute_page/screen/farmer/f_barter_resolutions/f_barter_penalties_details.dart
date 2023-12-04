import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/navbar/farmer_dispute_page_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmerBarterPenalties extends StatefulWidget {
  const FarmerBarterPenalties({
    super.key,
    required this.itemUrl,
    required this.listingUrl,
    required this.adminEmail,
    required this.consumerid,
    required this.farmerid,
    required this.penaltyMessage,
    required this.resolDate,
    required this.resolDateString,
    required this.resolutionMessage,
    required this.reported,
    required this.reporting,
    required this.reportedRole,
    required this.reportingRole,
  });
  final String itemUrl;
  final String listingUrl;
  final String adminEmail;
  final String consumerid;
  final String farmerid;
  final String penaltyMessage;
  final DateTime resolDate;
  final String resolDateString;
  final String resolutionMessage;
  final String reported;
  final String reporting;
  final String reportedRole;
  final String reportingRole;
  @override
  State<FarmerBarterPenalties> createState() => _FarmerBarterPenaltiesState();
}

class _FarmerBarterPenaltiesState extends State<FarmerBarterPenalties> {
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
        title: Row(
          children: [
            poppinsText(
              "Details",
              Colors.white,
              20.sp,
              FontWeight.bold,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*For the resolution message */
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300,
                child:
                    poppinsText2(widget.resolutionMessage, Colors.black, 15.sp, FontWeight.normal),
              ),
              const Divider(
                thickness: 2,
              ),
              poppinsText("Resolution Message", Colors.black54, 15.sp, FontWeight.normal),
              /*For the penalty */
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300,
                child: poppinsText2(widget.penaltyMessage, Colors.black, 15.sp, FontWeight.normal),
              ),
              const Divider(
                thickness: 2,
              ),
              poppinsText("Penalty", Colors.black54, 15.sp, FontWeight.normal),
              /*Offending user */
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300,
                child: poppinsText2('${widget.reported} (${widget.reportedRole})', Colors.black,
                    15.sp, FontWeight.normal),
              ),
              const Divider(
                thickness: 2,
              ),
              poppinsText("Reported User", Colors.black54, 15.sp, FontWeight.normal),
              /*Admin resolutioner */
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300,
                child: poppinsText2(
                    '${widget.adminEmail} (ADMIN)', Colors.black, 15.sp, FontWeight.normal),
              ),
              const Divider(
                thickness: 2,
              ),
              poppinsText("Issued By", Colors.black54, 15.sp, FontWeight.normal),
              /*Resolution Date */
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: 300,
                child: poppinsText2(widget.resolDateString, Colors.black, 15.sp, FontWeight.normal),
              ),
              const Divider(
                thickness: 2,
              ),
              poppinsText("Date Issued", Colors.black54, 15.sp, FontWeight.normal),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.sp,
        decoration: BoxDecoration(
          color: greenNormal,
          image: const DecorationImage(
            image: AssetImage("assets/karl_assets/images/appbarpattern.png"),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: farmSwapTitlegreen),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: const FarmerBarterDisputesNavBar(),
      ),
    );
  }
}
