// ignore_for_file: use_build_context_synchronously

import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/database/consumer_swapcoins_db.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/widgets/consumer_swapcoins_txtfield.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/widgets/consumer_swapcoins_update.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/widgets/balance/consumer_check_balance.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/SwapCoinsDetailsConsumer_Class.dart';

class ConsumerTopUpPage extends StatelessWidget {
  const ConsumerTopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    //creating an instance for the class consumer check balance
    ConsumerCheckBalance checkBalance = ConsumerCheckBalance();

    //creating an instance for the class consumer update swapcoins
    UpdateConsumerSwapCoins swapcoins = UpdateConsumerSwapCoins();

    //object for the swapcoins logs model used to save swapcoins logs to db
    ConsumerSwapCoinsLogsDb swapcoinsLogs = ConsumerSwapCoinsLogsDb();

    //object for the swapcoins logs model used to save swapcoins logs to db
    SwapCoinsDetailsConsumer consumerDetails = SwapCoinsDetailsConsumer();

    // the _handleTopUp is asynchronous and doesn't return a value (void).
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _handleTopUp() async {
      // Retrieve the address information
      Map<String, String> address = await consumerDetails.getConsumerAddress();
      String barangay = address["baranggay"]!;
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
                ConsumerSwapCoinsTextfield(
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
                  final balance = await checkBalance.getConsumerBalance();
                  // Parsing the amountController.text into double
                  final topupSwapCoins = double.parse(amountController.text);

                  // If the balance is greater than or equal to topup swap coins, the dialog for success will show
                  if (balance >= topupSwapCoins) {
                    // This will update the balance as well as the swapcoins in the firestore
                    await swapcoins.updateConsumerSwapCoins(topupSwapCoins);

                    // Create a createSwapcoinsLogs for the swapcoins history
                    await swapcoinsLogs.createConsumerSwapcoinsLogs(
                      FirebaseAuth.instance.currentUser!.uid,
                      "CONSUMER",
                      await consumerDetails.getConsumeFirstname(),
                      await consumerDetails.getConsumeLastname(),
                      "$barangay, $municipality",
                      await consumerDetails.getConsumerProfile(),
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
                                  .pushNamed(RouteManager.consumerswapcoins),
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
                    await swapcoinsLogs.createConsumerSwapcoinsLogs(
                      FirebaseAuth.instance.currentUser!.uid,
                      "CONSUMER",
                      await consumerDetails.getConsumeFirstname(),
                      await consumerDetails.getConsumeLastname(),
                      "$barangay, $municipality",
                      await consumerDetails.getConsumerProfile(),
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
