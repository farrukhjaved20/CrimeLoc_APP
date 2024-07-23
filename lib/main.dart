import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/views/authentication/sigin.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'CrimeLoc Application',
      defaultTransition: Transition.rightToLeft,
      theme: ThemeData(
        fontFamily: 'Kollektif',
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: AppColors.bluecolor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.bluecolor),
                foregroundColor: WidgetStatePropertyAll(AppColors.whitecolor))),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInPage(),
    );
  }
}
