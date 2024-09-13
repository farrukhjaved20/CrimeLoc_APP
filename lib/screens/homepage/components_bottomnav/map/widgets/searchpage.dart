import 'dart:convert';

import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.kappBlueColor,
        centerTitle: true,
        title: Text(
          'Search Places',
          style: TextStyle(
            fontSize: SizeConfig.screenHeight * 0.024,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
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
