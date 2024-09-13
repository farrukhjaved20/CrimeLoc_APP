import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_heat/widgets/app_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crime_heat/constant/constant.dart';
import 'package:get/get.dart'; // Import Get package for AppButton

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  bool _showLoader = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReport() async {
    if (_emailController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _image == null) {
      // Handle validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and pick an image')),
      );
      return;
    }

    setState(() {
      _showLoader = true;
    });

    try {
      // Upload image
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('reports/${DateTime.now().toIso8601String()}.jpg');
      await storageRef.putFile(_image!);
      final imageUrl = await storageRef.getDownloadURL();

      // Add report to Firestore
      await FirebaseFirestore.instance.collection('reports').add({
        'email': _emailController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Show success message and reset form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully!')),
      );
      _emailController.clear();
      _descriptionController.clear();
      setState(() {
        _image = null;
        _showLoader = false;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit report: $e')),
      );
      setState(() {
        _showLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        title: const Text('Submit Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
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
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
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
                hintText: 'Enter description',
                labelText: 'Description',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            if (_image != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Selected Image:',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Image.file(
                      _image!,
                      height: 100, // Adjust height as needed
                      width: 100, // Adjust width as needed
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            AppButton(
              text: 'Pick Image',
              showLoader: false,
              onPressed: _pickImage,
            ),
            const SizedBox(height: 16.0),
            AppButton(
              text: 'Submit Report',
              showLoader: _showLoader,
              onPressed: () {
                _submitReport().then(
                  (value) => Get.back(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
