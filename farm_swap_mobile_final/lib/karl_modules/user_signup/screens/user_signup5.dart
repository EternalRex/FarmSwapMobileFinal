import 'package:farm_swap_mobile_final/common/upload_image_functions.dart';
import 'package:farm_swap_mobile_final/karl_modules/user_signup/widgets/custom_image_picker.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../common/colors.dart';
import '../../../common/poppins_text.dart';

class UserPersonalDetailsRegistration4 extends StatefulWidget {
  const UserPersonalDetailsRegistration4({super.key});

  @override
  State<UserPersonalDetailsRegistration4> createState() =>
      _UserPersonalDetailsRegistration4State();
}

class _UserPersonalDetailsRegistration4State
    extends State<UserPersonalDetailsRegistration4> {
/*Instance of the upload image class */
  UploadImageFunctions uploadImage = UploadImageFunctions();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    String userRole =
        Provider.of<UserTypeProvider>(context, listen: false).getUserType;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              top: -450.sp,
              bottom: 0.sp,
              child: SvgPicture.asset(
                "assets/karl_assets/icons/Pattern.svg",
                height: 100,
                width: 400,
              ),
            ),
            (userRole == "Farmer")
                ? Positioned(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/karl_assets/images/farmer.png"),
                          /*Header text */
                          poppinsText(
                            "Farmer Registration",
                            farmSwapTitlegreen,
                            20,
                            FontWeight.w500,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          poppinsText(
                            "Upload Document Proof",
                            Colors.black,
                            13,
                            FontWeight.w300,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          /*This is for picking image in the gallery */
                          GestureDetector(
                            onTap: () async {
                              // Start loading state
                              _showLoadingDialog(context);
                              imageUrl = await uploadImage
                                  .uploadImageToFirebaseGallery();
                              // End loading state
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);

                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setDocumentPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister5);
                            },
                            child: CustomPicturePicker(
                              height: MediaQuery.of(context).size.height,
                              width: 200.sp,
                              imagePath:
                                  "assets/karl_assets/images/Gallery.svg",
                              title: "From Gallery",
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          /*This is for picking image in the camera */
                          GestureDetector(
                            onTap: () async {
                              // Start loading state
                              _showLoadingDialog(context);
                              imageUrl = await uploadImage
                                  .uploadImageToFirebaseCamera();
                              // End loading state
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setDocumentPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister5);
                            },
                            child: CustomPicturePicker(
                              height: MediaQuery.of(context).size.height,
                              width: 200.sp,
                              imagePath: "assets/karl_assets/images/camera.svg",
                              title: "From Camera",
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Positioned(
                    child: Center(),
                  ),
          ],
        ),
      ),
    );
  }

  // Display loading dialog
  // ignore: unused_element
  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
              SizedBox(width: 16),
              Text("Uploading..."),
            ],
          ),
        );
      },
    );
  }
}
