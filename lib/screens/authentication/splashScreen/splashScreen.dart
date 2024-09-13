import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Shimmer effect import

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  void initState() {
    super.initState();

    authenticationController.isLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image container at the top of the splash screen
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Image.asset(
                'assets/images/icon1.png',
                height:
                    SizeConfig.screenHeight * 0.3, // Adjust height as needed
                width: double.infinity, // Adjust width as needed
                fit: BoxFit.cover, // Adjust fit if needed
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: AppColors.kappRedColor, // Base shimmer color
            highlightColor: Colors.white, // Highlight shimmer color
            child: Text(
              "CrimeLoc", // Displayed text
              textAlign: TextAlign.center,
              style: StyleText.getBoldStyle(
                fontSize:
                    SizeConfig.screenHeight * 0.05, // Responsive font size
                color: AppColors.textcolor, // Text color
              ),
            ),
          ),

          // Centered text with shimmer effect
        ],
      ),
    );
  }
}
