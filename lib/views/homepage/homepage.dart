import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/views/authentication/sigin.dart';
import 'package:crime_heat/views/authentication/signup.dart';
import 'package:crime_heat/views/homepage/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _bottomNavIndex = 0; //default index of a first screen
  final Color navigationBarColor = Colors.white;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.bluecolor,
          foregroundColor: AppColors.whitecolor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          splashColor: AppColors.customgrey2,
          shape: const CircleBorder(
              side: BorderSide(
                  width: 0,
                  color: Colors.transparent,
                  style: BorderStyle.none)),
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
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
              filledIcon: Icons.menu_rounded,
              outlinedIcon: Icons.menu_outlined,
            ),
            BarItem(
              filledIcon: Icons.location_on_rounded,
              outlinedIcon: Icons.location_on_outlined,
            ),
            BarItem(
              filledIcon: Icons.settings_suggest_rounded,
              outlinedIcon: Icons.settings_suggest_outlined,
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 100),
                child: const SearchScreen())
          ],
        ),
      ),
    );
  }
}
