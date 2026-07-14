import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/routes/app_routes.dart';

import '../views/ChallengeDialog.dart';

class ChallengeController extends GetxController {
  // Observables for dynamic data
  final timeRemaining = "10 Min".obs;
  final statement = "Climate change requires immediate action".obs;
  final viewerCount = "452".obs;

  void onChallengePressed() {
    Get.toNamed(AppRoutes.LIVECHALLENGE);
  }

  void showChallengePopup() {
    Get.dialog(
      const ChallengeDialog(),
      barrierColor: Colors.black.withOpacity(0.7), // Makes background dark
    );
  }

  void sendRequest() {
    // Add logic to send request
    Get.toNamed(AppRoutes.LIVECHALLENGE);
  }

  void onBack() {
    Get.back();
  }
}