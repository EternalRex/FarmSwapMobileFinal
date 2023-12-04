import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/database/farmer_notif_query.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/active_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FarmerNotificationsBid extends StatefulWidget {
  const FarmerNotificationsBid({super.key});

  @override
  State<FarmerNotificationsBid> createState() => _FarmerNotificationsBidState();
}

class _FarmerNotificationsBidState extends State<FarmerNotificationsBid> {
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
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                  "assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        title: const Text("Notifications"),
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: _buildNotificationLists(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ActiveDashboard(),
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        backgroundColor: greenNormal,
        splashColor: greenLight,
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

FarmerNotificationQuerry notif = FarmerNotificationQuerry();

/*Method taht will get every document in the AdminNotification collection and display its
contentts in a list view */
Widget _buildNotificationLists() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collectionGroup('farmernotifications')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: greenNormalHover,
            ),
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        final logs = snapshot.data!.docs;

        if (logs.isEmpty) {
          return const Center(
            child: Text('No notifications available!'),
          );
        }

        // This will sort the documents based on the 'dateTime' field
        logs.sort((a, b) {
          var dateTimeA = a['notifDate'];
          var dateTimeB = b['notifDate'];

          //This will check if the dateTime field is a Timestamp and convert to DateTime
          if (dateTimeA is Timestamp) {
            dateTimeA = dateTimeA.toDate();
          }

          if (dateTimeB is Timestamp) {
            dateTimeB = dateTimeB.toDate();
          }
          // this will perform the descending order base on the date and its time
          return (dateTimeB as DateTime).compareTo(dateTimeA as DateTime);
        });

        return ListView(
          children: logs.map<Widget>((document) {
            return _accessItemList(document);
          }).toList(),
        );
      }
    },
  );
}

/*Method that will accesss every item of the document being passed here */
Widget _accessItemList(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //Converting the date into a string
  Timestamp timestamp = data["notifDate"];
  DateTime dateTime = timestamp.toDate();

  String finalTime = DateFormat('MMMM dd,yyyy').format(dateTime);
  // ignore: unused_local_variable
  String senderId = data["notifSenderId"];
  String receiverId = data["notifReceiverId"];
  String senderfirstname = data["senderFName"];
  String senderlastname = data["senderLName"];
  String farmerId = FirebaseAuth.instance.currentUser!.uid;

  if (receiverId == farmerId) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          /*PUTTING BOX SHADOW ON THE CONTAINER */
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 2,
              offset: const Offset(1, 5),
            ),
          ],
        ),
        /*Displaying the details */
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Text(
                    finalTime,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Text(
                          data["notifMessage"],
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      //name of consumer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Text(
                              "Consumer $senderfirstname ",
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              senderlastname,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  } else {
    return Container();
  }
}
