import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/services/crimeHistoryController.dart';

class CrimeHistoryScreen extends StatelessWidget {
  const CrimeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CrimeHistoryController controller = Get.put(CrimeHistoryController());

    // Fetch crime reports for the current user
    controller.fetchCrimeReports(
        Get.find<AuthenticationController>().user.value.email ?? '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'View History',
          style: StyleText.getBoldStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200], // Background color of the screen
      body: Obx(() {
        if (controller.crimeReports.isEmpty) {
          return const Center(child: Text('No crime reports found.'));
        }

        return ListView.builder(
          itemCount: controller.crimeReports.length,
          itemBuilder: (context, index) {
            final report = controller.crimeReports[index];
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 5, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              color: Colors.white, // Card background color
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.kappRedColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Area: ${report.area}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_city,
                            color: AppColors.kappRedColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('City: ${report.city}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.security, color: AppColors.kappRedColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Crime Type: ${report.crimeType}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.date_range, color: AppColors.kappRedColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Date & Time: ${report.dateTime}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.description, color: AppColors.kappRedColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Description: ${report.description}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
