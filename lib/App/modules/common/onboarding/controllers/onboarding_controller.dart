import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  var isLoading = false.obs;

  final pages = [
    {
      "title": "Your Voice Matters",
      "subtitle": "Share your opinion on trending topics and see what people around the world think instantly.",
      "image": "assets/images/Onboarding1.png", // Replace with your image path
    },
    {
      "title": "Debate in Real Time",
      "subtitle": "Join live audio debates, challenge others, and let your arguments be heard.",
      "image": "assets/images/Onboarding2.png",
    },
    {
      "title": "Build Your Influence",
      "subtitle": "Gain followers, win debates, and receive support from your audience.",
      "image": "assets/images/Onboarding3.png",
    },
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate when "Get Started" clicked
      Get.offAllNamed(AppRoutes.AUTH);
    }
  }

  void skip() {
    Get.offAllNamed(AppRoutes.AUTH);
  }

  void onPageChanged(int index) => currentPage.value = index;
}
