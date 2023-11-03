import "package:farm_swap_mobile_final/firebase_initializations_options.dart";
import "package:farm_swap_mobile_final/provider/all_listing_type_provder.dart";
import "package:farm_swap_mobile_final/provider/barter_listing_details_provider.dart";
import "package:farm_swap_mobile_final/provider/listing_addcategory_provider.dart";
import "package:farm_swap_mobile_final/provider/listing_page_provider.dart";
import "package:farm_swap_mobile_final/provider/login_usertype_provider.dart";
import 'package:farm_swap_mobile_final/provider/farmer_accountstatus_provider.dart';
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
            /*Provider para malaman nato unsay  status sa account ni farmer */
            ChangeNotifierProvider(
              create: (context) => FarmerAccounStatusProvider(),
            ),
            /*Provider para malaman nato unsa na klase na user ang ni register */
            ChangeNotifierProvider(
              create: (context) => UserTypeProvider(),
            ),
            /*Provider para ma isa natog save sa last part sa user registration ang iyang
            mga gi input na data */
            ChangeNotifierProvider(
              create: (context) => UserDetailsProvider(),
            ),
            ChangeNotifierProvider(create: (context) => LoginUserTypeProvider()),
            /*provdier para malaman nato og what time of user ang ni login */
            ChangeNotifierProvider(
              create: (context) => LoginUserTypeProvider(),
            ),
            /*Provider ni para sa pag switch og pages*/
            ChangeNotifierProvider(
              create: (context) => ListingPageProvider(),
            ),
            /*Registering povider for update farmer details account dropdown hint */
            ChangeNotifierProvider(
              create: (context) => UpdateDropDownHint(),
            ),
            ChangeNotifierProvider(create: (contex) => AddListingCategoryProvider()),
            /*Provider na mag carry sa details sa listing nga for sale aron ma isa ra 
            og save sa last part sa creating a listing */
            ChangeNotifierProvider(
              create: (context) => SellListingDetailsProvider(),
            ),
            /*Provider na mag carry sa details sa listing nga for barter aron ma isa ra 
            og save sa last part sa creating a listing */
            ChangeNotifierProvider(
              create: (context) => BarterListingDetailsProvider(),
            ),
            /*Provider nga mag determine unsa na listing ang e display sa all listing
            display ni farmer */
            ChangeNotifierProvider(
              create: (context) => AllListingTypeProvider(),
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
