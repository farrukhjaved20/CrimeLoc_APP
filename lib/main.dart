import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/firebase_options.dart';
import 'package:crime_heat/screens/authentication/splashScreen/splashScreen.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/Profile/components/image.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  Get.lazyPut(() => AuthenticationController());
  Get.lazyPut(() => ImageService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrimeLoc Application',
      defaultTransition: Transition.rightToLeft,
      theme: appThemeData,
      home: const SplashScreen(),
    );
  }
}
