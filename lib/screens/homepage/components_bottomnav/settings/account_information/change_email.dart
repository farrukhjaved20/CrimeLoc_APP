import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Change Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Change Email',
                style: StyleText.getRegularStyle(
                  fontSize: SizeConfig.screenHeight * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: myControllers.emailcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  hintText:
                      'Your Current Email is ${authentication.currentUser!.email}',
                  hintStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonColor,
                    fontSize: 24,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: myControllers.passwordcontroller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.buttonColor),
                  ),
                  hintText: 'Your Current Password',
                  hintStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonColor,
                    fontSize: 24,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Obx(
                () => AppButton(
                  text: 'Change Email',
                  showLoader:
                      Get.find<AuthenticationController>().isLoading.value,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Get.find<AuthenticationController>().updateEmail(
                        myControllers.emailcontroller.text,
                        myControllers.passwordcontroller.text,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
