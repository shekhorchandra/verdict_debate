import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../liveDebate_own/views/ChallengesDialog.dart';

class WaitingController extends GetxController {
  var timerValue = "10 Sec".obs;
  var topic = "Climate change requires immediate action".obs;
  var username = "@ronan_debates".obs;

  var secondsRemaining = 10.obs;
  Timer? _timer;

  // 1. Add the challengers list here
  final challengers = [
    {"name": "@james_jones", "img": "https://i.pravatar.cc/150?u=1"},
    {"name": "@james_jones", "img": "https://i.pravatar.cc/150?u=2"},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  // 2. Timer Logic
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
        showChallengesPopup(); // Now triggers after 1 minute
      }
    });
  }

  String get formattedTime {
    int minutes = secondsRemaining.value ~/ 60;
    int seconds = secondsRemaining.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void showChallengesPopup() {
    Get.dialog(const ChallengesDialog());
  }

  void acceptChallenge() {
    Get.back(); // Close dialog
    Get.toNamed(AppRoutes.LIVEOWN_DEBATE); // Navigate to the next page
  }

  void rejectChallenge(int index) {
    challengers.removeAt(index);
    if (challengers.isEmpty) Get.back();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Important: cancel timer when page is closed
    super.onClose();
  }

  void onBack() {
    Get.back();
  }


}