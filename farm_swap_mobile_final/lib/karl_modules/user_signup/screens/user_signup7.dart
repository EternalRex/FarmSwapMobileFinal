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

class UserPersonalDetailsRegistration6 extends StatefulWidget {
  const UserPersonalDetailsRegistration6({super.key});

  @override
  State<UserPersonalDetailsRegistration6> createState() =>
      _UserPersonalDetailsRegistration6State();
}

class _UserPersonalDetailsRegistration6State
    extends State<UserPersonalDetailsRegistration6> {
  /*Initializing the upload picture class */
  final UploadImageFunctions _uploadImage = UploadImageFunctions();
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
                ? SizedBox(
                    width: 800,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.sp,
                          ),
                          Image.asset(
                            "assets/karl_assets/images/farmer.png",
                          ),
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
                            "Upload Id Picture",
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
                              imageUrl = await _uploadImage
                                  .uploadImageToFirebaseGallery();
                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setIdPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister7);
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
                              imageUrl = await _uploadImage
                                  .uploadImageToFirebaseCamera();
                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setIdPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister7);
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
                : SizedBox(
                    width: 800,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/karl_assets/images/consumer.png"),
                          /*Header text */
                          poppinsText(
                            "Consumer Registration",
                            farmSwapTitlegreen,
                            20,
                            FontWeight.w500,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          poppinsText(
                            "Upload Id Picture",
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
                              imageUrl = await _uploadImage
                                  .uploadImageToFirebaseGallery();
                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setIdPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister7);
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
                              imageUrl = await _uploadImage
                                  .uploadImageToFirebaseCamera();
                              // ignore: use_build_context_synchronously
                              Provider.of<UserDetailsProvider>(context,
                                      listen: false)
                                  .setIdPicture(imageUrl.toString());
                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(RouteManager.userDetailsRegister7);
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
                  ),
          ],
        ),
      ),
    );
  }
}
