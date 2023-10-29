import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*E access niya ang data from the sample_ConsumerUsers gamit ang value sa document id na gipasa
sa constructor. nya iya e display ang data na iya na pullout */

class DrawerDisplayConsumerData extends StatefulWidget {
  const DrawerDisplayConsumerData({super.key, required this.documentId});

  final String documentId;

  @override
  State<DrawerDisplayConsumerData> createState() =>
      _DrawerDisplayConsumerDataState();
}

class _DrawerDisplayConsumerDataState extends State<DrawerDisplayConsumerData> {
  @override
  Widget build(BuildContext context) {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("sample_ConsumerUsers");

    return FutureBuilder(
      future: reference.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider("${data["profilePhoto"]}"),
                    radius: 70.w,
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Column(
                    children: [
                      poppinsText(
                        "${data["userName"]}",
                        Colors.black,
                        20.sp,
                        FontWeight.w700,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      poppinsText(
                        "${data["contactnum"]}",
                        Colors.black,
                        12.sp,
                        FontWeight.w700,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      poppinsText(
                        "${data["userRole"]}",
                        Colors.black,
                        10.sp,
                        FontWeight.w700,
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
