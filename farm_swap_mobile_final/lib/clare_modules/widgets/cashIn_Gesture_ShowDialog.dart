import 'dart:io';
import 'package:farm_swap_mobile_final/clare_modules/controllers/farmer_wallet_controller.dart';
import 'package:farm_swap_mobile_final/clare_modules/widgets/textfield/wallet_textfield.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../common/colors.dart';
import '../../karl_modules/user_signup/widgets/custom_image_picker.dart';
import '../database/farmer_wallet_database.dart';
import '../database/farmer_wallet_query.dart';
import 'label/wallet_textfield_label.dart';
import 'text/title_header.dart';

class CashInPage extends StatefulWidget {
  const CashInPage({
    super.key,
  });

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  /* Add a loading indicator state para makita ang mga data kay if wala ni 
  dili man mo show ang data nga gikan sa label na class 
  */
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers here
    controllers.contactNumberController = TextEditingController();
    controllers.addressController = TextEditingController();
    controllers.dateController = TextEditingController();
    controllers.amountController = TextEditingController();
    // Load your data when the widget is initialized
    loadData();
  }

  Future<void> loadData() async {
    //nag set ta ug loading diri kay para mo load before ma show ang page
    await Future.delayed(const Duration(
      seconds: 1,
    ));
    // Data loading is complete
    setState(() {
      isLoading = false;
    });
  }

  /*Instance of the controller class*/
  static TextEditingControllers controllers = TextEditingControllers();

  // Create an instance of WalletTextFieldLabel ang ga gamit ani kay sa first name and last name ra
  WalletTextFieldLabel walletTextFieldLabel = WalletTextFieldLabel();

  // Dispose of the controller when the widget is removed
  @override
  void dispose() {
    controllers.contactNumberController.dispose();
    controllers.addressController.dispose();
    controllers.amountController.dispose();
    controllers.dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenNormal,
        title: const Text("Transaction : Cash In"),
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
      // Show a loading indicator if data is still loading
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const TitleHeaderText(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 350.w,
                    height: 770.h,
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
                        //this row is for the userid of farmer naka set nani ang userId daan
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'User ID:',
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
                                controller: controllers.userIdController,
                                enabled: false,
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
                        //this row is for the first name of farmer naka set nasad ni gikan sa label na class
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
                                controller: controllers.firstNameController,
                                enabled: false,
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
                        //this row is for the last name of farmer naka set nasad ni gikan sa label na class
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
                                controller: controllers.lastNameController,
                                enabled: false,
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
                        //this row kay para sa mobile number wala pani naka set need mo input ni farmer diri
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
                                controller: controllers.contactNumberController,
                                label: const Text("Mobile Number"),
                                enabled: true,
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
                        /*this row is for the farmers address wala pani naka set 
                        need mo input ni farmer diri*/
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
                                controller: controllers.addressController,
                                label: const Text("Address"),
                                enabled: true,
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
                        /*this row is for the farmers date of cash in request wala pani naka set 
                        need mo select ni farmer diri */
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
                                    controller: controllers.dateController,
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2050),
                                          );

                                          if (pickedDate != null) {
                                            String formattedDate = DateFormat(
                                                    'yyyy-MM-dd HH:mm:ss')
                                                .format(pickedDate);

                                            setState(() {
                                              controllers.dateController.text =
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                      label: const Text("Date"),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: farmSwapSmoothGreen),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: farmSwapSmoothGreen),
                                      ),
                                    ),
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
                        //this row is for the farmers amount need mo set ni farmer sa amount diri
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
                                controller: controllers.amountController,
                                label: const Text("Cash In Amount"),
                                enabled: true,
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
                        //this row is for the farmers proof of payment
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: Text(
                                'Proof of Payment :',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 180.w,
                                height: 30.h,
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(0.99, -0.15),
                                    end: Alignment(-0.99, 0.15),
                                    colors: [
                                      Color(0xFF53E78B),
                                      Color(0xFF14BE77)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.50),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Click to upload a photo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontFamily: 'Poly',
                                      fontWeight: FontWeight.w900,
                                      height: 0,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text("Choose a photo!"),
                                      ),
                                      content: SizedBox(
                                        height: 280.h,
                                        child: Column(
                                          children: [
                                            /*This is for picking image in the gallery */
                                            GestureDetector(
                                              onTap: () async {
                                                // Call the function to select an image from gallery
                                                selectImageGallery();

                                                Navigator.of(context)
                                                    .pop(); // Close the dialog box
                                              },
                                              child: CustomPicturePicker(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: 200.sp,
                                                imagePath:
                                                    "assets/karl_assets/images/Gallery.svg",
                                                title: "From Gallery",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.sp,
                                            ),
                                            /*This is for picking image in the camera */
                                            GestureDetector(
                                              onTap: () async {
                                                // Call the function to select an image from camera
                                                selectImageCamera();

                                                Navigator.of(context)
                                                    .pop(); // Close the dialog box
                                              },
                                              child: CustomPicturePicker(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: 200.sp,
                                                imagePath:
                                                    "assets/karl_assets/images/camera.svg",
                                                title: "From Camera",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog box
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        //this row is for the farmers uploaded proof of payment to preview
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200.w,
                              height: 300.h,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(0.00, -1.00),
                                  end: Alignment(0, 1),
                                  colors: [
                                    Color(0xFF27CB7D),
                                    Color(0xFF4EE48A)
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Container(
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(0.00, -1.00),
                                    end: Alignment(0, 1),
                                    colors: [
                                      Color(0xFF27CB7D),
                                      Color(0xFF4EE48A)
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                width: 230.w,
                                height: 300.h,
                                child: Center(
                                  /*this will display the image from the class 
                                  selectImageGallery or selectImageCamera
                                  **/
                                  child: _selectedImage != null
                                      ? Image.file(
                                          File(_selectedImage!.path),
                                          width: 190.w,
                                          height: 280.h,
                                          fit: BoxFit.cover,
                                        )
                                      : const Text(
                                          "No image selected",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
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
                                      "Please ensure the details are correct. Click proceed to request cash in."),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Proceed"),
                                      onPressed: () async {
                                        /**if i click ang proceed diri pa mo save ang mga data
                                         * nga gi input sa farmer
                                         */
                                        saveDataIncludingImage();
                                        Navigator.of(context)
                                            .pop(); // Close the first AlertDialog

                                        // Create a new context for the second AlertDialog
                                        BuildContext secondDialogContext;

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            secondDialogContext =
                                                context; // Save the context
                                            return AlertDialog(
                                              title: const Text(
                                                  "Request Submitted"),
                                              content: const Text(
                                                  "Your request for cash in is under review by the admin."),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(
                                                            secondDialogContext)
                                                        .pop(); // Close the second AlertDialog
                                                    Navigator.of(context)
                                                        .pushNamed(RouteManager
                                                            .walletpage);
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
                                      "Are you sure you want to cancel the cash-in request? Click proceed to cancel the request."),
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

  XFile? _selectedImage;

  // function para sa pag select sa image gikan sa gallery
  void selectImageGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // function para sa pag select sa image gikan sa camera
  void selectImageCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

// Function to save the data to Firestore including the selected image
  Future<void> saveDataIncludingImage() async {
    if (_selectedImage == null) {
      // Display an error message or return, as an image is required
      return;
    }

    final userRole = controllers.userRoleController.text;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firstName = controllers.firstNameController.text;
    final lastName = controllers.lastNameController.text;
    final contactNumber = controllers.contactNumberController.text;
    String address = controllers.addressController.text;
    String cashindate = controllers.dateController.text;
    DateTime date = DateTime.parse(cashindate);
    final amount = double.parse(controllers.amountController.text);
    final status = controllers.statusController.text;
    String request = "cash in";
    final profilePhoto = controllers.profileController.text;

    // Upload the selected image to Firebase Storage
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${DateTime.now()}.jpg");
    UploadTask uploadTask =
        storageReference.putFile(File(_selectedImage!.path));

    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();

      // Use the downloadURL as the proofPayment
      final proofPayment = downloadURL;

      // Create an instance of the FarmerWalletDb
      FarmerWalletDB farmerWalletDB = FarmerWalletDB();

      AddWalletFarmerDataQuery walletfarmer = AddWalletFarmerDataQuery();
      final farmerwallet = await farmerWalletDB.insertFarmerWalletData(
        userRole,
        userId,
        firstName,
        lastName,
        contactNumber,
        address,
        date,
        amount,
        proofPayment,
        status,
        request,
        profilePhoto,
      );

      await walletfarmer.createUser(farmerwallet);
    });
  }
}
