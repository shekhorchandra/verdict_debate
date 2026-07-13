import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../views/LiveDebateChallengeDialog.dart';

class LiveDebateController extends GetxController {
  // Observables
  var timerValue = "10:41".obs;
  var viewerCount = "452".obs;
  var voteAPercent = 23.obs;
  var voteBPercent = 77.obs;
  var countA = 124.obs;
  var countB = 458.obs;

  void onChallengePressed() {
    print("Challenge button tapped");
  }

  void onGiftPressed() {
    print("Gift sent");
  }

  void onSendMessage(String message) {
    print("Message sent: $message");
  }

  void LiveDebateshowChallengePopup() {
    Get.dialog(
      const LiveDebateChallengeDialog(),
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }

  void sendRequest() {

    Get.toNamed(AppRoutes.FINALDEBATES);
  }

  void onBack() {
    Get.back();
  }
}