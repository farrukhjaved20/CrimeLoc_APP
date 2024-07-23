import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/views/authentication/sigin.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bluecolor,
        centerTitle: true,
        title: Text(
          'About',
          style: StyleText.getBoldStyle(
            fontSize: height * 0.03,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Settings',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Report a Bug',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Support',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'FAQS',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          // ListTile(
          //   title: Text(
          //     'Light & Dark Modes',
          //     style: StyleText.getBoldStyle(
          //       fontSize: height * 0.018,
          //       color: AppColors.textcolor,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          //   trailing: IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.arrow_forward_ios,
          //         color: AppColors.bluecolor,
          //       )),
          // ),
          // ListTile(
          //   title: Text(
          //     'Sign Out',
          //     style: StyleText.getBoldStyle(
          //       fontSize: height * 0.018,
          //       color: AppColors.textcolor,
          //       fontWeight: FontWeight.w400,
          //     ),
          //   ),
          //   trailing: IconButton(
          //       onPressed: () {
          //         Get.offAll(() => const SignInPage());
          //       },
          //       icon: Icon(
          //         Icons.arrow_forward_ios,
          //         color: AppColors.bluecolor,
          //       )),
          // ),
        ],
      ),
    );
  }
}
