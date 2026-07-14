import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/TimeExtensionDialog.dart';

class LiveStreamController extends GetxController {
  // Observables
  var timerText = "10:41".obs;
  var followerCount = "33k".obs;
  var isFollowing = false.obs;
  var selectedPlan = 0.obs; // 0: 5min, 1: 10min, 2: 15min
  var dialogTimer = "00:59s".obs;
  var totalSeconds = 600.obs;
  Timer? _streamTimer;

  @override
  void onInit() {
    super.onInit();
    startStreamTimer();
  }

  void startStreamTimer() {
    _streamTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalSeconds.value > 0) {
        totalSeconds.value--;

        // 2. TRIGGER LOGIC: Show popup when exactly 59 seconds are left
        if (totalSeconds.value == 59) {
          showExtensionDialog();
        }
      } else {
        _streamTimer?.cancel();
        // Logic for when time actually runs out (e.g., close stream)
      }
    });
  }

  // Formatter for the main screen timer (shows 09:59)
  String get formattedTime {
    int minutes = totalSeconds.value ~/ 60;
    int seconds = totalSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // This is the same dialog function from the previous step
  void showExtensionDialog() {
    // Check if dialog is already open to prevent multiple popups
    if (!Get.isDialogOpen!) {
      Get.dialog(
        const TimeExtensionDialog(),
        barrierDismissible: false,
      );
    }
  }

  @override
  void onClose() {
    _streamTimer?.cancel(); // Always cancel timers to prevent memory leaks
    super.onClose();
  }

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  void onExit() {
    Get.back();
  }

  // Placeholder functions for controls
  void toggleCamera() => print("Camera Toggled");
  void toggleVolume() => print("Volume Toggled");
  void toggleMic() => print("Mic Toggled");


  void onConfirmExtension() {
    // Logic to deduct gems and add time
    Get.back();
    Get.snackbar("Success", "Debate time extended!",
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}