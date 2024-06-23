import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/views/authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final PasswordController password = Get.put(PasswordController());
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.07, top: height * 0.09),
              child: Center(
                child: Text(
                  "CrimeLoc App",
                  textAlign: TextAlign.center,
                  style: StyleText.getBoldStyle(
                    fontSize: height * 0.04,
                    color: AppColors.textcolor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.07, top: height * 0.08),
              child: Text(
                "Sign In",
                style: StyleText.getBoldStyle(
                  fontSize: height * 0.04,
                  color: AppColors.textcolor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.07),
              child: Text(
                "Hi there! Nice to see you again.",
                style: StyleText.getRegularStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: height * 0.02,
                  color: AppColors.mygreycolor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.07, top: height * 0.01, right: width * 0.07),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  labelText: "Email",
                  hintText: 'example@email.com',
                  hintStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.mygreycolor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.07, top: height * 0.01, right: width * 0.07),
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.bluecolor),
                  ),
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.07, top: height * 0.05, right: width * 0.07),
              child: SizedBox(
                height: height * 0.06,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: StyleText.getRegularStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: height * 0.024,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      style: StyleText.getRegularStyle(
                        fontSize: height * 0.019,
                        color: AppColors.mygreycolor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.04),
                  child: TextButton(
                    onPressed: () {
                      Get.offAll(() => const SignUpPage());
                    },
                    child: Text(
                      "Sign Up",
                      style: StyleText.getRegularStyle(
                        fontSize: height * 0.019,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
