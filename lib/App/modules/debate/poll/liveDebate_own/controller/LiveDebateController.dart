import 'dart:async';
import 'package:flutter/material.dart'; // Added for Colors
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../views/ChallengesDialog.dart';

class LiveDebateOwnController extends GetxController {
  // --- ADDED THIS VARIABLE HERE ---
  final challengers = [
    {"name": "@james_jones", "img": "https://i.pravatar.cc/150?u=1"},
    {"name": "@james_jones", "img": "https://i.pravatar.cc/150?u=2"},
    {"name": "@james_jones", "img": "https://i.pravatar.cc/150?u=3"},
  ].obs;
  // --------------------------------

  // Observables for live data
  var timerText = "10:41".obs;
  var viewerCount = "452".obs;
  var voteLeftPercent = 23.obs;
  var voteRightPercent = 77.obs;
  var challengeNotifications = 2.obs;

  // Timer Logic
  var secondsRemaining = 600.obs; // 10 minutes
  Timer? _timer;

  final messages = [
    {"user": "viewer_327", "msg": "Disagree!", "color": "white"},
    {"user": "viewer_520", "msg": "Sends a Microphone", "color": "yellow"},
    {"user": "viewer_350", "msg": "Team A!", "color": "white"},
    {"user": "viewer_538", "msg": "Team B!", "color": "white"},
    {"user": "viewer_54", "msg": "Great point!", "color": "white"},
  ].obs;

  void onExit() => Get.back();
  void onToggleMic() => print("Mic toggled");

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        _timer?.cancel();
        showChallengesPopup();
      }
    });
  }

  void showChallengesPopup() {
    Get.dialog(
      const ChallengesDialog(),
      barrierDismissible: false,
    );
  }

  void acceptChallenge() {
    Get.back(); // Close dialog
    Get.toNamed(AppRoutes.LIVEOWN_DEBATE);
  }

  void rejectChallenge(int index) {
    challengers.removeAt(index);
    if (challengers.isEmpty) {
      Get.back(); // Close dialog if no more challengers left
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}