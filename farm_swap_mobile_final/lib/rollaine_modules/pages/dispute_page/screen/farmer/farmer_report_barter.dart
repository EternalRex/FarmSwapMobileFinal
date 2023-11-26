import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/textfield/wallet_textfield.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/controllers/farmer/barter_dispute_controller.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/label/farmer_dispute_label.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/textfield/barter_dispute_txtfield.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class FarmerReportBarter extends StatefulWidget {
  const FarmerReportBarter(
      {super.key,
      required this.cBarangay,
      required this.cLname,
      required this.cMunicipality,
      required this.cName,
      required this.cUname,
      required this.deductFarm,
      required this.deductCons,
      required this.fBarangay,
      required this.fLname,
      required this.fMunicipality,
      required this.fName,
      required this.lName,
      required this.fUname,
      required this.iName,
      required this.iUrl,
      required this.iValue,
      required this.lId,
      required this.lValue,
      required this.lUrl,
      required this.pFee});

  final String cBarangay;
  final String cLname;
  final String cMunicipality;
  final String cName;
  final String cUname;
  final String deductFarm;
  final String deductCons;
  final String fBarangay;
  final String fLname;
  final String fMunicipality;
  final String fName;
  final String fUname;
  final String iUrl;
  final String iName;
  final String iValue;
  final String lName;
  final String lId;
  final String lValue;
  final String lUrl;
  final String pFee;

  @override
  State<FarmerReportBarter> createState() => _FarmerReportBarterState();
}

class _FarmerReportBarterState extends State<FarmerReportBarter> {
  bool isLoading = true;

  TextEditingController disputeDateFileController = TextEditingController();

  @override
  void initState() {
    super.initState();

    disputeDateFileController.text = '';
    controllers.farmerDisputeTextController = TextEditingController();

    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    setState(() {
      isLoading = false;
    });
  }

  static BarterTextEditingControllers controllers =
      BarterTextEditingControllers();
  FarmerDisputeLabel label = FarmerDisputeLabel();

  @override
  void dispose() {
    controllers.farmerDisputeTextController.dispose();
    disputeDateFileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: farmSwapTitlegreen,
        title: const Text('Dispute'),
        flexibleSpace: Container(
          height: 300.h,
          width: 300.w,
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
            Navigator.of(context).pushNamed(RouteManager.farmerdisputepage);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              'Bartered Transaction Details',
                              style: TextStyle(
                                color: const Color(0xFF09041B),
                                fontSize: 18.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: 0.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                    child: Container(
                      height: 545.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color: shadow,
                              blurRadius: 2,
                              offset: const Offset(0, 1))
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 330.h,
                                    width: 330.w,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 174.h,
                                              width: 330.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          widget.iUrl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              widget.iName,
                                              style:
                                                  Poppins.farmerName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 15),
                                            child: Text(
                                              'Item Value:'
                                              ' '
                                              '₱'
                                              ' '
                                              '${widget.iValue}',
                                              style: Poppins.userName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${widget.cName}'
                                              ' '
                                              '${widget.cLname}'
                                              ' '
                                              '(${widget.cUname})',
                                              style:
                                                  Poppins.farmerName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${widget.cBarangay}'
                                              ', '
                                              '${widget.cMunicipality}',
                                              style: Poppins.adminName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Deducted sc/s:'
                                              ' '
                                              '₱'
                                              ' '
                                              '${widget.deductCons}',
                                              style: Poppins.adminName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 330.h,
                                    width: 330.w,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: 174.h,
                                              width: 330.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          widget.lUrl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              widget.lName,
                                              style:
                                                  Poppins.farmerName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 15),
                                            child: Text(
                                              'Listing Value:'
                                              ' '
                                              '₱'
                                              ' '
                                              '${widget.lValue}',
                                              style: Poppins.userName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${widget.fName}'
                                              ' '
                                              '${widget.fLname}'
                                              ' '
                                              '(${widget.fUname})',
                                              style:
                                                  Poppins.farmerName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${widget.fBarangay}'
                                              ', '
                                              '${widget.fMunicipality}',
                                              style: Poppins.adminName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Deducted sc/s:'
                                              ' '
                                              '₱'
                                              ' '
                                              '${widget.deductFarm}',
                                              style: Poppins.adminName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Write your report here about this transaction.',
                                          style: Poppins.farmerName.copyWith(
                                            color: const Color(0xFF09041B),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: BarterDisputeTxtField(
                                          controller: controllers
                                              .farmerDisputeTextController,
                                          enabled: true,
                                          label: Text(
                                            'Report',
                                            style: Poppins.adminName.copyWith(
                                              color: const Color(0xFF09041B),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Insert your photo here:',
                                          style: Poppins.farmerName.copyWith(
                                            color: const Color(0xFF09041B),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 70, vertical: 10),
                                        child: Container(
                                          height: 360.h,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: shadow,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [

                                              //container kung asa mo display ang pic na gi upload
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                child: Container(
                                                  height: 300.h,
                                                  width: 170.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: greenDark),
                                                  ),
                                                ),
                                              ),

                                              //upload button
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                child: SizedBox(
                                                  height: 25.h,
                                                  width: 100.w,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            Color(0xFF53E78B),
                                                            Color(0xFF14BE77),
                                                          ],
                                                        ),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: shadow,
                                                            blurRadius: 2,
                                                            offset:
                                                                const Offset(
                                                                    2, 5),
                                                          ),
                                                        ]),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        disabledForegroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.38),
                                                        disabledBackgroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.12),
                                                        shadowColor:
                                                            Colors.transparent,
                                                      ),
                                                      onPressed: () {},
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 3,
                                                                bottom: 3),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Upload',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                letterSpacing:
                                                                    0.50,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 45.h,
                                    width: 330.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: greenNormal,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: shadow,
                                              blurRadius: 2,
                                              offset: const Offset(1, 3),
                                            ),
                                          ]),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          disabledForegroundColor: Colors
                                              .transparent
                                              .withOpacity(0.38),
                                          disabledBackgroundColor: Colors
                                              .transparent
                                              .withOpacity(0.12),
                                          shadowColor: Colors.transparent,
                                        ),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 3, bottom: 3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'SUBMIT',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.50,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
