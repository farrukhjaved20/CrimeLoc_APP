import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/notifications/notifications.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/map_screen.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/Profile/profile_page.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components_bottomnav/support/support_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 2; // Default index

  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _bottomNavIndex,
        elevation: 0,
        iconSize: 28,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          pageController.animateToPage(
            _bottomNavIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
          );
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25), // Smaller icon
              label: 'Profile',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
              icon: Icon(Icons.info, size: 25), // Smaller icon
              label: 'Support',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: 40, // Larger size for the map icon
                height: 40,
                child: Image.asset(
                  'assets/images/icon1.png',
                ),
              ),
              label: 'Home',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
              icon: Icon(Icons.notifications, size: 25), // Smaller icon
              label: 'Notifications',
              backgroundColor: Colors.white),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25), // Smaller icon
              label: 'Settings',
              backgroundColor: Colors.white),
        ],
        //backgroundColor: Colors.blue, // Set the background color of the bar
        selectedItemColor: AppColors.kappRedColor, // Color of selected item
        unselectedItemColor:
            AppColors.bluecolor.withOpacity(0.35), // Color of unselected items
        selectedLabelStyle: StyleText.getBoldStyle(
          fontSize: height * 0.014,
          color: AppColors.whitecolor,
          fontWeight: FontWeight.w800,
        ), // Style for selected label
        unselectedLabelStyle: StyleText.getBoldStyle(
          fontSize: height * 0.018,
          color: AppColors.whitecolor,
          fontWeight: FontWeight.w400,
        ), // Style for unselected label
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          ProfilePage(),
          SupportScreen(),
          MapHomeScreen(),
          NotificationsScreen(),
          SettingsPage(),
        ],
      ),
    );
  }
}
