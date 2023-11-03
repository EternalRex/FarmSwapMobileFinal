import "package:farm_swap_mobile_final/common/get_specific_user_docid.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/darwer_sell_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_accountmanagement_buttons.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_communication.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_dispute.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_lisitingmanagement.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_signout.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_swapcoins.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_wallet.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_accountmanagement.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_barter.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_buy.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_cart.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_communication.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_dispute.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_swapcoins.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashboard_consumer_drawer_widgets/drawer_consumer_wallet.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/drawer_display_userdata/drawer_consumer_displaydata.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/drawer_display_userdata/drawer_getdisplayuserdata.dart";
import "package:farm_swap_mobile_final/provider/login_usertype_provider.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/*Mao ni ang main class jud para sa drawers */

class DashBoardDrawer extends StatelessWidget {
  DashBoardDrawer({super.key});

/*Instance of the class that will get a specific document id*/
  final GetSpecificUserDocumentId id = GetSpecificUserDocumentId();

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<LoginUserTypeProvider>(context, listen: false).getUserType;
    return Drawer(
      child: (userRole == "FARMER")
          ? ListView(
              padding: const EdgeInsets.all(5),
              children: [
                /*Akong gi pull out ang profile picture, ang pangalan og ang category sa naka
                login na user gamit ang future builder */
                DrawerHeader(
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
                    ],
                  ),
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
                ListTile(
                  title: Signout(),
                ),
              ],
            )
          : ListView(
              padding: const EdgeInsets.all(5),
              children: [
                DrawerHeader(
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
                    ],
                  ),
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
                  title: ConsumerDisputeManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerWalletManagementBtn(),
                ),
                const ListTile(
                  title: ConsumerCartManagementBtn(),
                ),
                const Spacer(),
                ListTile(
                  title: Signout(),
                ),
              ],
            ),
    );
  }
}
