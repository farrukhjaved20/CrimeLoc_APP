import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/security_settings/privacy_policy.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/security_settings/term_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        title: const Text(
          'About the App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/icon1.png', // Replace with your app logo path
                height:
                    SizeConfig.screenHeight * 0.2, // Adjust height as needed
              ),
            ),
            const Center(
              child: Column(
                children: [
                  // Placeholder for app logo
                  // Image.asset(
                  //   'assets/app_logo.png', // Replace with your app logo path
                  //   height: 100,
                  // ),
                  SizedBox(height: 10),

                  // Text(
                  //   'CrimeLoc App',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'CrimeLoc App is designed to alert users about possible high crime rate areas and advise them to take safer routes. Users can mark the location where a crime happened and this data is shown to all users as heat on the map.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Version',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('1.0.0'), // Replace with your app version
            const SizedBox(height: 20),
            const Text(
              'Developer Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
                'Developed by CrimeLoc.\nContact: support@crimeloc.com'), // Updated company name and email
            const SizedBox(height: 20),
            const Text(
              'Terms and Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.off(() => const TermsOfServiceScreen());
              },
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  color: AppColors.kappRedColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.kappRedColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.off(() => const PrivacyPolicyScreen());
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: AppColors.kappRedColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.kappRedColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
