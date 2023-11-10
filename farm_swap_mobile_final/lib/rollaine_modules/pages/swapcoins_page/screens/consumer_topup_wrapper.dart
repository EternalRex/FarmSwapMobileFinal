import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/database/consumer_swapcoins_db.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/widgets/consumer_swapcoins_txtfield.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/widgets/consumer_swapcoins_update.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/widgets/balance/consumer_check_balance.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          //capture the context by naming currentContext
          final currentContext = context;

          //this will allow to enter swapcoins
          showDialog(
            context: currentContext,
            builder: (context) {
              return AlertDialog(
                title: const Text('Top Up Swap Coins'),
                content: Row(
                  children: [
                    const Text('Enter Swap Coins : '),
                    ConsumerSwapCoinsTextfield(
                        controller: amountController, enabled: true),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Proceed'),
                    onPressed: () async {
                      Navigator.of(context).pop();

                      //check the balance before it updates the swapcoins
                      // Retrieve the balance from Firestore by calling the function getBalanceFromFirestore
                      final balance = await checkBalance.getConsumerBalance();

                      //parsing the amountController.text into double
                      final topupSwapCoins =
                          double.parse(amountController.text);

                      //if balance is greater than or equal to topup swapcoins then the dialog for success will show
                      if (balance >= topupSwapCoins) {
                        //this will update the balance as well as the swapcoins in the firestore
                        await swapcoins.updateConsumerSwapCoins(topupSwapCoins);

                        //create a swapcoins logs for the swapcoins history
                        swapcoinsLogs.createConsumerSwapcoinsLogs(
                            FirebaseAuth.instance.currentUser!.uid,
                            'CONSUMER',
                            DateTime.now(),
                            'COMPLETED',
                            topupSwapCoins);

                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Successful'),
                              content: const Text(
                                  'You have successfully top up your swapcoins!'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(
                                          RouteManager.consumerswapcoins),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      //if balance is lesser than the topup swapcoins then the dialog for insufficient will show
                      else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
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
                  )
                ],
              );
            },
          );
        },
        icon: const Icon(
          Icons.add_box_rounded,
          color: Color(0xFF15be77),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        label: Text(
          'Top Up',
          style: TextStyle(
            color: Colors.black,
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
