import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/controllers.dart';
import 'package:crime_heat/model/users/user_model.dart';
import 'package:crime_heat/screens/authentication/onboarding/onboarding_screen.dart';
import 'package:crime_heat/screens/authentication/sigin.dart';
import 'package:crime_heat/screens/homepage/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    getData();
  }

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel().obs;

  getData() async {
    try {
      // Get the current user's email
      final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
      print('Current user email: $currentUserEmail');

      // Fetch user data from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserEmail)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        user.value = UserModel.fromMap(data);
        if (kDebugMode) {
          print(
              'User data: ${user.value.name}, ${user.value.email}, ${user.value.profileUrl}');
        }
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      // Log or handle errors appropriately
      print('Error fetching user data: $e');
    }
  }

  updateImageProfile(String profileUrl) {
    user.update((user) {
      user?.profileUrl = profileUrl;
    });
  }

  updateUserName(String nametext) async {
    try {
      toggleIsLoading(true);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({'name': nametext}).then(
        (value) {
          Get.back();
        },
      );

      toggleIsLoading(false);
      await updateNamee(nametext);

      update();
      Get.snackbar(
        'Success',
        'Name updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.kappBlueColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error updating user profile: $e');
      // Optionally: Handle errors (e.g., show a snackbar or alert)
      toggleIsLoading(false);
    }
  }

  updateNamee(String nametext) {
    user.update((user) {
      user?.name = nametext;
    });
    update();
  }

  toggleIsLoading(bool val) {
    isLoading.value = val;
    update();
  }

  signUp(String name, String email, String password) async {
    try {
      toggleIsLoading(true);
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      await usersCollection
          .collection('users')
          .doc(authentication.currentUser?.email)
          .set({
        'email': email,
        'name': name,
      }).then(
        (value) {
          Get.offAll(() => const MyHomePage());
          Get.snackbar('Success', 'Welcome To Home Screen',
              backgroundColor: AppColors.kappBlueColor,
              colorText: Colors.white);
        },
      );
      myControllers.clear();
      toggleIsLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      toggleIsLoading(false);
    }
  }

  ///SignIn
  void signIn(String email, String password) async {
    try {
      toggleIsLoading(true);
      await authentication
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          Get.offAll(() => const MyHomePage());
          Get.snackbar('Success', 'Welcome Back !!',
              backgroundColor: AppColors.kappBlueColor,
              colorText: Colors.white);
        },
      );
      myControllers.clear();
      toggleIsLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      toggleIsLoading(false);
    }
  }

  ///SignOut
  void signOut() async {
    try {
      await authentication.signOut().then(
        (value) {
          Get.offAll(() => const SignInPage());
          Get.snackbar('Success', 'SignedOut !!',
              backgroundColor: AppColors.kappBlueColor,
              colorText: Colors.white);
        },
      );
      myControllers.clear();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  ///isLogin

  Future<void> isLoginUser() async {
    Future.delayed(const Duration(seconds: 8), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
            () => const MyHomePage());
      } else {
        Get.offAll(
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 500),
            () => const OnboardingScreenMain());
      }
    });
  }

  // Method to update email
  Future<void> updateEmail(String newEmail, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        toggleIsLoading(true); // Start loading

        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        // Update the email
        await user.verifyBeforeUpdateEmail(newEmail);

        // Reload user to apply changes
        await user.reload();
        user = FirebaseAuth.instance.currentUser; // Refresh the current user

        // Optionally send a verification email
        await user?.sendEmailVerification();
        update();
        // Show success message
        Get.snackbar('Success', 'Email updated successfully');

        // Navigate back or update UI accordingly
        Get.back();
      }
    } catch (e) {
      // Show error message if something goes wrong
      Get.snackbar('Error', e.toString());
      print(e.toString());
    } finally {
      // Stop loading
      toggleIsLoading(false);
    }
  }

  deleteAccount() async {
    try {
      toggleIsLoading(true); // Start loading

      User? user = FirebaseAuth.instance.currentUser;

      await user!.delete();

      Get.snackbar('Success', 'Account deleted successfully',
          backgroundColor: AppColors.kappBlueColor, colorText: Colors.white);

      toggleIsLoading(false); // Start loading
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      toggleIsLoading(false); // Start loading
    }
  }

  final picker = ImagePicker();
  RxDouble uploadProgress = 0.0.obs;
  RxString imageUrl = ''.obs;
  RxBool isUploading = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    isUploading(true); // Set uploading to true
    final file = File(pickedFile.path);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().toString()}');
      final uploadTask = storageRef.putFile(file);

      uploadTask.snapshotEvents.listen((event) {
        uploadProgress((event.bytesTransferred / event.totalBytes) * 100);
      });

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrl(downloadUrl);
      Get.find<AuthenticationController>().updateImageProfile(downloadUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'profileUrl': downloadUrl,
      });

      Get.find<AuthenticationController>().updateImageProfile(downloadUrl);

      // Reset progress
      uploadProgress(0.0);
      isUploading(false); // Set uploading to false

      // Show success snackbar using GetX
      Get.snackbar(
        'Success',
        'Image uploaded successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.kappBlueColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      uploadProgress(0.0); // Reset progress
      isUploading(false); // Set uploading to false

      print('Error uploading image: $e');

      // Show error snackbar using GetX
      Get.snackbar(
        'Error',
        'Error uploading image!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future changePassword(String text) async {
    try {
      toggleIsLoading(true);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: text)
          .then((value) => Get.back());
      toggleIsLoading(false);
      myControllers.emailcontroller.clear();
      Get.snackbar(
        'Successfully Link Send',
        'Check your Email',
        backgroundColor: AppColors.kappBlueColor,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed To send Password Link',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      toggleIsLoading(false);
    }
  }
}
