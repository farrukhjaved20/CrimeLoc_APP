import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/screens/authentication/forgot_password.dart';
import 'package:crime_heat/screens/authentication/signup.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/size_configs.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Image.asset(
                      'assets/images/crimeloc-03.png',
                      height: height * 0.3, // Adjust height as needed
                      width: double.infinity, // Adjust width as needed
                      fit: BoxFit.cover, // Adjust fit if needed
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.07,
                  ),
                  child: Text(
                    "Sign In",
                    style: StyleText.getBoldStyle(
                      fontSize: height * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.07),
                  child: Text(
                    "Hi there! Nice to see you again.",
                    style: StyleText.getRegularStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.023,
                      color: AppColors.mygreycolor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.02,
                      right: width * 0.07),
                  child: TextFormField(
                    focusNode: emailFocusNode,
                    controller: myControllers.emailcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Email';
                      }
                      if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Please Enter A Valid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      labelText: "Email",
                      hintText: 'Enter Your Email',
                      hintStyle: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kappBlueColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: StyleText.getRegularStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.kappBlueColor,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.02,
                      right: width * 0.07),
                  child: TextFormField(
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    controller: myControllers.passwordcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: 'Enter Your Password',
                      hintStyle: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kappBlueColor,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: StyleText.getRegularStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.kappBlueColor,
                          fontSize: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.07,
                        top: height * 0.02,
                        right: width * 0.07),
                    child: SizedBox(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();
                              Get.find<AuthenticationController>().signIn(
                                  myControllers.emailcontroller.text,
                                  myControllers.passwordcontroller.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kappRedColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: Get.find<AuthenticationController>()
                                  .isLoading
                                  .value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Sign In",
                                  style: StyleText.getRegularStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: height * 0.024,
                                  ),
                                )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => const ForgotPassword());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: StyleText.getRegularStyle(
                            fontSize: height * 0.02,
                            color: AppColors.mygreycolor,
                            fontWeight: FontWeight.w600,
                            decoration:
                                TextDecoration.underline, // Underline the text
                            decorationColor:
                                AppColors.mygreycolor, // Color of the underline
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.05),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: StyleText.getRegularStyle(
                            fontSize: height * 0.02,
                            color: AppColors.kappRedColor,
                            fontWeight: FontWeight.w600,
                            decoration:
                                TextDecoration.underline, // Underline the text
                            decorationColor: AppColors
                                .kappRedColor, // Color of the underline
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
