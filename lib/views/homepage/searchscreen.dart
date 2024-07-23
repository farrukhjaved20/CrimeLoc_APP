// ignore_for_file: library_private_types_in_public_api

import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const kGoogleApiKey = 'AIzaSyA9USqEQDiWQZ1rzr26wowtIoWc3kZjNGI';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.7749, -122.4194);
  final Set<Polygon> _polygons = {};
  final Set<Marker> _markers = {};
  final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  loc.LocationData? _currentLocation;
  final loc.Location _locationService = loc.Location();
  LatLng? _selectedArea;
  String? _selectedLocationDescription;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
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
    setState(() {
      _updateCurrentLocationMarker();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentLocation != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15.0,
        ),
      );
      _updateCurrentLocationMarker();
    }
    _addPolygon();
  }

  void _updateCurrentLocationMarker() {
    if (_currentLocation != null) {
      final marker = Marker(
        markerId: const MarkerId('currentLocation'),
        position:
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        infoWindow: const InfoWindow(title: 'Your Location'),
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

  void _addPolygon() {
    final polygon = Polygon(
      polygonId: const PolygonId('area'),
      points: const [
        LatLng(37.7749, -122.4194),
        LatLng(37.7849, -122.4294),
        LatLng(37.7949, -122.4394),
        LatLng(37.7749, -122.4494),
        LatLng(37.7649, -122.4294),
      ],
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.15),
    );
    setState(() {
      _polygons.add(polygon);
    });
  }

  void _onPlaceSelected(Prediction prediction) async {
    if (prediction.placeId != null) {
      final detail = await _places.getDetailsByPlaceId(prediction.placeId!);
      if (detail.status == "OK" && detail.result.geometry != null) {
        final lat = detail.result.geometry!.location.lat;
        final lng = detail.result.geometry!.location.lng;

        mapController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

        setState(() {
          _markers.clear();
          _markers.add(
            Marker(
              markerId: MarkerId(prediction.placeId!),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: prediction.description),
            ),
          );
          _selectedArea = LatLng(lat, lng);
          _selectedLocationDescription = prediction.description;
        });
      } else {
        print('Details response or geometry is null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PlaceSearchScreen(onPlaceSelected: _onPlaceSelected),
                ),
              );
              if (result != null) {
                _onPlaceSelected(result);
              }
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedLocationDescription ?? 'Search for a place',
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.black54),
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'Explore',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: height * 0.07,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: height * 0.5,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _currentLocation != null
                  ? CameraPosition(
                      target: LatLng(
                        _currentLocation!.latitude!,
                        _currentLocation!.longitude!,
                      ),
                      zoom: 15.0,
                    )
                  : CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
              polygons: _polygons,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceSearchScreen extends StatefulWidget {
  final Function(Prediction) onPlaceSelected;

  const PlaceSearchScreen({super.key, required this.onPlaceSelected});

  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final _controller = TextEditingController();
  final String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (_controller.text.isNotEmpty) {
      getSuggestion(_controller.text);
    } else {
      setState(() {
        _placeList = [];
      });
    }
  }

  void getSuggestion(String input) async {
    const String placesApiKey = kGoogleApiKey;

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data is Map<String, dynamic> && data['predictions'] is List) {
          setState(() {
            _placeList = data['predictions'];
          });
        } else {
          throw Exception('Unexpected API response format');
        }
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  void _clearSuggestions() {
    setState(() {
      _placeList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Places'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                    _clearSuggestions();
                  },
                ),
              ),
            ),
          ),
          if (_placeList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final placeId = _placeList[index]["place_id"];
                      final description = _placeList[index]["description"];
                      if (placeId != null) {
                        final prediction = Prediction(
                            placeId: placeId, description: description);
                        Navigator.pop(context, prediction);
                      }
                    },
                    child: ListTile(
                      title: Text(_placeList[index]["description"]),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// class GoogleMapSearchPlacesApi extends StatefulWidget {
//   final Function(Prediction) onPlaceSelected;
//   final Function(_GoogleMapSearchPlacesApiState) onStateCreated;

//   const GoogleMapSearchPlacesApi({
//     super.key,
//     required this.onPlaceSelected,
//     required this.onStateCreated,
//   });

//   @override
//   _GoogleMapSearchPlacesApiState createState() =>
//       _GoogleMapSearchPlacesApiState();
// }

// class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
//   final _controller = TextEditingController();
//   final String _sessionToken = '1234567890';
//   List<dynamic> _placeList = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_onChanged);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.onStateCreated(this);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_onChanged);
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onChanged() {
//     if (_controller.text.isNotEmpty) {
//       getSuggestion(_controller.text);
//     } else {
//       setState(() {
//         _placeList = [];
//       });
//     }
//   }

//   void getSuggestion(String input) async {
//     const String placesApiKey = kGoogleApiKey;

//     try {
//       String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request =
//           '$baseURL?input=$input&key=$placesApiKey&sessiontoken=$_sessionToken';
//       var response = await http.get(Uri.parse(request));

//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         if (data is Map<String, dynamic> && data['predictions'] is List) {
//           setState(() {
//             _placeList = data['predictions'];
//           });
//         } else {
//           throw Exception('Unexpected API response format');
//         }
//       } else {
//         throw Exception('Failed to load predictions');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _clearSuggestions() {
//     setState(() {
//       _placeList = [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Align(
//           alignment: Alignment.topCenter,
//           child: TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: "Search your location here",
//               focusColor: Colors.white,
//               floatingLabelBehavior: FloatingLabelBehavior.never,
//               prefixIcon: const Icon(Icons.map),
//               suffixIcon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.cancel),
//                     onPressed: () {
//                       _controller.clear();
//                       _clearSuggestions();
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.pin_drop),
//                     onPressed: () {
//                       widget.onPlaceSelected(
//                         Prediction(
//                           placeId: '',
//                           description: 'Show Selected Area',
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         if (_placeList.isNotEmpty)
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: _placeList.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () async {
//                   final placeId = _placeList[index]["place_id"];
//                   final description = _placeList[index]["description"];
//                   if (placeId != null) {
//                     _controller.text = description;
//                     _controller.selection = TextSelection.fromPosition(
//                       TextPosition(offset: _controller.text.length),
//                     );
//                     FocusScope.of(context).unfocus();
//                     final prediction =
//                         Prediction(placeId: placeId, description: description);
//                     widget.onPlaceSelected(prediction);
//                     _clearSuggestions();
//                   }
//                 },
//                 child: ListTile(
//                   title: Text(_placeList[index]["description"]),
//                 ),
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
