import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/views/homepage/searchscreen.dart';
import 'package:crime_heat/views/pages/profile_page.dart';
import 'package:crime_heat/views/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _bottomNavIndex = 1; //default index of a first screen
  final Color navigationBarColor = Colors.white;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.bluecolor,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: AppColors.bluecolor,
        //   foregroundColor: AppColors.whitecolor,
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   splashColor: AppColors.customgrey2,
        //   shape: const CircleBorder(
        //       side: BorderSide(
        //           width: 0,
        //           color: Colors.transparent,
        //           style: BorderStyle.none)),
        //   onPressed: () {
        //     Get.to(() => const AddIssue());
        //   },
        //   child: const Icon(Icons.add),
        // ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: AppColors.whitecolor,
          waterDropColor: AppColors.bluecolor,
          onItemSelected: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
            pageController.animateToPage(_bottomNavIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: _bottomNavIndex,
          barItems: [
            BarItem(
              filledIcon: Icons.person_2_rounded,
              outlinedIcon: Icons.person_2_outlined,
            ),
            BarItem(
              filledIcon: Icons.home_rounded,
              outlinedIcon: Icons.home_outlined,
            ),
            BarItem(
              filledIcon: Icons.menu_rounded,
              outlinedIcon: Icons.menu_outlined,
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            const MenuPage(),
            Container(
                margin: EdgeInsets.only(top: height * 0.09),
                child: const SearchScreen()),
            const SettingsPage()
          ],
        ),
      ),
    );
  }
}
