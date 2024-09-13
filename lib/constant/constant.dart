import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color kappRedColor = const Color(0xffff0000);
  static Color kappBlueColor = const Color(0xff013044);
  static Color bluecolor = const Color(0xff4169e1);
  static Color whitecolor = const Color(0xffffffff);
  static Color buttonColor = const Color(0xff0d58cf);
  static Color mygreycolor = const Color(0xff989eb3);
  static Color dividorcolor = const Color(0xffd2dae2);
  static Color textcolor = const Color(0xff35424a);
  static Color greencolor = const Color(0xff92d36e);
  static Color orangecolor = const Color(0xffffa834);
  static Color redcolor = const Color(0xffff6624);
  static Color textbluecolor = const Color(0xff225ed3);
  static Color lightgreencolor = const Color(0xffdfedd6);
  static Color customgrey2 = const Color(0xff989eb1);
}

final ThemeData appThemeData = ThemeData(
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.buttonColor,
    titleTextStyle: StyleText.getBoldStyle(
      color: Colors.white,
      fontSize: SizeConfig.screenHeight * 0.02,
      fontWeight: FontWeight.w400,
    ),
  ),
  scaffoldBackgroundColor: Colors.white, // Make scaffold background transparent
  fontFamily: 'Kollektif',
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.bluecolor,
  ),
  indicatorColor: Colors.purple,
  iconTheme: const IconThemeData(color: Colors.amber),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(AppColors.kappRedColor),
      foregroundColor: WidgetStatePropertyAll(AppColors.kappRedColor),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.bluecolor,
  ),
);
final FirebaseAuth authentication = FirebaseAuth.instance;
final FirebaseFirestore usersCollection = FirebaseFirestore.instance;
final List<Map<String, dynamic>> faqs = [
  {
    'question': 'Q1.What should I do if I am in immediate danger?',
    'answer':
        'If you are in immediate danger, call your local emergency services (e.g., 911 in the US) immediately. CrimeLoc is not a substitute for emergency services and should not be used in place of contacting authorities.',
    'isExpanded': false,
  },
  {
    'question': 'Q2.How do I report a crime using the CrimeLoc app?',
    'answer':
        'To report a crime, open the app, tap on the \'Report Crime\' button, select the location on the map where the crime occurred, and fill in the details of the incident. Once submitted, the report will be visible to other users.',
    'isExpanded': false,
  },
  {
    'question': 'Q3.What type of incidents should I report on CrimeLoc?',
    'answer':
        'You should report any incidents that could pose a threat to the safety of others, such as theft, assault, vandalism, or suspicious activity. Please ensure that your reports are accurate and truthful.',
    'isExpanded': false,
  },
  {
    'question': 'Q4.Can I report a crime anonymously?',
    'answer':
        'Yes, you can choose to report a crime anonymously. CrimeLoc does not require personal information when submitting a report, and your identity will not be shared with other users.',
    'isExpanded': false,
  },
  {
    'question':
        'Q5.How do I know if the crime reports on the map are accurate?',
    'answer':
        'CrimeLoc relies on user-generated content, so the accuracy of reports depends on the information provided by users. We encourage all users to report incidents truthfully and accurately. However, always use caution and verify information through other trusted sources when possible.',
    'isExpanded': false,
  },
  {
    'question': 'Q6.What should I do if I notice false or misleading reports?',
    'answer':
        'If you come across a report that you believe is false or misleading, you can flag it for review by our team. We take the accuracy of reports seriously and will investigate flagged content.',
    'isExpanded': false,
  },
  {
    'question': 'Q7.How do I stay safe in high-crime areas shown on the map?',
    'answer':
        'If you are near a high-crime area, consider avoiding it if possible, especially at night. Stay in well-lit areas, remain aware of your surroundings, and if you feel unsafe, contact local authorities.',
    'isExpanded': false,
  },
  {
    'question': 'Q8.Can law enforcement access the data from CrimeLoc?',
    'answer':
        'CrimeLoc is a public platform, and the information shared on the app is visible to everyone, including law enforcement agencies. However, we do not provide personal user data unless required by law.',
    'isExpanded': false,
  },
  {
    'question': 'Q9.What if I need help but can\'t use my phone?',
    'answer':
        'In situations where you can\'t use your phone, try to find a safe place to seek help from others nearby. If you\'re in immediate danger, try to alert someone in your vicinity who can contact emergency services on your behalf.',
    'isExpanded': false,
  },
  {
    'question': 'Q10.How can I contact CrimeLoc for further assistance?',
    'answer':
        'If you need further assistance, you can contact our support team directly through the \'Help\' section of the app or via email at [Your Support Email]. We strive to respond to all inquiries as quickly as possible.',
    'isExpanded': false,
  },
];
