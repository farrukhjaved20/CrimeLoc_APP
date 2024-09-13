import 'package:crime_heat/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:crime_heat/widgets/app_button.dart'; // Import AppButton

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Toggle loading state
  void toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  // Method to change the password
  Future<void> _changePassword() async {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New password and confirm password do not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      toggleLoading(true); // Start loading

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && currentPassword.isNotEmpty) {
        // Re-authenticate the user with the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // If re-authentication is successful, update the password
        await user.updatePassword(newPassword);

        Get.snackbar('Success', 'Password updated successfully',
            backgroundColor: Colors.green, colorText: Colors.white);

        // Optionally, navigate back or clear fields
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      toggleLoading(false); // Stop loading
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        title: const Text(
          'Change Your Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _currentPasswordController,
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
                hintText: 'Enter your current password',
                labelText: 'Current Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _newPasswordController,
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
                hintText: 'Enter your new password',
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPasswordController,
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
                hintText: 'Confirm your new password',
                labelText: 'Confirm Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            AppButton(
              text: 'Save',
              showLoader: isLoading,
              onPressed: _changePassword,
            ),
          ],
        ),
      ),
    );
  }
}
