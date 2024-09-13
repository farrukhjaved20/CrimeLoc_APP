import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/screens/authentication/sigin.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/app_preferances/report_a_bug.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/app_preferances/share_feedback.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/security_settings/privacy_policy.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/security_settings/term_service.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/account_information/change_password.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/security_settings/about_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isfalse = false;
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  void customShowDialog({
    required String titleText,
    required String subtitleText,
    required BuildContext context,
    required Function() onPressed,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(titleText),
          content: Text(subtitleText),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                titleText,
                style: TextStyle(
                  color: AppColors.kappRedColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'Settings',
          style: StyleText.getBoldStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            shape: const RoundedRectangleBorder(
              side:
                  BorderSide(color: Colors.grey, width: 0.2), // Add border here
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            title: Text(
              'Account Information',
              style: StyleText.getBoldStyle(
                fontSize: SizeConfig.screenHeight * 0.02,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Get.to(() => const ChangeEmail());
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 10, right: 10),
              //     child: ListTile(
              //         style: ListTileStyle.list,
              //         shape: ContinuousRectangleBorder(
              //             borderRadius: BorderRadius.circular(20)),
              //         trailing: IconButton(
              //             onPressed: () {},
              //             icon: const Icon(
              //               Icons.arrow_forward_ios,
              //               size: 14,
              //             )),
              //         title: Text('Change Email',
              //             style: StyleText.getBoldStyle(
              //               //0  color: Colors.white,
              //               fontSize: SizeConfig.screenHeight * 0.018,
              //               fontWeight: FontWeight.w400,
              //             ))),
              //   ),
              // ),
              // const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ChangePasswordScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: ListTile(
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          )),
                      title: Text('Change Password',
                          style: StyleText.getBoldStyle(
                            fontSize: SizeConfig.screenHeight * 0.018,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          ExpansionTile(
            title: Text('Notification Settings',
                style: StyleText.getBoldStyle(
                  fontSize: SizeConfig.screenHeight * 0.02,
                  fontWeight: FontWeight.w400,
                )),
            children: [
              SwitchListTile(
                title: Text('Notifications',
                    style: StyleText.getBoldStyle(
                      fontSize: SizeConfig.screenHeight * 0.02,
                      fontWeight: FontWeight.w400,
                    )),
                inactiveTrackColor: Colors.white,

                activeColor: AppColors.kappRedColor,
                value: isfalse, // Change this to a variable as needed
                onChanged: (bool value) {
                  setState(() {
                    isfalse = value;
                    if (value == true) {
                      Get.snackbar('Success', 'Notifications Are On');
                    } else {
                      Get.snackbar('Success', 'Notifications Are Off');
                    }
                  });
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Security Settings',
                style: StyleText.getBoldStyle(
                  fontSize: SizeConfig.screenHeight * 0.02,
                  fontWeight: FontWeight.w400,
                )),
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const TermsOfServiceScreen());
                },
                child: ListTile(
                    style: ListTileStyle.list,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )),
                    title: Text('Terms of Service',
                        style: StyleText.getBoldStyle(
                          //0  color: Colors.white,
                          fontSize: SizeConfig.screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                        ))),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: ListTile(
                    style: ListTileStyle.list,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )),
                    title: Text('Privacy Policy',
                        style: StyleText.getBoldStyle(
                          //0  color: Colors.white,
                          fontSize: SizeConfig.screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                        ))),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'App Preferences',
              style: StyleText.getBoldStyle(
                fontSize: SizeConfig.screenHeight * 0.02,
                fontWeight: FontWeight.w400,
              ),
            ),
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const ReportScreen());
                },
                child: ListTile(
                    style: ListTileStyle.list,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )),
                    title: Text('Report A Bug',
                        style: StyleText.getBoldStyle(
                          //0  color: Colors.white,
                          fontSize: SizeConfig.screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                        ))),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ShareFeedbackPage());
                },
                child: ListTile(
                    style: ListTileStyle.list,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )),
                    title: Text('Share FeedBack',
                        style: StyleText.getBoldStyle(
                          //0  color: Colors.white,
                          fontSize: SizeConfig.screenHeight * 0.018,
                          fontWeight: FontWeight.w400,
                        ))),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AboutAppPage());
                },
                child: ListTile(
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )),
                    title: Text('About App',
                        style: StyleText.getBoldStyle(
                          fontSize: SizeConfig.screenHeight * 0.02,
                          fontWeight: FontWeight.w400,
                        ))),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Account Settings',
              style: StyleText.getBoldStyle(
                fontSize: SizeConfig.screenHeight * 0.02,
                fontWeight: FontWeight.w400,
              ),
            ),
            children: [
              ListTile(
                title: Text('Delete Your Account',
                    style: StyleText.getRegularStyle(
                      fontSize: SizeConfig.screenHeight * 0.018,
                      fontWeight: FontWeight.w300,
                    )),
                onTap: () {
                  customShowDialog(
                    titleText: 'Delete Your Account',
                    subtitleText: 'Do you want to proceed with this action?',
                    context: context,
                    onPressed: () async {
                      await authenticationController.deleteAccount();
                      Get.offAll(() => const SignInPage());
                    },
                  );
                },
              ),
            ],
          ),
          ListTile(
              title: Text('Log Out',
                  style: StyleText.getBoldStyle(
                    color: Colors.red,
                    fontSize: SizeConfig.screenHeight * 0.02,
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () => customShowDialog(
                    titleText: 'Log Out',
                    subtitleText: 'Are You Sure You Want to Logout',
                    context: context,
                    onPressed: () {
                      authenticationController.signOut();
                    },
                  )),
        ],
      ),
    );
  }
}
