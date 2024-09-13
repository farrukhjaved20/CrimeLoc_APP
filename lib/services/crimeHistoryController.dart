import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrimeHistoryController extends GetxController {
  var crimeReports = <CrimeReport>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch crime reports based on the user's email
  void fetchCrimeReports(String email) async {
    try {
      final snapshot = await firestore
          .collection('crime-spots')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        print('No crime reports found.');
        return;
      }

      crimeReports.value = snapshot.docs
          .map((doc) => CrimeReport.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching crime reports: $e');
    }
  }
}

class CrimeReport {
  CrimeReport({
    required this.area,
    required this.city,
    required this.color,
    required this.crimeType,
    required this.dateTime,
    required this.description,
    required this.email,
  });

  final String area;
  final String city;
  final String color;
  final String crimeType;
  final String dateTime;
  final String description;
  final String email;

  factory CrimeReport.fromFirestore(Map<String, dynamic> data) {
    return CrimeReport(
      area: data['area'] ?? '',
      city: data['city'] ?? '',
      color: data['color'] ?? '',
      crimeType: data['crimeType'] ?? '',
      dateTime: data['dateTime'] ?? '',
      description: data['description'] ?? '',
      email: data['email'] ?? '',
    );
  }
}
