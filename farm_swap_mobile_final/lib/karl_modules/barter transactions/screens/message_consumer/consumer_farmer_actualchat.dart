import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/database/farmer_notif_query.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/farmer_notif_bid/provider/farmer_notif_provider.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/consumer_profile_photoQuery.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/farmer_consumer_chat_query.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/database/farmer_profile_photquery.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/chat_input_txtfield.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/widgets/farmer_consumer_chatbubble.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConsumerFarmerActualChat extends StatefulWidget {
  const ConsumerFarmerActualChat({
    super.key,
    required this.farmerId,
    required this.farmerName,
    required this.farmerUname,
    required this.farmerBarangay,
    required this.farmerMunicipality,
    required this.consumerId,
    required this.consumerFname,
    required this.consumerLname,
    required this.consumerUname,
    required this.consumerBarangay,
    required this.consumerMunicipality,
    required this.listingId,
    required this.listingName,
  });

  final String farmerId;
  final String farmerName;
  final String farmerUname;
  final String farmerBarangay;
  final String farmerMunicipality;

  final String consumerId;
  final String consumerFname;
  final String consumerLname;
  final String consumerUname;
  final String consumerBarangay;
  final String consumerMunicipality;

  final String listingName;
  final String listingId;

  @override
  State<ConsumerFarmerActualChat> createState() =>
      _ConsumerFarmerActualChatState();
}

class _ConsumerFarmerActualChatState extends State<ConsumerFarmerActualChat> {
/*Creating a scafoold key so that we can open a drawer that is built from another class */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*A function for opening a drawer using the scaffold key */
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

/*Chat text editing controller */
  TextEditingController chatController = TextEditingController();

/*Instance of other classes */
  FarmerConsumerChatQuery chatQuery = FarmerConsumerChatQuery();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  ConsumerProfilePhotQuerry consumerPhoto = ConsumerProfilePhotQuerry();
  FarmerProfilePhotoQuerry farmerPhoto = FarmerProfilePhotoQuerry();
  FarmerNotificationQuerry farmernotif = FarmerNotificationQuerry();
  String senderId = FirebaseAuth.instance.currentUser!.uid;

  /*Properites-variables */
  String farmerProfileUrl = "";
  String consumerProfileUrl = "";

/*Function that sends a message*/
  void sendMessage() async {
    print("mao ni consumer id ${widget.consumerId}");
    String message = chatController.text;
    await chatQuery.sendMessageConsumer(
        widget.farmerId, widget.listingId, message);
    chatController.clear();
  }

  @override
  void initState() {
    super.initState();
    getFarmerProfilePic();
    //buildUserMessageList();
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
                image: const AssetImage(
                    "assets/karl_assets/images/appbarpattern.png"),
                fit: BoxFit.cover,
                scale: 100.0.sp,
              ),
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(farmerProfileUrl),
                radius: 25.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              poppinsText(
                widget.farmerUname,
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
                  unfocus();
                  Navigator.pop(context);
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
            child: ChatInputTxtField(
                controller: chatController, hintText: "Enter message....")),
        const SizedBox(
          width: 7,
        ),
        CircleAvatar(
          backgroundColor: farmSwapTitlegreen,
          child: IconButton(
            onPressed: () {
              print("Message sent");
              sendMessage();
              //NOTIFICATION FOR ACCEPT BID
              farmernotif.sendNotification(
                senderId,
                widget.farmerId,
                "You have a message from",
                widget.consumerFname,
                widget.consumerLname,
                DateTime.now(),
                "MESSAGE",
              );
              Provider.of<FarmerNotificationProvider>(context, listen: false)
                  .setIncrement(widget.farmerId);
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
      stream: chatQuery.getChatMessages(
          widget.farmerId, FirebaseAuth.instance.currentUser!.uid),
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
    var messageAlignment =
        (data["senderId"] != FirebaseAuth.instance.currentUser!.uid)
            ? Alignment.topLeft
            : Alignment.topRight;

    /*Converting the date into string*/
    Timestamp timeSTMP = data["time"];
    DateTime dateTime = timeSTMP.toDate();
    String finalDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return Container(
      alignment: messageAlignment,
      child: Column(
        crossAxisAlignment:
            (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        mainAxisAlignment:
            (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: [
          Text(
            finalDate,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
          (data["senderId"] == FirebaseAuth.instance.currentUser!.uid)
              ? FarmerConsumerSenderChatBubble(content: data["content"])
              : FarmerConsumerReceiverChatBubble(content: data["content"])
        ],
      ),
    );
  }

/*Mga functions rani nga mag pull out sa profile url sa consumer*/
  Future<void> getFarmerProfilePic() async {
    print("Mao ni farmer id ${widget.farmerId}");
    String profileUrl =
        await farmerPhoto.getFarmerProfilePhoto(widget.farmerId);
    setState(() {
      farmerProfileUrl = profileUrl;
    });
  }

  Future<void> getProfilePic() async {
    String profileUrl =
        await consumerPhoto.getConsumerProfilePhoto(widget.consumerId);
    print("mao ni profile url $profileUrl");
    setState(() {
      consumerProfileUrl = profileUrl;
    });
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }
}
