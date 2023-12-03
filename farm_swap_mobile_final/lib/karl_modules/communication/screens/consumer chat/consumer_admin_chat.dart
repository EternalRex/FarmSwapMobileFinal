import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/screens/consumer%20chat/consumer_admin_actual_chat.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/widgets/chat_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsumerAdminChat extends StatefulWidget {
  const ConsumerAdminChat({super.key});

  @override
  State<ConsumerAdminChat> createState() => _ConsumerAdminChatState();
}

class _ConsumerAdminChatState extends State<ConsumerAdminChat> {
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
              image: const AssetImage("assets/karl_assets/images/appbarpattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        title: const Text("Admin Chat"),
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
        padding: EdgeInsets.only(top: 2.sp),
        child: _buildUserList(),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('AdminUsers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView(
              /*We are getting all the list of documents in the firebase, and each document like one
              by one, the documents will passed to the _buildUserListItems */
              children: snapshot.data!.docs
                  .map<Widget>((document) => _buildUserListItems(document))
                  .toList(),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildUserListItems(DocumentSnapshot document) {
    /*We are accessing a document that was passed here one by one, and map it into 
    String and dynamic, to look the same in the firebase strcuture */
    Map<String, dynamic> users = document.data() as Map<String, dynamic>;
    bool isOnline = users["Online"];
    String adminUrl = users['profileUrl'];
    String adminFname = users['First Name'];
    String adminId = users['User Id'];
    String adminEmail = users['Email Address'];
/*Only the specific account searched will display*/

    /*The actual display and styling is done here inside the listile */
    return ListTile(
      /*Pull outing the data from the firestore document and designing how it will look in the ui*/
      title: Container(
        width: 200.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
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
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: CircleAvatar(
                backgroundImage: NetworkImage(adminUrl),
                radius: 30,
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            SizedBox(
              width: 50,
              child: ChatAllDisplayUserTexts(text: "${users["First Name"]}"),
            ),
            const SizedBox(
              width: 13,
            ),
            (isOnline == true)
                ? Text(
                    "Online",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                : Text(
                    "Offline",
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.red,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
          ],
        ),
      ),
      /*When tapping that particular row of user we will send that users id and email
        address to the next screen which is the AsminActual Screen */
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ConsumerAdminActualChat(
                  adminId: adminId,
                  adminUname: adminFname,
                  adminProfUrl: adminUrl,
                  adminEmail: adminEmail);
            },
          ),
        );
      },
    );
  }
}
