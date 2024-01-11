import "package:farm_swap_mobile_final/common/colors.dart";
import "package:farm_swap_mobile_final/common/farmer_individual_details.dart";
import "package:farm_swap_mobile_final/common/get_specific_user_docid.dart";
import "package:farm_swap_mobile_final/common/poppins_text.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/database/check_email_querry.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/database/check_infarmer_email.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/darwer_sell_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_accountmanagement_buttons.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_communication.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_dashboard.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_dispute.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_farmer_review_rating.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_lisitingmanagement.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_reports.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_signout.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_swapcoins.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_wallet.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_accountmanagement.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_barter.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_buy.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_cart.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_communication.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_dashboard.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_dispute.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_reports.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_review_rating.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_swapcoins.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_wallet.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/drawer_display_userdata/drawer_consumer_displaydata.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/drawer_display_userdata/drawer_getdisplayuserdata.dart";
import "package:farm_swap_mobile_final/karl_modules/user_signup/database/add_consumerdata_db.dart";
import "package:farm_swap_mobile_final/provider/account_number_provider.dart";
import "package:farm_swap_mobile_final/provider/login_usertype_provider.dart";
import "package:farm_swap_mobile_final/routes/routes.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

/*Mao ni ang main class jud para sa drawers */

class DashBoardDrawer extends StatefulWidget {
  const DashBoardDrawer({super.key});

  @override
  State<DashBoardDrawer> createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
//Class created objects
  final GetSpecificUserDocumentId id = GetSpecificUserDocumentId();
  CheckEmailInConsumerCollection checkEmail = CheckEmailInConsumerCollection();
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  AddNewConsumerUserDb addConsumer = AddNewConsumerUserDb();
  CheckInFarmerEmail checkConsumerEmail = CheckInFarmerEmail();

  //Class local variables
  String? myEmail = FirebaseAuth.instance.currentUser?.email;
  String fName = '';
  String lname = '';
  String uname = '';
  String contact = '';
  String bplace = '';
  String fidUrl = '';
  String fprofile = '';
  String barangay = '';
  String municipal = '';
  DateTime fBday = DateTime.now();
  DateTime fRegisterDay = DateTime.now();
  bool hasTwoAccounts = false;
  bool isAlsoAFarmer = false;

  @override
  void initState() {
    super.initState();
    /*If current user is farmer, then we will get the personal details of a farmer so that we can
    use it  when farmer decides to register to a consumer account*/
    if (Provider.of<LoginUserTypeProvider>(context, listen: false)
            .getUserType ==
        'FARMER') {
      getFarmerDetails();
    } else {
      /*If user is a consumer. then we will check if he has a farmer account so that we can offer a switch account
      functionality, we do it throught this function below */
      isAlsoAfarmer();
    }
  }

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
    bool accountNumber =
        Provider.of<AccountNumberProvider>(context, listen: false)
            .isManyAccounts;

    return Drawer(
      child: (userRole == "FARMER")
          ? ListView(
              padding: const EdgeInsets.all(5),
              children: [
                /*Akong gi pull out ang profile picture, ang pangalan og ang category sa naka
                login na user gamit ang future builder */
                DrawerHeader(
                  padding: EdgeInsets.only(bottom: 10.sp),
                  child: Column(
                    children: [
                      FutureBuilder(
                        /*Kwaon nato ang document id sa atong current login user */
                        future: id.getFarmerDocumentId(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String data = snapshot.data!;
                            /*e pasa ngadto ani na class ang document id nga kwaan nato sa mga data */
                            return DrawerDisplayUserData(documentId: data);
                          } else {
                            return const Text("No data");
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await checkEmail
                                  .checkFarmerEmail(myEmail.toString()) ==
                              true) {
                            setState(() {
                              Provider.of<AccountNumberProvider>(context,
                                      listen: false)
                                  .isManyAccountNumber(true);
                              Provider.of<LoginUserTypeProvider>(context,
                                      listen: false)
                                  .setLoginUsertype("CONSUMER");
                              userRole = Provider.of<LoginUserTypeProvider>(
                                      context,
                                      listen: false)
                                  .getUserType;
                            });
                          } else {
                            showNotAConsumerMessage();
                          }
                        },
                        child: poppinsText("Switch Account", Colors.red, 12.sp,
                            FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  title: DashboardBtn(),
                ),
                const ListTile(
                  title: AccountManagementBtn(),
                ),
                const ListTile(
                  title: ListinManagement(),
                ),
                const ListTile(
                  title: MyTransactionsManagement(),
                ),
                const ListTile(
                  title: MySellingTransactionsManagement(),
                ),
                const ListTile(
                  title: MyCommunicationManagement(),
                ),
                const ListTile(
                  title: MySwapCoinsManagement(),
                ),
                const ListTile(
                  title: MyDisputeManagement(),
                ),
                const ListTile(
                  title: MyWalletManagement(),
                ),
                const ListTile(
                  title: MyFarmerReviewAndRAting(),
                ),
                const ListTile(
                  title: ReportsPages(),
                ),
                ListTile(
                  title: Signout(),
                ),
              ],
            )
          /*Drawer for consumers */
          : ListView(
              padding: EdgeInsets.all(5.sp),
              children: [
                DrawerHeader(
                  padding: EdgeInsets.only(bottom: 10.sp),
                  child: Column(
                    children: [
                      FutureBuilder(
                        /*Kwaon nato ang document id sa atong current login user */
                        future: id.getConsumerDocumentId(
                            FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            String data = snapshot.data!;
                            /*e pasa ngadto ani na class ang document id nga kwaan nato sa mga data */
                            return DrawerDisplayConsumerData(documentId: data);
                          } else {
                            return const Text("No data");
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      /*Check if the user has two accounts, only farmers has two accounts, if it has
                      then allow switching back to farmer account */
                      (accountNumber == true || isAlsoAFarmer == true)
                          ? GestureDetector(
                              onTap: () async {
                                setState(() {
                                  Provider.of<LoginUserTypeProvider>(context,
                                          listen: false)
                                      .setLoginUsertype("FARMER");
                                  userRole = Provider.of<LoginUserTypeProvider>(
                                          context,
                                          listen: false)
                                      .getUserType;
                                });
                              },
                              child: poppinsText("Switch Account", Colors.red,
                                  13.sp, FontWeight.w300),
                            )
                          : Container(),
                    ],
                  ),
                ),
                const ListTile(
                  title: ConsumerDashboardBtn(),
                ),
                const ListTile(
                  title: ConsumerAccountManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerBarterTransactionBtn(),
                ),
                const ListTile(
                  title: ConsumerBuyTransactionBtn(),
                ),
                const ListTile(
                  title: ConsumerCommunicationManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerSwapCoinsManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerCartTransactionBtn(),
                ),
                const ListTile(
                  title: ConsumerDisputeManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerWalletManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerReviewandRatingOption(),
                ),
                const ListTile(
                  title: CustomerReportsPages(),
                ),
                const Spacer(),
                ListTile(
                  title: Signout(),
                ),
              ],
            ),
    );
  }

/*Function that will alert the user that wala pa siyay consumer account og ganahan ba siya
mo register as a consumer*/
  void showNotAConsumerMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText(
            "Alert",
            Colors.red,
            20.sp,
            FontWeight.w500,
          ),
          content: poppinsText2(
            "You do not have a consumer account, please click the register button below to register as a consumer",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      addConsumer.insertConsumerData(
                        fName,
                        lname,
                        bplace,
                        contact,
                        municipal,
                        barangay,
                        uname,
                        fidUrl,
                        fprofile,
                        fBday,
                        fRegisterDay,
                        500,
                        0,
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                      displaySuccessMessage();
                    },
                    child: poppinsText(
                        "Register", Colors.green, 15.sp, FontWeight.normal),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteManager.activeDashboard);
                    },
                    child: poppinsText(
                        "Cancel", Colors.red, 15.sp, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getFarmerDetails() async {
    /*Farmer names */
    String farmerFname = await farmerDetails.getFarmerFirstname();
    String farmerLname = await farmerDetails.getLastName();
    String farmerUname = await farmerDetails.getUname();

    /*Contact details*/
    String farmercontactNum = await farmerDetails.getFarmerContactNum();

    /*Location Details */
    String farmerBarangay = await farmerDetails.getBaranggay();
    String farmerMunicipal = await farmerDetails.getMunicipalityFirstname();

    /*Other details*/
    DateTime farmerBday = await farmerDetails.getBirthDate();
    String farmerBPlace = await farmerDetails.getBirthPlace();

    /*Document urls*/
    String idUrl = await farmerDetails.getFarmerIDUrl();
    String profile = await farmerDetails.getFarmerProfileUrl();

    setState(() {
      fName = farmerFname;
      lname = farmerLname;
      uname = farmerUname;
      contact = farmercontactNum;
      barangay = farmerBarangay;
      municipal = farmerMunicipal;
      bplace = farmerBPlace;
      fBday = farmerBday;
      fidUrl = idUrl;
      fprofile = profile;
    });
  }

  /*Function that will check the email of the consumer if it is present in the  farmer collection */
  Future<void> isAlsoAfarmer() async {
    bool isFarmer = await checkConsumerEmail.checkInFarmerEmail(myEmail);
    setState(() {
      isAlsoAFarmer = isFarmer;
    });
  }

  /*Message to display when a consumer account is created*/
  void displaySuccessMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: poppinsText("Success!", Colors.blue, 20.sp, FontWeight.w500),
          content: poppinsText2(
            "Congratulations, Consumer account successfully created",
            Colors.black,
            15.sp,
            FontWeight.normal,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.activeDashboard);
                },
                child: poppinsText2(
                    "Finish", farmSwapTitlegreen, 15.sp, FontWeight.w300),
              ),
            ),
          ],
        );
      },
    );
  }
}
