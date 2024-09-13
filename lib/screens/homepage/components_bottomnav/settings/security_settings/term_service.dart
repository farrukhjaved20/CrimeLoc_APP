import 'package:crime_heat/constant/constant.dart';
import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kappBlueColor,
        title: const Text(
          'Terms of Service',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to the CrimeLoc App. By using our app, you agree to these terms of service. Please read them carefully.',
              ),
              SizedBox(height: 20),
              Text(
                'User Responsibilities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Users are expected to use the app responsibly and report crime locations accurately. Any misuse of the app may result in termination of access.',
              ),
              SizedBox(height: 20),
              Text(
                'Limitations of Liability',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We are not responsible for any damages or losses resulting from the use of the app. Use the app at your own risk.',
              ),
              SizedBox(height: 20),
              Text(
                'Changes to Terms',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may update these terms from time to time. Continued use of the app signifies your acceptance of the updated terms.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
