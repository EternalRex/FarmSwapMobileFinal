import "package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/consumer_notif_bid/provider/consumer_notif_provider.dart";
import "package:farm_swap_mobile_final/clare_modules/pages/user_notification_bid/farmer_notif_bid/provider/farmer_notif_provider.dart";
import "package:farm_swap_mobile_final/firebase_initializations_options.dart";
import "package:farm_swap_mobile_final/provider/barter_listing_details_provider.dart";
import "package:farm_swap_mobile_final/provider/bartering_item_details_provider.dart";
import "package:farm_swap_mobile_final/provider/completed_bartertransaction_provider.dart";
import "package:farm_swap_mobile_final/provider/dashboard_type_provider.dart";
import "package:farm_swap_mobile_final/provider/farmer_profile_visits_report_provider.dart";
import "package:farm_swap_mobile_final/provider/listing_addcategory_provider.dart";
import "package:farm_swap_mobile_final/provider/listing_page_provider.dart";
import "package:farm_swap_mobile_final/provider/login_usertype_provider.dart";
import 'package:farm_swap_mobile_final/provider/farmer_accountstatus_provider.dart';
import "package:farm_swap_mobile_final/provider/selected_barter_bid_provider.dart";
import "package:farm_swap_mobile_final/provider/sell_listing_details_provider.dart";
import "package:farm_swap_mobile_final/provider/user_details_provider.dart";
import "package:farm_swap_mobile_final/provider/user_type_provider.dart";
import "package:farm_swap_mobile_final/routes/routes.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";
import "karl_modules/dashboard/screens/account_management_farmer/provider/update_dropdown.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          /*Registering all the providers being used */
          providers: [
            ChangeNotifierProvider(
                create: (context) => FarmerAccounStatusProvider()),
            ChangeNotifierProvider(create: (context) => UserTypeProvider()),
            ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
            ChangeNotifierProvider(
                create: (context) => LoginUserTypeProvider()),
            ChangeNotifierProvider(
                create: (context) => LoginUserTypeProvider()),
            ChangeNotifierProvider(create: (context) => ListingPageProvider()),
            /*Registering povider for update farmer details account dropdown hint */
            ChangeNotifierProvider(
              create: (context) => UpdateDropDownHint(),
            ),
            /*Provider that will carry the category of the listing to be addedd */
            ChangeNotifierProvider(
              create: (contex) => AddListingCategoryProvider(),
            ),
            /*Provider that carries the data of during selling listing creating to be saved at the end if the process */
            ChangeNotifierProvider(
              create: (context) => SellListingDetailsProvider(),
            ),
            /*Provider that carries the data of during barter listing creating to be saved at the end if the process */
            ChangeNotifierProvider(
              create: (context) => BarterListingDetailsProvider(),
            ),
            /*This provider is about the type of dashboard to display, either for barter, for selling or for best deals */
            ChangeNotifierProvider(
              create: (context) => DashboardTypeProvider(),
            ),
            /*This provider is about the details selected listing that the consumer wants to barter*/
            ChangeNotifierProvider(
              create: (context) => BartertingItemDetailsProvider(),
            ),
            /*This provider is used when a bid is selected by the farmer */
            ChangeNotifierProvider(
              create: (context) => SelectedBarterBidProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CompletedTransactionProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => FarmerNotificationProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ConsumerNotificationProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) {
                FarmerProfileVisitsProvider();
              },
            ),
          ],
          builder: (context, child) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RouteManager.userloginselection,
              onGenerateRoute: RouteManager.generateRoute,
            );
          },
        );
      },
    );
  }
}
