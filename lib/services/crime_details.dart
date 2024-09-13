import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CrimeDetailsController extends GetxController {
  final LatLng initialLocation;
  final List<Map<String, dynamic>> initialCrimeDetails;

  CrimeDetailsController({
    required this.initialLocation,
    required this.initialCrimeDetails,
  });

  var crimeDetails = <Map<String, dynamic>>[].obs;
  RxInt currentIndex = 0.obs;
  RxBool hasMoreData = true.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  DocumentSnapshot? lastDocument;
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    crimeDetails.addAll(initialCrimeDetails);
    if (crimeDetails.isNotEmpty) {
      updateMapLocation();
    }
  }

  Future<void> fetchCrimeDetails() async {
    if (!hasMoreData.value) return;

    try {
      Query query = FirebaseFirestore.instance
          .collection('crime-spots')
          .orderBy('dateTime')
          .limit(10);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<Map<String, dynamic>> fetchedCrimes = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      if (fetchedCrimes.isEmpty) {
        hasMoreData.value = false;
      } else {
        crimeDetails.addAll(fetchedCrimes);
        lastDocument =
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
      }

      updateMapLocation();
    } catch (e) {
      print("Error fetching crime details: $e");
    }
  }

  void updateMapLocation() {
    if (mapController != null && crimeDetails.isNotEmpty) {
      final currentCrime = crimeDetails[currentIndex.value];
      final latitude = currentCrime['latitude'];
      final longitude = currentCrime['longitude'];

      LatLng location = (latitude != null && longitude != null)
          ? LatLng(latitude, longitude)
          : initialLocation;

      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(location, 15),
      );

      markers.value = {
        Marker(
          markerId: MarkerId('crimeLocation${currentIndex.value}'),
          position: location,
        ),
      };
    }
  }

  void onNextPressed() {
    if (currentIndex.value < crimeDetails.length - 1) {
      currentIndex.value++;
      updateMapLocation();
      update();
    } else if (hasMoreData.value) {
      fetchCrimeDetails();
    }
  }

  void onPreviousPressed() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      updateMapLocation();
      update();
      if (currentIndex.value < crimeDetails.length - 1 && !hasMoreData.value) {
        hasMoreData.value = true;
      }
    }
  }
}
