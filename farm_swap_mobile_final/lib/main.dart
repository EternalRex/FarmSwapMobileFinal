import "package:farm_swap_mobile_final/firebase_initializations_options.dart";
import "package:farm_swap_mobile_final/provider/testprovider.dart";
import "package:farm_swap_mobile_final/provider/user_details_provider.dart";
import "package:farm_swap_mobile_final/provider/user_type_provider.dart";
import "package:farm_swap_mobile_final/routes/routes.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

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
            ChangeNotifierProvider(create: (context) => TestProvider()),
            ChangeNotifierProvider(create: (context) => UserTypeProvider()),
            ChangeNotifierProvider(create: (context) => UserDetailsProvider()),
          ],
          builder: (context, child) {
            return const MaterialApp(
              initialRoute: RouteManager.usersignup,
              onGenerateRoute: RouteManager.generateRoute,
            );
          },
        );
      },
    );
  }
}
