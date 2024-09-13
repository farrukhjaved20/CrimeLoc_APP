import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({super.key});

  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'Change Name',
          style: StyleText.getBoldStyle(
            fontSize: height * 0.024,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: myControllers.namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Name';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: 'Enter Your Name',
                    hintStyle: StyleText.getRegularStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.kappBlueColor,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: StyleText.getRegularStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.kappBlueColor,
                        fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 2, color: AppColors.kappBlueColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 2, color: AppColors.kappBlueColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 2, color: AppColors.kappBlueColor),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() => AppButton(
                  text: 'Change Name',
                  showLoader:
                      Get.find<AuthenticationController>().isLoading.value,
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      FocusScope.of(context).unfocus();
                      await Get.find<AuthenticationController>()
                          .updateUserName(myControllers.namecontroller.text);
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
