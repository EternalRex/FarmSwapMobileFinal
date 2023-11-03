// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../widgets/sub_header_pendingtransaction.dart';
import '../widgets/title_header_pendingtransaction.dart';

class DisplayWalletData extends StatefulWidget {
  const DisplayWalletData({super.key, required this.documentId});

  final String documentId;

  @override
  State<DisplayWalletData> createState() => _DisplayWalletDataState();
}

class _DisplayWalletDataState extends State<DisplayWalletData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_FarmerUsers");

    return FutureBuilder(
      future: reference.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          final profileImage =
              CachedNetworkImageProvider("${data["profilePhoto"]}");

          Timestamp datatimestamp = data["birthdate"];
          DateTime birthdate = datatimestamp.toDate();
          String finalBirthdate = DateFormat('yyy-MM-dd').format(birthdate);

          Timestamp datatimestampreg = data["registrationDate"];
          DateTime registerdate = datatimestampreg.toDate();
          String finalRegisterDate =
              DateFormat('yyy-MM-dd').format(registerdate);

          return Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              /*
              */
              Center(
                child: SizedBox(
                  width: 325.w,
                  height: 120.h,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'BALANCE : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55.h,
                      ),
                      Text(
                        "P ${data["swapcoins"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              /**
               * this row kay naay container sa cash in and cash out
               * if iclicked and cash in then naay dialog box mogawas
               * then if ang cash out naa say dialog box mogawas
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //the first gesture detector kay para sa cash in button
                  GestureDetector(
                    child: Container(
                      width: 144,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 20,
                            offset: Offset(6, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Cash In',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  //the second gesture detector kay para sa cash out button
                  GestureDetector(
                    child: Container(
                      width: 144,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 20,
                            offset: Offset(6, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Cash Out',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w900,
                            height: 0,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              /**
               * this center kay nag consist sa header para sa transactions
               * then diri makita ang transactions if pending or completed na
               * then maka search sa lists of transaction and if i click
               * ang specific list tile naay mugawas dialog box para sa transaction details
               */
              Center(
                child: Column(
                  children: [
                    //header sa pending transactions
                    const TitleHeaderPendingTransact(),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: 350.w,
                      height: 350.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 10,
                            offset: Offset(3, 2),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          //header sa information na i display
                          const SubHeaderPendingTransaction(),
                          SizedBox(
                            height: 10.h,
                          ),
                          //lists of pending transactions here must be scrollable
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
