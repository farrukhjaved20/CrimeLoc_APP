import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: StyleText.getBoldStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            // Image.asset(
            //   'assets/images/notifications.png', // Make sure this path is correct
            //   height: 100,
            //   width: 100,
            // ),
            // const SizedBox(height: 20),
            const Icon(
              Icons.notifications_active_rounded,
              size: 100,
              color: Colors.red,
            ),
            Text(
              'No Notifications Yet!',
              style: StyleText.getBoldStyle(
                fontSize: SizeConfig.screenHeight * 0.022,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We'll notify you when there is something new.",
              style: StyleText.getBoldStyle(
                fontSize: SizeConfig.screenHeight * 0.018,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
