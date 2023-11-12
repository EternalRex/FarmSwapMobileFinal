import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/controllers/farmer_wallet_controller.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/checkBalance_Class.dart';
import 'package:farm_swap_mobile_final/clare_modules/pages/farmer_wallet_management/widgets/text/title_header.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../database/farmer_wallet_database.dart';
import '../database/farmer_wallet_query.dart';
import 'textfield/wallet_textfield.dart';

class CashOutGestureDialog extends StatefulWidget {
  const CashOutGestureDialog({super.key});

  @override
  State<CashOutGestureDialog> createState() => _CashOutGestureDialogState();
}

class _CashOutGestureDialogState extends State<CashOutGestureDialog> {
  //we only reuse the TextEditingControllers from the cash in for the userID
  static TextEditingControllers controllers = TextEditingControllers();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  //date controller
  TextEditingController dateController = TextEditingController();

  //TextEditingControllers for the cash out diri nalang nako gibutang
  TextEditingController userRoleController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController proofController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController requestController = TextEditingController();
  TextEditingController statusController =
      TextEditingController(text: "pending");

  // Dispose of the controllers
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactNumberController.dispose();
    addressController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenNormal,
        title: const Text("Transaction : Cash Out"),
        flexibleSpace: Container(
          height: 300.sp,
          width: 300.sp,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/karl_assets/images/pattern.png"),
              fit: BoxFit.cover,
              scale: 100.0.sp,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteManager.walletpage);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            const TitleHeaderText1(),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 350.w,
              height: 420.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x21000000),
                    blurRadius: 20,
                    offset: Offset(6, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),

                  //this row is for the first name of farmer
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'First Name :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: WalletTextField(
                          controller: firstNameController,
                          enabled: true,
                          label: const Text("First Name"),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //this row is for the last name of farmer
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Last Name :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: WalletTextField(
                          controller: lastNameController,
                          enabled: true,
                          label: const Text("Last Name"),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //this row kay para sa mobile number
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Mobile Number :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: WalletTextField(
                          controller: contactNumberController,
                          enabled: true,
                          label: const Text("Mobile Number"),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //this row is for the farmers address
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Address :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: WalletTextField(
                          controller: addressController,
                          enabled: true,
                          label: const Text("Address"),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //this row is for the farmers date of cash out request
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Date :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 150.w, // Set the desired width
                          child: SizedBox(
                            height: 35.h, // Set the desired height
                            child: TextField(
                              controller: dateController,
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2050),
                                    );

                                    if (pickedDate != null) {
                                      // Append the current time to the picked date
                                      DateTime pickedDateTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        DateTime.now().hour,
                                        DateTime.now().minute,
                                        DateTime.now().second,
                                      );
                                      String formattedDate =
                                          DateFormat('MMMM d, y hh:mm a')
                                              .format(pickedDateTime);

                                      setState(() {
                                        dateController.text =
                                            formattedDate; // Update the text in the controller
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.green,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                label: const Text("Date"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: farmSwapSmoothGreen),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(color: farmSwapSmoothGreen),
                                ),
                              ),
                              readOnly: true,
                              cursorColor: FarmSwapGreen.normalGreen,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  //this row is for the farmers amount
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Amount :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: WalletTextField(
                          controller: amountController,
                          enabled: true,
                          label: const Text("Cash Out Amount"),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            //this container kay para sa proceed button and cancel button
            Container(
              width: 350.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x21000000),
                    blurRadius: 20,
                    offset: Offset(6, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //proceed button
                  GestureDetector(
                    child: Container(
                      width: 112.w,
                      height: 35.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.99, -0.15),
                          end: Alignment(-0.99, 0.15),
                          colors: [Color(0xFF49E188), Color(0xFF1FC57A)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.50),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                                "Please ensure the details are correct. Click proceed to request cash out."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Proceed"),
                                onPressed: () async {
                                  /**if i click ang proceed diri pa mo save ang mga data
                                  * nga gi input sa farmer para cash out pero if ang amount 
                                   kay mas dako pa sa balance then naay dialog mogawas lain
                                  */
                                  cashout();

                                  Navigator.of(context)
                                      .pop(); // Close the first AlertDialog

                                  // Create a new context for the second AlertDialog
                                  BuildContext secondDialogContext;
                                  //this will only show if the balance is sufficient
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      secondDialogContext =
                                          context; // Save the context
                                      return AlertDialog(
                                        title: const Text("Request Submitted"),
                                        content: const Text(
                                            "Your request for cash out is under review by the admin."),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(secondDialogContext)
                                                  .pop(); // Close the second AlertDialog
                                              Navigator.of(context).pushNamed(
                                                  RouteManager.walletpage);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the first AlertDialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 15.h,
                  ),
                  //cancel button
                  GestureDetector(
                    child: Container(
                      width: 112.w,
                      height: 35.h,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.99, -0.15),
                          end: Alignment(-0.99, 0.15),
                          colors: [
                            Color(0xEEFF9012),
                            Color(0xFFE21B1B),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.50),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 22.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                height: 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                                "Are you sure you want to cancel the cash-out request? Click proceed to cancel the request."),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Proceed"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the AlertDialog
                                  Navigator.of(context)
                                      .pushNamed(RouteManager.walletpage);
                                },
                              ),
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the AlertDialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Function to save the data to the Firestore
  Future<void> cashout() async {
    final userRole = controllers.userRoleController.text;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final contactNumber = contactNumberController.text;
    String address = addressController.text;

    //fixed the time in the date
    String date = dateController.text;
    DateTime cashoutdate = DateFormat('MMMM d, y hh:mm a').parse(date);

    final amount = double.parse(amountController.text);
    final status = controllers.statusController.text;
    String request = "cash out";
    String proofPayment = "";
    final profilePhoto = controllers.profileController.text;

    // Create an instance of the FarmerWalletDb
    FarmerWalletDB farmerWalletDB = FarmerWalletDB();

    //creating an instance for the class checkbalance
    CheckBalance checkBalance = CheckBalance();

    // Retrieve the balance from Firestore by calling the function getBalanceFromFirestore
    final balance = await checkBalance.getBalanceFromFirestore();

    //if the balance kay mas dako pa or equal sa amount then ma create ang farmerwallet
    if (balance >= amount) {
      AddWalletFarmerDataQuery walletfarmer = AddWalletFarmerDataQuery();
      final farmerwallet = await farmerWalletDB.insertFarmerWalletData(
        userRole,
        userId,
        firstName,
        lastName,
        contactNumber,
        address,
        cashoutdate,
        amount,
        proofPayment,
        status,
        request,
        profilePhoto,
      );

      if (farmerwallet != null) {
        await walletfarmer.createUser(farmerwallet);
      } else {
        // Handle the case where farmerwallet is null
        print(
            "Farmerwallet cashout details : $userId, $userRole, $firstName, $lastName, $contactNumber, $address, $date, $amount, proof $proofPayment, $status, $request, $profilePhoto");
      }
    }
    //else ang amount kay dako pa sa balance then dialog will show
    else if (amount > balance) {
      // Display an error message because the balance is insufficient
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
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteManager.cashoutpage),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
