import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';

class ViewCrimes extends StatelessWidget {
  const ViewCrimes({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whitecolor),
        backgroundColor: AppColors.bluecolor,
        centerTitle: true,
        title: Text(
          'View Crimes',
          style: StyleText.getBoldStyle(
            fontSize: height * 0.03,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
