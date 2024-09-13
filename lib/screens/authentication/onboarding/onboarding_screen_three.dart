import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:crime_heat/constant/size_configs.dart';
import 'package:crime_heat/services/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen3 extends StatefulWidget {
  final PageController pageController;

  const IntroScreen3({required this.pageController, super.key});

  @override
  State<IntroScreen3> createState() => _IntroScreen3State();
}

class _IntroScreen3State extends State<IntroScreen3>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _buttonSizeAnimation;
  late final Animation<double> _buttonPositionAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward(); // Start the animation when the widget is built

    _buttonSizeAnimation = Tween<double>(
      begin: 0.0, // Start size of the button
      end: SizeConfig.screenHeight * 0.06, // End size of the button
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _buttonPositionAnimation = Tween<double>(
      begin:
          SizeConfig.screenHeight * 0.2, // Start position off-screen or lower
      end: SizeConfig.screenHeight *
          0.1, // End position slightly above the bottom
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 110),
            child: Center(
              child: Image.asset(
                'assets/images/2.png',
                height: SizeConfig.screenHeight * 0.35,
              ),
            ),
          ),
          Positioned(
            top: 390,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quick Crime Reporting',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: const Text(
                      'Report a crime in just a few taps. Help others stay safe by marking the exact location where a crime occurred.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: _buttonPositionAnimation
                    .value, // Animate the button position
                left: SizeConfig.screenWidth * 0.07,
                right: SizeConfig.screenWidth * 0.07,
                child: SizedBox(
                  height: _buttonSizeAnimation.value,
                  width: _buttonSizeAnimation.value *
                      1.5, // Aspect ratio of the button
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () async {
                        Get.find<AuthenticationController>()
                            .toggleIsLoading(true);
                        await Future.delayed(
                            const Duration(milliseconds: 800)); // Short delay
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );

                        Get.find<AuthenticationController>()
                            .toggleIsLoading(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kappRedColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        padding: EdgeInsets.zero, // Remove default padding
                      ),
                      child: Center(
                        child: Get.find<AuthenticationController>()
                                .isLoading
                                .value
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: StyleText.getRegularStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: SizeConfig.screenHeight * 0.024,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
