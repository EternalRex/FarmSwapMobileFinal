import 'package:farm_swap_mobile_final/common/green_btn.dart';
import 'package:farm_swap_mobile_final/provider/user_details_provider.dart';
import 'package:farm_swap_mobile_final/provider/user_type_provider.dart';
import 'package:farm_swap_mobile_final/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../common/colors.dart';
import '../../../common/poppins_text.dart';

class UserPersonalDetailsRegistration5 extends StatefulWidget {
  const UserPersonalDetailsRegistration5({super.key});

  @override
  State<UserPersonalDetailsRegistration5> createState() => _UserPersonalDetailsRegistration5State();
}

class _UserPersonalDetailsRegistration5State extends State<UserPersonalDetailsRegistration5>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userRole = Provider.of<UserTypeProvider>(context, listen: false).getUserType;
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
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(13),
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
                              /*Displaying the uploaded Document*/
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: farmSwapSmoothGreen,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadow,
                                        blurRadius: 2,
                                        offset: const Offset(1, 5),
                                      )
                                    ]),
                                height: 500.sp,
                                width: 250.sp,
                                /*Pull outing the link or url of the image we uploaded from our provider
                            because the provider carries that link */
                                child: Consumer<UserDetailsProvider>(
                                  builder: (context, value, child) {
                                    return Image.network(value.getDocUrl);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(RouteManager.userDetailsRegister6);
                                },
                                child: const FarmSwapGreenBtn(text: "Next"),
                              ),
                            ],
                          ),
                        ),
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
}
