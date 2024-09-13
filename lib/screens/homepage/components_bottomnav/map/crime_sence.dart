import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/services/crime_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrimeDetailsNavigatorScreen extends StatelessWidget {
  final LatLng crimeLocation;
  final List<Map<String, dynamic>> crimeDetails;

  const CrimeDetailsNavigatorScreen({
    super.key,
    required this.crimeLocation,
    required this.crimeDetails,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CrimeDetailsController(
        initialLocation: crimeLocation,
        initialCrimeDetails: crimeDetails,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Crime Details'),
        backgroundColor: AppColors.kappBlueColor,
      ),
      body: Obx(() {
        if (controller.crimeDetails.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final currentCrime =
            controller.crimeDetails[controller.currentIndex.value];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: crimeLocation,
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController mapController) {
                    controller.mapController = mapController;
                    controller.updateMapLocation();
                  },
                  markers: controller.markers,
                ),
              ),
              const SizedBox(height: 20),
              _buildReadOnlyTextField('City', currentCrime['city']),
              const SizedBox(height: 10),
              _buildReadOnlyTextField('Area', currentCrime['area']),
              const SizedBox(height: 10),
              _buildReadOnlyTextField('Crime Type', currentCrime['crimeType']),
              const SizedBox(height: 10),
              _buildReadOnlyTextField('Date & Time', currentCrime['dateTime']),
              const SizedBox(height: 10),
              _buildReadOnlyTextField(
                  'Description', currentCrime['description'],
                  maxLines: 4),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (controller.currentIndex.value > 0)
                    ElevatedButton(
                      onPressed: controller.onPreviousPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kappRedColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('< Previous'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: controller.onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.hasMoreData.value ||
                              controller.currentIndex.value <
                                  controller.crimeDetails.length - 1
                          ? AppColors.kappRedColor
                          : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: controller.hasMoreData.value
                        ? const Text('Next >')
                        : const Text('No More Data'),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyTextField(String label, String value,
      {int maxLines = 1}) {
    return TextField(
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
        ),
      ),
      readOnly: true,
      maxLines: maxLines,
    );
  }
}
