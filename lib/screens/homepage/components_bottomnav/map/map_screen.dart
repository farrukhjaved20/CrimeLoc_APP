import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/model/spots.dart';
import 'package:crime_heat/screens/crimeTrend_screen.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/addissue.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/crime_sence.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/widgets/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

const kGoogleApiKey = 'AIzaSyA9USqEQDiWQZ1rzr26wowtIoWc3kZjNGI';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  _MapHomeScreenState createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen> {
  GoogleMapController? mapController;
  final Set<Polygon> _polygons = {};
  final Set<Marker> _markers = {};
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  loc.LocationData? _currentLocation;
  final loc.Location _locationService = loc.Location();
  LatLng? _selectedArea;
  String? _selectedLocationDescription;
  final List<Spot> _spots = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Spot>>? _spotsStream;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _spotsStream = _firestore.collection('crime-spots').snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Spot.fromFirestore(doc)).toList(),
        );
  }

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await _locationService.getLocation();
    if (_currentLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15.0,
        ),
      );
      _updateCurrentLocationMarker();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15.0,
        ),
      );
      _updateCurrentLocationMarker();
    }
    _polygons.clear();
    _markers.clear();
    _addSpotsToMap();
  }

  void _updateCurrentLocationMarker() {
    if (_currentLocation != null) {
      final marker = Marker(
        markerId: const MarkerId('currentLocation'),
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        infoWindow: const InfoWindow(title: 'Your Location'),
      );
      if (mounted) {
        setState(() {
          _markers.add(marker);
        });
      }
    }
  }

  void _onPlaceSelected(Prediction prediction) async {
    if (prediction.placeId != null) {
      final detail = await _places.getDetailsByPlaceId(prediction.placeId!);
      if (detail.status == 'OK' && detail.result.geometry != null) {
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

        if (mounted) {
          setState(() {
            _markers.clear();
            _markers.add(
              Marker(
                markerId: MarkerId(prediction.placeId!),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: prediction.description),
                onTap: () => _onMarkerTapped(LatLng(lat, lng)), // Add this line
              ),
            );
            _selectedArea = LatLng(lat, lng);
            _selectedLocationDescription = prediction.description;
          });
        }
      } else {
        print('Details response or geometry is null');
      }
    }
  }

  void _addSpotsToMap() {
    _spotsStream?.listen((spots) {
      setState(() {
        _spots.clear();
        _polygons.clear();
        _markers.clear();
        _spots.addAll(spots);
        for (var spot in _spots) {
          _polygons.add(
            Polygon(
              polygonId: PolygonId(spot.latLng.toString()),
              points: _generateCirclePoints(spot.latLng, spot.radius),
              strokeColor: spot.color,
              strokeWidth: 3,
              fillColor: spot.color.withOpacity(0.4),
            ),
          );
          _markers.add(
            Marker(
              markerId: MarkerId(spot.latLng.toString()),
              position: spot.latLng,
              infoWindow: const InfoWindow(title: 'Crime Spot'),
              onTap: () => _onMarkerTapped(spot.latLng), // Add this line
            ),
          );
        }
      });
    });
  }

  List<LatLng> _generateCirclePoints(LatLng center, double radius) {
    const int numPoints = 360;
    List<LatLng> points = [];
    for (int i = 0; i < numPoints; i++) {
      double angle = i * (2 * 3.14159 / numPoints);
      double dx = radius * cos(angle);
      double dy = radius * sin(angle);
      double lat =
          center.latitude + (dx / 111320); // Rough conversion for latitude
      double lng = center.longitude +
          (dy /
              (111320 *
                  cos(center.latitude *
                      3.14159 /
                      180))); // Rough conversion for longitude
      points.add(LatLng(lat, lng));
    }
    return points;
  }

  void _moveToCurrentLocation() {
    if (_currentLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15.0,
        ),
      );
    }
  }

  Future<void> _onMarkerTapped(LatLng spotLocation) async {
    final crimeDetails = await fetchCrimeDetailsForSpot(spotLocation);

    if (crimeDetails.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CrimeDetailsNavigatorScreen(
            crimeDetails: crimeDetails,
            crimeLocation: spotLocation,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No crime details available for this location.')),
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchCrimeDetailsForSpot(
      LatLng spotLocation) async {
    // Fetch data from Firestore or any other source
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('crime-spots')
        .where('latitude', isEqualTo: spotLocation.latitude)
        .where('longitude', isEqualTo: spotLocation.longitude)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print('build');

    return Stack(
      children: [
        StreamBuilder<List<Spot>>(
          stream: _spotsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              _spots.clear();
              _polygons.clear();
              _markers.clear();
              _spots.addAll(snapshot.data!);
              for (var spot in _spots) {
                _polygons.add(
                  Polygon(
                    polygonId: PolygonId(spot.latLng.toString()),
                    points: _generateCirclePoints(spot.latLng, spot.radius),
                    strokeColor: spot.color,
                    strokeWidth: 3,
                    fillColor: spot.color.withOpacity(0.4),
                  ),
                );
                _markers.add(
                  Marker(
                    markerId: MarkerId(spot.latLng.toString()),
                    position: spot.latLng,
                    infoWindow: const InfoWindow(title: 'Crime Spot'),
                    onTap: () => _onMarkerTapped(spot.latLng),
                  ),
                );
              }
            }
            return _currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                      ),
                      zoom: 15.0,
                    ),
                    polygons: _polygons,
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  );
          },
        ),
        Positioned(
          top: 70.0,
          left: 16.0,
          right: 16.0,
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceSearchScreen(
                    onPlaceSelected: _onPlaceSelected,
                  ),
                ),
              );
              if (result != null) {
                _onPlaceSelected(result);
              }
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.kappBlueColor, width: 2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        _selectedLocationDescription ?? 'Search for a place',
                        style: StyleText.getRegularStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.016)),
                  ),
                  Icon(Icons.search, color: AppColors.kappBlueColor),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: 16.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kappRedColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            onPressed: _moveToCurrentLocation,
            child: Icon(Icons.my_location, color: AppColors.whitecolor),
          ),
        ),
        Positioned(
          bottom: 142,
          right: 16.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kappRedColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            onPressed: () => Get.to(() => const CrimeTrendsScreen()),
            child:
                Icon(Icons.trending_up_outlined, color: AppColors.whitecolor),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 16.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kappRedColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            onPressed: () async {
              final newSpot = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddIssue(spots: _spots),
                ),
              );
              // Only add to Firestore if newSpot is not null and has not already been added
            },
            child: Icon(Icons.add, color: AppColors.whitecolor),
          ),
        )
      ],
    );
  }
}
