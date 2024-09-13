import 'package:crime_heat/screens/authentication/onboarding/onboarding_screen_four.dart';
import 'package:crime_heat/screens/authentication/onboarding/onboarding_screen_one.dart';
import 'package:crime_heat/screens/authentication/onboarding/onboarding_screen_three.dart';
import 'package:crime_heat/screens/authentication/onboarding/onboarding_screen_two.dart';
import 'package:flutter/material.dart';

class OnboardingScreenMain extends StatefulWidget {
  const OnboardingScreenMain({super.key});

  @override
  _OnboardingScreenMainState createState() => _OnboardingScreenMainState();
}

class _OnboardingScreenMainState extends State<OnboardingScreenMain> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        pageSnapping: true,
        children: [
          IntroScreen1(pageController: _pageController),
          IntroScreen2(pageController: _pageController),
          IntroScreen3(pageController: _pageController),
          IntroScreen4(pageController: _pageController),
        ],
      ),
      // Add any additional widgets like a bottom navigation or buttons if needed
    );
  }
}
