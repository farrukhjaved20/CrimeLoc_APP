import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/widgets/custom_Dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crime_heat/services/crimeTrendController.dart';

class CrimeTrendsScreen extends StatelessWidget {
  const CrimeTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CrimeController controller = Get.put(CrimeController());

    // Colors for different crime types
    final Map<String, Color> crimeColors = {
      'Kidnapping': Colors.pinkAccent,
      'Mobile snatching': Colors.blueAccent,
      'Vehicle Theft': Colors.redAccent,
      'Burglary': Colors.orangeAccent,
    };

    // List of months
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    // Get the current year
    final currentYear = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'View Crime Trends',
          style: StyleText.getBoldStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: AppColors.whitecolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),

            // Custom Dropdown to select a city
            Obx(() {
              if (controller.cities.isEmpty) {
                return const Text('No cities available');
              }

              return CustomDropdownTextFormField(
                options: {for (var city in controller.cities) city: city},
                selectedValue: controller.selectedCity.value.isEmpty
                    ? null
                    : controller.selectedCity.value,
                onChanged: (newCity) {
                  controller.selectedCity.value = newCity;
                  controller
                      .countCrimeOccurrences(); // Fetch data based on selected city
                },
                labelTitle: 'Select City',
                hintTitle: 'Select City',
              );
            }),

            const SizedBox(height: 16.0),

            // Custom Dropdown to select a month
            CustomDropdownTextFormField(
              labelTitle: 'Select Month',
              options: {for (var month in months) month: month},
              selectedValue: controller.selectedMonth.value.isEmpty
                  ? null
                  : controller.selectedMonth.value,
              onChanged: (newMonth) {
                controller.selectedMonth.value = newMonth;
              },
              hintTitle: 'Select Month',
            ),

            const SizedBox(height: 16.0),
            const Text(
              'CrimeTypes',
              style: TextStyle(fontSize: 24),
            ),
            // Box to represent colors of crime types with light gray background
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 4, // Adjust ratio to fit content nicely
                ),
                itemCount: crimeColors.length,
                itemBuilder: (context, index) {
                  final entry = crimeColors.entries.elementAt(index);
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24, // Size of the color box
                          height: 24, // Size of the color box
                          color: entry.value,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16.0), // Add spacing
            Text(
              'Year: $currentYear',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Bar chart to display total crime occurrences for selected month and city
            Obx(() {
              final selectedMonthIndex =
                  months.indexOf(controller.selectedMonth.value);
              final crimeTypes = controller.crimeTypes;

              // If no month is selected, display total counts
              final displayData = selectedMonthIndex == -1
                  ? controller.allMonthCrimeCounts
                  : {
                      for (var type in crimeTypes)
                        type: (controller.crimeCountsByMonth[type] != null &&
                                controller.crimeCountsByMonth[type]!.length >
                                    selectedMonthIndex)
                            ? controller
                                .crimeCountsByMonth[type]![selectedMonthIndex]
                            : 0, // Use 0 if data is unavailable for the selected month
                    };

              final crimeCounts = crimeTypes
                  .map((type) => ChartData(
                        type,
                        displayData[type] ?? 0,
                      ))
                  .toList();

              return Container(
                margin: EdgeInsets.only(
                    bottom: 20, right: SizeConfig.screenWidth * 0.011),
                height: 450, // Set height for the chart to make it bigger
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    isVisible: true,
                    borderColor: Colors.transparent,
                    labelStyle: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.011,
                        fontWeight: FontWeight.bold),
                  ),
                  primaryYAxis: const NumericAxis(
                    title: AxisTitle(text: 'Occurrences'),
                    minimum: 0,
                    maximum: 50, // Set maximum to a higher value if needed
                    interval: 10, // Set intervals to 10, 20, 30, 40
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: crimeCounts,
                      xValueMapper: (ChartData data, _) => data.crimeType,
                      yValueMapper: (ChartData data, _) => data.count,
                      pointColorMapper: (ChartData data, _) =>
                          crimeColors[data.crimeType] ?? Colors.grey,
                      width: 0.7, // Adjust bar width to make bars wider
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.crimeType, this.count);

  final String crimeType;
  final int count;
}
