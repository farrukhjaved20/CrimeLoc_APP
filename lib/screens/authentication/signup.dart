import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/screens/authentication/sigin.dart';
import 'package:crime_heat/services/authenticationController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? checkvalue = false;
  final formKey = GlobalKey<FormState>();
  final AuthenticationController authenticationController =
      Get.find<AuthenticationController>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
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
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Text('Who is join to CrimeLoc App?',
                    style: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.mygreycolor,
                        fontSize: height * 0.029)),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, left: width * 0.05),
                child: Text('First Name *',
                    style: StyleText.getRegularStyle(
                        color: AppColors.kappBlueColor,
                        fontWeight: FontWeight.w800,
                        fontSize: height * 0.02)),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.10, left: width * 0.05),
                  child: TextFormField(
                    keyboardAppearance: Brightness.light,
                    controller: myControllers.namecontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Name';
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
                        hintStyle: StyleText.getRegularStyle(
                            color: AppColors.kappBlueColor,
                            fontWeight: FontWeight.w200,
                            fontSize: height * 0.02),
                        hintText: 'Your first name'),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, left: width * 0.05),
                child: Text('Email *',
                    style: StyleText.getRegularStyle(
                        color: AppColors.kappBlueColor,
                        fontWeight: FontWeight.w800,
                        fontSize: height * 0.02)),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.10, left: width * 0.05),
                  child: TextFormField(
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
                    keyboardAppearance: Brightness.light,
                    controller: myControllers.emailcontroller,
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
                        hintStyle: StyleText.getRegularStyle(
                            color: AppColors.kappBlueColor,
                            fontWeight: FontWeight.w200,
                            fontSize: height * 0.02),
                        hintText: 'Your email address'),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, left: width * 0.05),
                child: Text('Password *',
                    style: StyleText.getRegularStyle(
                        color: AppColors.kappBlueColor,
                        fontWeight: FontWeight.w800,
                        fontSize: height * 0.02)),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.10, left: width * 0.05),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: myControllers.passwordcontroller,
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
                        hintStyle: StyleText.getRegularStyle(
                            color: AppColors.kappBlueColor,
                            fontWeight: FontWeight.w200,
                            fontSize: height * 0.02),
                        hintText: 'Choose a password'),
                  )),
              CheckboxListTile(
                contentPadding: EdgeInsets.only(
                    top: height * 0.02,
                    left: width * 0.08,
                    right: width * 0.08),
                controlAffinity: ListTileControlAffinity.leading,
                title: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: 'I agree to the',
                    style: StyleText.getRegularStyle(
                        color: Colors.black, fontSize: height * 0.018),
                  ),
                  TextSpan(
                    text: ' Terms of Services',
                    style: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.kappRedColor,
                        fontSize: height * 0.018),
                  ),
                  TextSpan(
                    text: ' and',
                    style: StyleText.getRegularStyle(
                        color: Colors.black, fontSize: height * 0.018),
                  ),
                  TextSpan(
                    text: '  Privacy Policy.',
                    style: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.kappRedColor,
                        fontSize: height * 0.018),
                  ),
                ])),
                value: checkvalue,
                checkColor: Colors.white,
                activeColor: AppColors.kappRedColor,
                onFocusChange: (value) {
                  checkvalue = value;
                },
                onChanged: (value) {
                  setState(() {
                    print(checkvalue);
                    checkvalue = value;
                    print(checkvalue);
                  });
                },
              ),
              SizedBox(height: height * 0.01),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Have an Account?',
                      style: StyleText.getRegularStyle(
                          decoration:
                              TextDecoration.underline, // Underline the text
                          decorationColor:
                              AppColors.mygreycolor, // Color of the underline
                          color: AppColors.mygreycolor,
                          fontSize: height * 0.02),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const SignInPage());
                        },
                        child: Text(
                          'Sign in',
                          style: StyleText.getRegularStyle(
                              color: AppColors.kappRedColor,
                              decoration: TextDecoration
                                  .underline, // Underline the text
                              decorationColor: AppColors.kappRedColor,
                              fontSize: height * 0.022),
                        )),
                  ],
                ),
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.05,
                      bottom: height * 0.04,
                      right: width * 0.07),
                  child: SizedBox(
                    height: height * 0.06,
                    width: width * 0.9,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          FocusScope.of(context).unfocus();
                          Get.find<AuthenticationController>().signUp(
                            myControllers.namecontroller.text,
                            myControllers.emailcontroller.text,
                            myControllers.passwordcontroller.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kappRedColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: Get.find<AuthenticationController>()
                              .isLoading
                              .value
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Sign Up",
                              style: StyleText.getRegularStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: height * 0.024,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
