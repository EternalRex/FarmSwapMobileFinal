// ignore_for_file: use_build_context_synchronously
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/checkBalance_Class.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/swap_coins_management/widgets/SwapCoinsDetailsFarmer_Class.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../swapCoins_Logs_database/swapcoins_logs_db.dart';
import '../widgets/swapcoins_textfield.dart';
import '../widgets/update_SwapCoins_Class.dart';

class TopUpButton extends StatelessWidget {
  const TopUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creating instances for the classes CheckBalance, UpdateSwapCoins, and SwapCoinsLogsInsertDataDb
    CheckBalance checkBalance = CheckBalance();
    UpdateSwapCoins swapcoins = UpdateSwapCoins();
    SwapCoinsLogsInsertDataDb swapcoinsLogs = SwapCoinsLogsInsertDataDb();

    TextEditingController amountController = TextEditingController();
    SwapCoinsDetailsFarmer farmerDetails = SwapCoinsDetailsFarmer();

    // the _handleTopUp is asynchronous and doesn't return a value (void).
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _handleTopUp() async {
      // Retrieve the location information
      Map<String, String> address = await farmerDetails.getFarmerAddress();
      String barangay = address["city_baranggay"]!;
      String municipality = address["city_municipality"]!;
      // Capture the context by naming currentContext
      final currentContext = context;

      // This will allow entering swapcoins
      showDialog(
        context: currentContext,
        builder: (context) {
          return AlertDialog(
            title: const Text("Top Up Swap Coins"),
            content: Row(
              children: [
                const Text("Enter SwapCoins : "),
                SwapCoinsTextField(
                  controller: amountController,
                  enabled: true,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Proceed"),
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the second AlertDialog

                  // Check the balance before updating the swapcoins
                  // Retrieve the balance from Firestore by calling the function getBalanceFromFirestore
                  final balance = await checkBalance.getBalanceFromFirestore();
                  // Parsing the amountController.text into double
                  final topupSwapCoins = double.parse(amountController.text);

                  // If the balance is greater than or equal to topup swap coins, the dialog for success will show
                  if (balance >= topupSwapCoins) {
                    // This will update the balance as well as the swapcoins in the firestore
                    await swapcoins.updateBalanceSwapCoins(topupSwapCoins);

                    // Create a createSwapcoinsLogs for the swapcoins history
                    await swapcoinsLogs.createSwapcoinsLogs(
                      FirebaseAuth.instance.currentUser!.uid,
                      "FARMER",
                      await farmerDetails.getFarmerFirstname(),
                      await farmerDetails.getFarmerLastname(),
                      "$barangay, $municipality",
                      await farmerDetails.getFarmerProfile(),
                      DateTime.now(),
                      "COMPLETED",
                      topupSwapCoins,
                    );

                    showDialog(
                      context: currentContext,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Successful'),
                          content: const Text(
                              'You successfully top up your swapcoins!'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(RouteManager.farmerswapcoins),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  // If the balance is lesser than the topup swap coins, the dialog for insufficient will show
                  else {
                    // Create a createSwapcoinsLogs for the swapcoins history
                    await swapcoinsLogs.createSwapcoinsLogs(
                      FirebaseAuth.instance.currentUser!.uid,
                      "FARMER",
                      await farmerDetails.getFarmerFirstname(),
                      await farmerDetails.getFarmerLastname(),
                      "$barangay, $municipality",
                      await farmerDetails.getFarmerProfile(),
                      DateTime.now(),
                      "FAILED",
                      topupSwapCoins,
                    );
                    showDialog(
                      context: currentContext,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Insufficient Balance'),
                          content: const Text(
                              'You do not have enough balance to top up your swapcoins. Please try again!'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              TextButton(
                child: const Text("Close"),
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the second AlertDialog
                },
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: ElevatedButton.icon(
        onPressed: _handleTopUp,
        icon: const Icon(
          Icons.add_box_rounded,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        label: Text(
          'Top Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w900,
            height: 0,
            letterSpacing: 0.50,
          ),
        ),
      ),
    );
  }
}
