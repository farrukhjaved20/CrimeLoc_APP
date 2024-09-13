import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/widgets/app_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareFeedbackPage extends StatefulWidget {
  const ShareFeedbackPage({super.key});

  @override
  _ShareFeedbackPageState createState() => _ShareFeedbackPageState();
}

class _ShareFeedbackPageState extends State<ShareFeedbackPage> {
  final _feedbackController = TextEditingController();
  int _rating = 0;
  bool _isLoading = false; // Add this variable

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // Method to save feedback to Firebase
  Future<void> _sendFeedback() async {
    String feedback = _feedbackController.text.trim();

    if (feedback.isEmpty || _rating == 0) {
      Get.snackbar('Error', 'Please provide feedback and rating',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    setState(() {
      _isLoading = true; // Start loader
    });

    try {
      // Reference to Firestore
      CollectionReference feedbackCollection =
          FirebaseFirestore.instance.collection('feedback');

      // Add feedback to Firestore
      await feedbackCollection.add({
        'rating': _rating,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) => Get.back());

      Get.snackbar('Success', 'Feedback sent successfully',
          backgroundColor: Colors.green, colorText: Colors.white);

      // Clear fields
      _feedbackController.clear();
      setState(() {
        _rating = 0;
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      setState(() {
        _isLoading = false; // Stop loader
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        title: const Text(
          'Share your feedback',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is your opinion of CrimeLoc App?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: _rating > index ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
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
                hintText: 'Please leave your feedback here...',
                labelText: 'FeedBack',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            Center(
                child: AppButton(
              text: 'Submit Report',
              showLoader: _isLoading,
              onPressed: () {
                _sendFeedback();
              },
            )),
          ],
        ),
      ),
    );
  }
}
