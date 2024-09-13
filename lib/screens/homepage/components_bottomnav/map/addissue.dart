import 'dart:convert';

import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/model/spots.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/crime_sence.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'map_screen.dart';

import 'package:uuid/uuid.dart';

class AddIssue extends StatefulWidget {
  final List<Spot> spots;

  const AddIssue({super.key, required this.spots});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  String? selectedCity;
  String? crimeType;
  DateTime? selectedDateTime;
  LatLng? selectedLocation;
  final loc.Location _location = loc.Location();
  loc.LocationData? _currentLocation;
  String? locationDescription;
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  final TextEditingController _descriptionController = TextEditingController();
  GoogleMapController? _mapController;
  final Map<String, LatLng> _cityCoordinates = {
    'Karachi': const LatLng(24.8607, 67.0011),
    'Lahore': const LatLng(31.5204, 74.3587),
    'Faisalabad': const LatLng(31.4504, 73.1350),
    'Islamabad': const LatLng(33.6995, 73.0363),
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final loc.LocationData location = await _location.getLocation();
      setState(() {
        _currentLocation = location;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location')),
      );
    }
  }

  bool _isSubmitting = false;
  void _submitForm() async {
    if (_isSubmitting) return;

    if (selectedCity != null &&
        crimeType != null &&
        selectedDateTime != null &&
        selectedLocation != null) {
      setState(() {
        _isSubmitting = true;
      });
      Get.find<AuthenticationController>().isLoading.value = true;
      Spot newSpot = Spot(
          latLng: selectedLocation!,
          intensity: 1.0,
          radius: 200,
          color: Colors.red.withOpacity(0.6),
          city: selectedCity!,
          area: locationDescription!,
          crimeType: crimeType!,
          dateTime: selectedDateTime!,
          description: _descriptionController.text,
          email: authentication.currentUser!.email);
      var uuid = const Uuid();
      // Generate a unique ID for the new crime report
      String uniqueId = uuid.v4();

      // Save to Firestore using the unique ID
      await FirebaseFirestore.instance
          .collection('crime-spots')
          .doc() // Use unique ID here
          .set(newSpot.toFirestore());

      Navigator.pop(context, newSpot);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crime reported successfully!')),
      );

      setState(() {
        _isSubmitting = false;
      });
      Get.find<AuthenticationController>().isLoading.value = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      Get.find<AuthenticationController>().isLoading.value = false;
    }
  }

  void _navigateToLocationPicker() async {
    LatLng initialPosition;

    if (selectedCity != null && _cityCoordinates.containsKey(selectedCity)) {
      initialPosition = _cityCoordinates[selectedCity]!;
    } else if (_currentLocation != null) {
      initialPosition = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );
    } else {
      initialPosition = const LatLng(0, 0);
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialPosition: initialPosition,
          onLocationPicked: (latLng, address) {
            setState(() {
              selectedLocation = latLng;
              locationDescription = address;
            });
          },
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedLocation = result['latLng'];
        locationDescription = result['address'];
      });
    }
  }

  void _onCitySelected(String? city) {
    setState(() {
      selectedCity = city;
      if (city != null && _cityCoordinates.containsKey(city)) {
        LatLng cityCoordinates = _cityCoordinates[city]!;

        _mapController?.animateCamera(
          CameraUpdate.newLatLng(cityCoordinates),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'Add A Crime Scene',
          style: TextStyle(
            fontSize: height * 0.024,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(24.8607, 67.0011),
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                markers: {
                  if (selectedLocation != null)
                    Marker(
                      markerId: const MarkerId('crimeLocation'),
                      position: selectedLocation!,
                    ),
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DropdownButtonFormField<String>(
                focusColor: AppColors.kappRedColor,
                iconSize: 24,
                icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                iconEnabledColor: AppColors.kappRedColor,
                decoration: InputDecoration(
                  hintText: 'Select City',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
                value: selectedCity,
                hint: const Text('Select City'),
                items: _cityCoordinates.keys.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: _onCitySelected,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: DropdownButtonFormField<String>(
                focusColor: AppColors.kappRedColor,
                iconSize: 24,
                icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                iconEnabledColor: AppColors.kappRedColor,
                decoration: InputDecoration(
                  hintText: 'Select Crime Type',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.kappBlueColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
                value: crimeType,
                hint: const Text('Select Crime Type'),
                onChanged: (String? newValue) {
                  setState(() {
                    crimeType = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                      value: "Mobile snatching",
                      child: Text("Mobile snatching")),
                  DropdownMenuItem(
                      value: "Kidnapping", child: Text("Kidnapping")),
                  DropdownMenuItem(
                      value: "Vehicle Theft", child: Text("Vehicle Theft")),
                  DropdownMenuItem(value: "Burglary", child: Text("Burglary")),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: AbsorbPointer(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: selectedDateTime == null
                          ? 'Select Date and Time'
                          : DateFormat('d MMMM yyyy hh:mm a')
                              .format(selectedDateTime!),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      suffixIcon: Icon(Icons.calendar_today,
                          color: AppColors.kappRedColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _navigateToLocationPicker,
              child: AbsorbPointer(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: locationDescription ?? 'Pick Your Location',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            width: 2, color: AppColors.kappBlueColor),
                      ),
                      suffixIcon: Icon(Icons.location_on,
                          color: AppColors.kappRedColor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Description',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.kappBlueColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.kappBlueColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: AppColors.kappBlueColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.kappRedColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Get.find<AuthenticationController>().isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "Submit",
                            style: StyleText.getRegularStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: height * 0.024,
                            ),
                          )),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}

class MapScreen extends StatefulWidget {
  final LatLng initialPosition;
  final Function(LatLng latLng, String address) onLocationPicked;

  const MapScreen({
    super.key,
    required this.initialPosition,
    required this.onLocationPicked,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;
  Set<Marker> _markers = {};
  final String _apiKey = 'AIzaSyA9USqEQDiWQZ1rzr26wowtIoWc3kZjNGI';

  @override
  void initState() {
    super.initState();
    _fetchMarkers();
  }

  Future<void> _fetchMarkers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('crime-spots').get();
    Set<Marker> fetchedMarkers = querySnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(data['latitude'], data['longitude']),
        onTap: () =>
            _onMarkerTapped(LatLng(data['latitude'], data['longitude'])),
      );
    }).toSet();

    setState(() {
      _markers = fetchedMarkers;
    });
  }

  void _onMarkerTapped(LatLng location) async {
    // Fetch crime details for the tapped marker location
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('crime-spots')
        .where('latitude', isEqualTo: location.latitude)
        .where('longitude', isEqualTo: location.longitude)
        .get();

    List<Map<String, dynamic>> crimeDetails = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrimeDetailsNavigatorScreen(
          crimeLocation: location,
          crimeDetails: crimeDetails, // Pass crimeDetails here
        ),
      ),
    );
  }

  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$_apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK' &&
          data['results'] != null &&
          data['results'].isNotEmpty) {
        final results = data['results'] as List;
        final address =
            results.first['formatted_address'] ?? 'Unknown location';
        return address;
      } else {
        return 'No address found';
      }
    } else {
      print('Failed to load address data');
      return 'Error fetching location';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Location'),
        backgroundColor: AppColors.kappBlueColor,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initialPosition,
          zoom: 12.0,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onTap: (LatLng latLng) async {
          final address = await _getAddressFromLatLng(latLng);

          setState(() {
            _pickedLocation = latLng;
            _markers = {
              Marker(
                markerId: const MarkerId('selected'),
                position: latLng,
              ),
            };
          });

          widget.onLocationPicked(latLng, address);
        },
        markers: _markers,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 35.0, bottom: 40),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            backgroundColor: AppColors.kappRedColor.withOpacity(0.4),
            foregroundColor: Colors.white,
            onPressed: () async {
              if (_pickedLocation != null) {
                final address = await _getAddressFromLatLng(_pickedLocation!);
                Navigator.pop(
                  context,
                  {
                    'latLng': _pickedLocation,
                    'address': address,
                  },
                );
              }
            },
            child: const Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}
