import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/chat_input_txtfield.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/farmer_consumer_chatbubble.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/database/admin_farmer_chat_querry.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FarmerAdminActualChat extends StatefulWidget {
  const FarmerAdminActualChat({
    super.key,
    required this.adminId,
    required this.adminUname,
    required this.adminProfUrl,
    required this.adminEmail,
  });

  final String adminId;
  final String adminUname;
  final String adminProfUrl;
  final String adminEmail;

  @override
  State<FarmerAdminActualChat> createState() => _FarmerAdminActualChatState();
}

class _FarmerAdminActualChatState extends State<FarmerAdminActualChat> {
  /*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

/*Chat text editing controller */
  TextEditingController chatController = TextEditingController();
  FarmerAdminChatQuerry chatQuery = FarmerAdminChatQuerry();

  /*Function that sends a message*/
  void sendMessage() async {
    print("mao ni consumer id ${widget.adminId}");
    String message = chatController.text;
    await chatQuery.sendMessage(
        FirebaseAuth.instance.currentUser!.uid, widget.adminId, widget.adminEmail, message);
    chatController.clear();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.adminProfUrl),
                radius: 25.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              poppinsText(
                widget.adminUname,
                Colors.white,
                17.sp,
                FontWeight.w300,
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              /*Opening the drawer */
              openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          actions: [
            /*Shoppping cart button */
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  print("Wa na focus");
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                iconSize: 30.sp,
              ),
            ),
          ],
        ),
        drawer: const DashBoardDrawer(),
        body: Column(
          children: [
            /*Expanded that will contain the messages */
            Expanded(
              flex: 7,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100.h,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: buildUserMessageList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Expanded that will contain the input field */
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: buildMessageInput(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: ChatInputTxtField(controller: chatController, hintText: "Enter message....")),
        const SizedBox(
          width: 7,
        ),
        CircleAvatar(
          backgroundColor: farmSwapTitlegreen,
          child: IconButton(
            onPressed: () {
              print("Message sent");
              sendMessage();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /*This method will acess the documents all the documents in the ChatRooms collection the 
actual qurry is in the querry class*/
  Widget buildUserMessageList() {
    return StreamBuilder(
      stream: chatQuery.getChatMessages(FirebaseAuth.instance.currentUser!.uid, widget.adminId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((document) => accessDocumentContents(document))
                  .toList(),
            );
          } else {
            return const Text("Error");
          }
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

/*This methods access the properties and its value of each document that is baing passed here*/
  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var messageAlignment = (data["senderId"] != FirebaseAuth.instance.currentUser!.uid)
        ? Alignment.topLeft
        : Alignment.topRight;

    /*Converting the date into string*/
    Timestamp timeSTMP = data["messageTime"];
    DateTime dateTime = timeSTMP.toDate();
    String finalDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return Container(
      alignment: messageAlignment,
      child: Column(
        crossAxisAlignment: (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(
            finalDate,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
          (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
              ? FarmerConsumerSenderChatBubble(content: data["messageContent"])
              : FarmerConsumerReceiverChatBubble(content: data["messageContent"])
        ],
      ),
    );
  }
}
