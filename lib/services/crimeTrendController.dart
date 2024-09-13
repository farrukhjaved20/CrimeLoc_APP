import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CrimeController extends GetxController {
  var crimeTypes = <String>[].obs; // Observable list of crime types
  var selectedMonth = ''.obs; // Observable for selected month
  var selectedCity = ''.obs; // Observable for selected city
  var cities = <String>[].obs; // Observable list of cities
  var crimeCountsByMonth =
      <String, List<int>>{}.obs; // Crime counts by month and crime type
  var allMonthCrimeCounts = <String, int>{}.obs; // Total counts by crime type

  final List<String> predefinedCrimeTypes = [
    'Mobile snatching',
    'Kidnapping',
    'Vehicle Theft',
    'Burglary'
  ]; // Define the four specific crime types

  @override
  void onInit() {
    super.onInit();
    fetchCrimeTypes(); // Fetch crime types when the controller initializes
    fetchCities(); // Fetch cities from Firestore
  }

  // Method to fetch crime types from Firestore
  void fetchCrimeTypes() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('crime-spots').get();

      if (snapshot.docs.isEmpty) {
        print('No crime types found in Firestore.');
        return;
      }

      var fetchedTypes = snapshot.docs
          .map((doc) => doc['crimeType'] as String)
          .where((type) => predefinedCrimeTypes
              .contains(type)) // Filter to include only the 4 crime types
          .toSet()
          .toList();

      crimeTypes.value = fetchedTypes;

      for (var type in crimeTypes) {
        crimeCountsByMonth[type] = List<int>.generate(
            12, (index) => 0); // Ensure list is of type List<int>
        allMonthCrimeCounts[type] = 0; // Initialize total count
      }

      // Initialize crime counting
      countCrimeOccurrences();
      fetchAllCrimeData();
    } catch (e) {
      print('Error fetching crime types: $e');
    }
  }

  // Method to fetch available cities from Firestore
  void fetchCities() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore.collection('crime-spots').get();

      if (snapshot.docs.isEmpty) {
        print('No city data found in Firestore.');
        return;
      }

      // Map the docs to cities, filter out null values, and cast to List<String>
      var fetchedCities = snapshot.docs
          .map((doc) => doc['city'] as String?)
          .where((city) => city != null && city.isNotEmpty)
          .map((city) => city!) // Explicitly cast non-nullable String
          .toSet()
          .toList();

      if (fetchedCities.isEmpty) {
        print('No valid cities found.');
        return;
      }

      cities.value = fetchedCities; // Store unique cities
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  // Method to count crime occurrences by month, filtered by selected city
  void countCrimeOccurrences() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final snapshot = await firestore.collection('crime-spots').get();

      final monthCounts = <String, List<int>>{};

      for (var doc in snapshot.docs) {
        final crimeType = doc['crimeType'] as String;
        final city = doc['city'] as String;

        // Skip if crimeType is not predefined or if a city is selected and does not match
        if (!predefinedCrimeTypes.contains(crimeType) ||
            (selectedCity.value.isNotEmpty && city != selectedCity.value)) {
          continue;
        }

        final dateString = doc['dateTime'] as String;
        final date = DateTime.parse(dateString);
        final monthIndex = date.month - 1;

        if (!monthCounts.containsKey(crimeType)) {
          monthCounts[crimeType] = List<int>.generate(12, (index) => 0);
        }

        monthCounts[crimeType]![monthIndex]++;
      }

      crimeCountsByMonth.assignAll(monthCounts);
    } catch (e) {
      print('Error counting crime occurrences: $e');
    }
  }

// Method to fetch all crime data based on selected city
  void fetchAllCrimeData() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final snapshot = await firestore.collection('crime-spots').get();

      final totalCounts = <String, int>{};

      for (var doc in snapshot.docs) {
        final crimeType = doc['crimeType'] as String;
        final city = doc['city'] as String;

        // Skip if crimeType is not predefined or if a city is selected and does not match
        if (!predefinedCrimeTypes.contains(crimeType) ||
            (selectedCity.value.isNotEmpty && city != selectedCity.value)) {
          continue;
        }

        if (!totalCounts.containsKey(crimeType)) {
          totalCounts[crimeType] = 0;
        }

        totalCounts[crimeType] = (totalCounts[crimeType] ?? 0) + 1;
      }

      allMonthCrimeCounts.assignAll(totalCounts);
    } catch (e) {
      print('Error fetching all crime data: $e');
    }
  }
}
