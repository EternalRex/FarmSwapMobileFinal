import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/screens/farmer_wallet_management_screen.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/cashIn_Gesture_ShowDialog.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/cashOut_Gesture_ShowDialog.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/swap_coins_management/screens/farmer_swapCoins_management_screen.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/consumer_barter_tranasctions/consumer_bid_listings.dart';
import 'package:farm_swap_mobile_final/karl_modules/barter%20transactions/screens/farmer_barter_transactions/farmer_barter_transactions.dart';
import 'package:farm_swap_mobile_final/karl_modules/communication/screens/farmer_chat_screen_main.dart';
import 'package:farm_swap_mobile_final/karl_modules/dashboard/screens/active_dashboard.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_management_mainpage.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_barter/add_barter_listing_page2.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_barter/add_barter_listing_page3.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_barter/add_barter_listing_page4.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_listingintro_page2.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_selling/add_selling_listing_page3.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_selling/add_selling_listing_page2.dart';
import 'package:farm_swap_mobile_final/karl_modules/listing_management/screens/listing_subpages/add_listing_pages/add_selling/add_selling_listing_page4.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/screen/user_login_screen.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_login/screen/user_login_selection.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_displayProfilePhoto.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_selectProfilePhoto.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup10.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup2.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup3.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup4.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup5.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup6.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup7.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup8.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/screens/user_signup9.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/consumer_page/consumer_account.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/swapcoins_page/consumer_swapcoins.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/consumer_wallet.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/screens/form/cash_in_form.dart';
import 'package:farm_swap_mobile_final/rollaine_modules/pages/wallet_page/screens/form/cash_out_form.dart';
import 'package:flutter/material.dart';

import '../karl_modules/dashboard/screens/account_management_farmer/screen/account_management_farmer.dart';

class RouteManager {
/*Properties of the route*/
  static const usersignup = "/";
  static const userlogin = "/userlogin";
  static const userDetailsRegister = "/userdetailsregister";
  static const userDetailsRegister2 = "/userdetailsregister2";
  static const userDetailsRegister3 = "/userdetailsregister3";
  static const userDetailsRegister4 = "/userDetailsRegister4";
  static const userDetailsRegister5 = "/userDetailsRegister5";
  static const userDetailsRegister6 = "/userDetailsRegister6";
  static const userDetailsRegister7 = "/userDetailsRegister7";
  static const userDetailsRegister8 = "/userDetailsRegister8";
  static const userDetailsRegisterEnd = "/userDetailsRegisterEnd";
  static const pendingAccountsDashboar = "/pendingAccountsDashboar";
  static const activeDashboard = "/activeDashboard";
  static const userloginselection = "/userloginselection";
  static const farmeraccountmanagement = "/farmeraccountmanagement";
  static const userprofilephoto = "/userprofilephoto";
  static const displayuserprofilePhoto = "/displayuserprofilePhoto";
  static const listingmainpage = "/listingmainpage";
  static const addlistingpage1 = "addlistingpage1";
  static const addselllistingdetails2 = "/addselllistingdetails2";
  static const addselllistingdetails3 = "/addselllistingdetails3";
  static const addselllistingdetails4 = "/addselllistingdetails4";
  static const addbarterlisttingdetails2 = "addbarterlisttingdetails2";
  static const addbarterlisttingdetails3 = "addbarterlisttingdetails3";
  static const addbarterlisttingdetails4 = "addbarterlisttingdetails4";
  static const walletpage = "/walletpage";
  static const cashinpage = "/cashinpage";
  static const cashoutpage = "/cashoutpage";
  static const allBarterListingsDetails = "allListingsDetails";
  static const consumerpage = "/consumerpage";
  static const consumerwallet = "/consumerwallet";
  static const consumercashin = "/consumercashin";
  static const consumercashout = "/consumercashout";
  static const farmerswapcoins = "/farmerswapcoins";
  static const consumerswapcoins = "/consumerswapcoins";
  static const uploadItemPictureToBarter = "/uploadItemPictureToBarter";
  static const entertobarteritem3 = "/entertobarteritem3";
  static const farmerbartertransactionmainpage = "/farmerbartertransactionmainpage";
  static const consumerbidListings = "/consumerbidListings";
  static const farmerchatmainpage = "/farmerchatmainpage";
  static const disputepage = "/disputepage";

/*Route method */
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case usersignup:
        return MaterialPageRoute(builder: (context) => const UserSignUpScreen());

      case userlogin:
        return MaterialPageRoute(builder: (context) => const UserLoginScreen());

      case userDetailsRegister:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration());

      case userDetailsRegister2:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration2());

      case userDetailsRegister3:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration3());

      case userDetailsRegister4:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration4());

      case userDetailsRegister5:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration5());

      case userDetailsRegister6:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration6());

      case userDetailsRegister7:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration7());

      case userDetailsRegister8:
        return MaterialPageRoute(builder: (context) => const UserPersonalDetailsRegistration8());

      case userDetailsRegisterEnd:
        return MaterialPageRoute(builder: (context) => const UserRegisterEndPage());

      case activeDashboard:
        return MaterialPageRoute(builder: (context) => ActiveDashboard());

      case farmeraccountmanagement:
        return MaterialPageRoute(builder: (context) => FarmerProfileDashboard());

      case userloginselection:
        return MaterialPageRoute(builder: (context) => const UserTypeLoginSelection());

      case userprofilephoto:
        return MaterialPageRoute(builder: (context) => const UserProfilePhotoRegistration());

      case displayuserprofilePhoto:
        return MaterialPageRoute(builder: (context) => const UserProfilePhotoDisplay());

      case listingmainpage:
        return MaterialPageRoute(builder: (context) => const ListingManagementMainPage());

      case addlistingpage1:
        return MaterialPageRoute(builder: (context) => const AddListingPageInputDetails());

      case addselllistingdetails2:
        return MaterialPageRoute(builder: (context) => const AddActualSellingListingDetails2());

      case addselllistingdetails3:
        return MaterialPageRoute(builder: (context) => const AddActualSellingListingDetails3());

      case addselllistingdetails4:
        return MaterialPageRoute(builder: (context) => const AddActualSellingListingDetails4());

      case addbarterlisttingdetails2:
        return MaterialPageRoute(builder: (context) => const AddActualBarterListingDetails2());

      case addbarterlisttingdetails3:
        return MaterialPageRoute(builder: (context) => const AddActualBarterListingDetails3());

      case addbarterlisttingdetails4:
        return MaterialPageRoute(builder: (context) => const AddActualBarterListingDetails4());

      case consumerpage:
        return MaterialPageRoute(builder: (context) => const ConsumerPage());

      case consumerwallet:
        return MaterialPageRoute(builder: (context) => const ConsumerWallet());

      case consumercashin:
        return MaterialPageRoute(builder: (context) => const CashInForm());

      case consumercashout:
        return MaterialPageRoute(builder: (context) => const CashOutForm());

      case walletpage:
        return MaterialPageRoute(builder: (context) => WalletPage());

      case consumerswapcoins:
        return MaterialPageRoute(builder: (context) => const ConsumerSwapCoinsPage());

      case cashinpage:
        return MaterialPageRoute(builder: (context) => const CashInPage());

      case cashoutpage:
        return MaterialPageRoute(builder: (context) => const CashOutGestureDialog());

      case farmerswapcoins:
        return MaterialPageRoute(builder: (context) => FarmerSwapCoinsPage());

      case farmerbartertransactionmainpage:
        return MaterialPageRoute(builder: (context) => const FarmerBarterTransactionMainPage());

      case consumerbidListings:
        return MaterialPageRoute(
          builder: (context) => const ConsumerBidListings(),
        );

      case farmerchatmainpage:
        return MaterialPageRoute(builder: (context) => const FarmerMainChatScreen());

      default:
        throw const FormatException("Warning!!! Page Routing Problem");
    }
  }
}
