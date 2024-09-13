import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool showLoader;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.showLoader,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.06,
      width: width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(14))),
          backgroundColor: MaterialStatePropertyAll(AppColors.kappRedColor),
          overlayColor: const MaterialStatePropertyAll(Colors.white),
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          foregroundColor: MaterialStatePropertyAll(AppColors.kappRedColor),
        ),
        child: showLoader
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: StyleText.getRegularStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: height * 0.018,
                ),
              ),
      ),
    );
  }
}
