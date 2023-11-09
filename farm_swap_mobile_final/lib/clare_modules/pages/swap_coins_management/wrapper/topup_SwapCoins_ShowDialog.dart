// ignore_for_file: use_build_context_synchronously

import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/checkBalance_Class.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/swap_coins_management/swapCoins_Logs_database/swapcoins_logs_db.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/swapcoins_textfield.dart';
import '../widgets/update_SwapCoins_Class.dart';

class TopUpButton extends StatelessWidget {
  const TopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    //creating an instance for the class checkbalance
    CheckBalance checkBalance = CheckBalance();

    //creating an instance for the class updateswapcoins
    UpdateSwapCoins swapcoins = UpdateSwapCoins();

    //Object for the admin logs model used to save admin logs to db
    SwapCoinsLogsInsertDataDb swapcoinsLogs = SwapCoinsLogsInsertDataDb();
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          // Capture the context by naming currentContext
          final currentContext = context;

          //this will allow to enter swapcoins
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
                      Navigator.of(context)
                          .pop(); // Close the second AlertDialog

                      //check the balance before it updates the swapcoins
                      // Retrieve the balance from Firestore by calling the function getBalanceFromFirestore
                      final balance =
                          await checkBalance.getBalanceFromFirestore();
                      //parsing the amounControllet.text into double
                      final topupSwapCoins =
                          double.parse(amountController.text);
                      //if balance is greater than or equal to topup swap coins then the dialog for success will show
                      if (balance >= topupSwapCoins) {
                        //this will update the balance as well as the swapcoins in the firestore
                        await swapcoins.updateBalanceSwapCoins(topupSwapCoins);

                        // Create an createSwapcoinsLogs for the swapcoins history
                        swapcoinsLogs.createSwapcoinsLogs(
                            FirebaseAuth.instance.currentUser!.uid,
                            "FARMER",
                            DateTime.now(),
                            "COMPLETED",
                            topupSwapCoins);

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

                      //if balance is lesser than the topup swap coins then the dialog for insufficient will show
                      else {
                        showDialog(
                          context: currentContext,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Insufficient Balance'),
                              content: const Text(
                                  'You do not have enough balance to cash out this amount. Please try again!'),
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
                ],
              );
            },
          );
        },
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
