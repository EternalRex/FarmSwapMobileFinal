import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/constants/typography.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/controllers/consumer/sale_dispute_controller.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/label/consumer_dispute_label.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/dispute_page/widget/textfield/sale_dispute_txtfield.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumerDisputeSale extends StatefulWidget {
  const ConsumerDisputeSale({
    super.key,
    required this.addedAmnt,
    required this.cBarangay,
    required this.cLname,
    required this.cMunicipality,
    required this.cName,
    required this.cUrl,
    required this.cUname,
    required this.deductFarm,
    required this.fBarangay,
    required this.fLname,
    required this.fMunicipality,
    required this.fName,
    required this.fUname,
    required this.fUrl,
    required this.lId,
    required this.lName,
    required this.lPrice,
    required this.lQuan,
    required this.lStatus,
    required this.lUrl,
    required this.pPrice,
    required this.pQuan,
  });

  final String addedAmnt;
  final String cBarangay;
  final String cLname;
  final String cMunicipality;
  final String cName;
  final String cUrl;
  final String cUname;
  final String deductFarm;
  final String fBarangay;
  final String fLname;
  final String fMunicipality;
  final String fName;
  final String fUrl;
  final String fUname;
  final String lName;
  final String lId;
  final String lPrice;
  final String lQuan;
  final String lStatus;
  final String lUrl;
  final String pPrice;
  final String pQuan;

  @override
  State<ConsumerDisputeSale> createState() => _ConsumerDisputeSaleState();
}

class _ConsumerDisputeSaleState extends State<ConsumerDisputeSale> {
  bool isLoading = true;

  TextEditingController disputeDateFileController = TextEditingController();

  @override
  void initState() {
    super.initState();

    disputeDateFileController.text = '';
    controllers.consumerDisputeTextController = TextEditingController();

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

  static SaleTextEditingController controllers = SaleTextEditingController();
  ConsumerDisputeLabel label = ConsumerDisputeLabel();

  @override
  void dispose() {
    controllers.consumerDisputeTextController.dispose();
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
            Navigator.of(context).pushNamed(RouteManager.consumerdisputepage);
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
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Sold Transaction Details',
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
                                    height: 320.h,
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
                                                          widget.cUrl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${widget.cName}'
                                                    ' '
                                                    '${widget.cLname}'
                                                    ' '
                                                    '(${widget.cUname})',
                                                    style: Poppins.farmerName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${widget.cBarangay}'
                                                    ', '
                                                    '${widget.cMunicipality}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'Quantity:'
                                                    ' '
                                                    '${widget.pQuan}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'Price:'
                                                    ' '
                                                    '${widget.pPrice}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 320.h,
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
                                                          widget.fUrl),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${widget.fName}'
                                                    ' '
                                                    '${widget.fLname}'
                                                    ' '
                                                    '(${widget.fUname})',
                                                    style: Poppins.farmerName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '${widget.fBarangay}'
                                                    ', '
                                                    '${widget.fMunicipality}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'Deducted sc/s:'
                                                    ' '
                                                    '${widget.deductFarm}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'Added amount:'
                                                    ' '
                                                    '${widget.addedAmnt}',
                                                    style: Poppins.adminName
                                                        .copyWith(
                                                      color: const Color(
                                                          0xFF09041B),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 320.h,
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
                                              height: 200,
                                              width: 330,
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
                                              'Quantity:'
                                              ' '
                                              '${widget.lQuan}',
                                              style: Poppins.adminName.copyWith(
                                                color: const Color(0xFF09041B),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              'Price:'
                                              ' '
                                              '₱'
                                              ' '
                                              '${widget.lPrice}',
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
                                        child: SaleDisputeTxtField(
                                          controller: controllers
                                              .consumerDisputeTextController,
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

                                      //container kung asa ma display ang uploaded pic
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
