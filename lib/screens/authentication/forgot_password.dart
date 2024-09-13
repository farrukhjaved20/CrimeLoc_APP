import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/screens/authentication/sigin.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                      height: height * 0.3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.07,
                  ),
                  child: Text(
                    "Password Reset",
                    style: StyleText.getBoldStyle(
                      fontSize: height * 0.03,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                  child: Text(
                    maxLines: 2,
                    "You Will Get An Email Link To Reset Your Password",
                    style: StyleText.getRegularStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: height * 0.018,
                      color: AppColors.mygreycolor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.03,
                      right: width * 0.07),
                  child: TextFormField(
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
                            if (formKey.currentState?.validate() ?? false) {
                              FocusScope.of(context).unfocus();

                              await Get.find<AuthenticationController>()
                                  .changePassword(
                                      myControllers.emailcontroller.text);
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
                                  "Reset Password",
                                  style: StyleText.getRegularStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                  ),
                                )),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07,
                      top: height * 0.02,
                      right: width * 0.07),
                  child: SizedBox(
                    height: height * 0.06,
                    width: width * 0.9,
                    child: ElevatedButton(
                        onPressed: () async {
                          Get.offAll(() => const SignInPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kappRedColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: Text(
                          "Back To Sign In",
                          style: StyleText.getRegularStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: height * 0.02,
                          ),
                        )),
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
