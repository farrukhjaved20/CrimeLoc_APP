import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.kappBlueColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Get Help',
          style: StyleText.getBoldStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'FAQs',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'See if any of the following answers your question?',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: faqs.map((faq) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ExpansionPanelList(
                          elevation: 2,
                          expandedHeaderPadding: EdgeInsets.zero,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              faq['isExpanded'] = !faq['isExpanded'];
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: AppColors.kappBlueColor,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  tileColor: Colors.white,
                                  title: Text(
                                    faq['question'],
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                );
                              },
                              body: Container(
                                color: Colors
                                    .white, // Set the background color to white
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Answer", // Add the heading
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            5), // Add spacing between heading and answer
                                    Text(
                                      faq['answer'], // Display the answer
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              isExpanded: faq['isExpanded'],
                            ),
                          ]));
                }).toList(),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.07,
                    top: SizeConfig.screenHeight * 0.02,
                    right: SizeConfig.screenWidth * 0.07),
                child: SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                  width: SizeConfig.screenWidth * 0.9,
                  child: ElevatedButton(
                      onPressed: () async {},
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.kappRedColor),
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.white),
                        splashFactory:
                            InkSparkle.constantTurbulenceSeedSplashFactory,
                        foregroundColor:
                            MaterialStatePropertyAll(AppColors.kappRedColor),
                      ),
                      child: Get.find<AuthenticationController>()
                              .isLoading
                              .value
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Contact Us !",
                              style: StyleText.getRegularStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: SizeConfig.screenHeight * 0.024,
                              ),
                            )),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
