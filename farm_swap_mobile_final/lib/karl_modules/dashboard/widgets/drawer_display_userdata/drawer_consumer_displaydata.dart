import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/consumer_notif_bid/provider/consumer_notif_provider.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/consumer_notif_bid/screen/consumer_notif_bid.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider("${data["profilePhoto"]}"),
                radius: 60.w,
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
                    height: 5.sp,
                  ),
                  poppinsText(
                    "${data["contactnum"]}",
                    Colors.black,
                    12.sp,
                    FontWeight.w700,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  poppinsText(
                    "${data["userRole"]}",
                    Colors.black,
                    10.sp,
                    FontWeight.w700,
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ConsumerNotificationProvider>(context,
                              listen: false)
                          .decrementNotif();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const ConsumerNotificationsBid(),
                        ),
                      );
                    },
                    child: Container(
                      width: 100.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        /*PUTTING BOX SHADOW ON THE CONTAINER */
                        boxShadow: [
                          BoxShadow(
                            color: shadow,
                            blurRadius: 2,
                            offset: const Offset(1, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidBell,
                                size: 20.sp,
                                color: Colors.green,
                              ),
                              Positioned(
                                right: 0,
                                child: Consumer<ConsumerNotificationProvider>(
                                  builder: (context, value, child) {
                                    String notifCount = value.getNotifNum();
                                    print("notif : $notifCount");
                                    return Text(
                                      notifCount,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Notifications",
                            style:
                                TextStyle(fontSize: 11.sp, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
