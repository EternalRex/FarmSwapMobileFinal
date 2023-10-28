import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/darwer_sell_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_accountmanagement_buttons.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_communication.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_dispute.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_lisitingmanagement.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_signout.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_swapcoins.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_transactions.dart";
import "package:farm_swap_mobile_final/karl_modules/dashboard/widgets/dashbiard_drawer_widgets/drawer_wallet.dart";
import "package:flutter/material.dart";

class DashBoardDrawer extends StatelessWidget {
  const DashBoardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: const [
          DrawerHeader(
            child: Text("Header"),
          ),
          ListTile(
            title: AccountManagementBtn(),
          ),
          ListTile(
            title: ListinManagement(),
          ),
          ListTile(
            title: MyTransactionsManagement(),
          ),
          ListTile(
            title: MySellingTransactionsManagement(),
          ),
          ListTile(
            title: MyCommunicationManagement(),
          ),
          ListTile(
            title: MySwapCoinsManagement(),
          ),
          ListTile(
            title: MyDisputeManagement(),
          ),
          ListTile(
            title: MyWalletManagement(),
          ),
          ListTile(
            title: Signout(),
          ),
        ],
      ),
    );
  }
}
