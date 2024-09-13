import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Spot {
  final LatLng latLng;
  final double intensity;
  final double radius;
  final Color color;
  final String city;
  final String area;
  final String crimeType;
  final DateTime dateTime;
  final String description;
  final String? email;

  Spot(
      {required this.latLng,
      required this.intensity,
      required this.radius,
      required this.color,
      required this.city,
      required this.area,
      required this.crimeType,
      required this.dateTime,
      required this.description,
      this.email});

  factory Spot.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Spot(
      latLng: LatLng(data['latitude'], data['longitude']),
      intensity: data['intensity'],
      radius: data['radius'],
      color: Color(int.parse(data['color'], radix: 16)),
      city: data['city'],
      area: data['area'],
      crimeType: data['crimeType'],
      dateTime: DateTime.parse(data['dateTime']),
      description: data['description'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
      'intensity': intensity,
      'radius': radius,
      'color': color.value.toRadixString(16),
      'city': city,
      'area': area,
      'crimeType': crimeType,
      'dateTime': dateTime.toIso8601String(),
      'description': description,
      'email': email
    };
  }
}
