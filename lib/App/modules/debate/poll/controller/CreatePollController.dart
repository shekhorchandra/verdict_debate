import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollController extends GetxController {
  // 0 = Poll, 1 = Go Live
  var selectedTab = 0.obs;

  // --- Poll Specific State ---
  var currentPollIndicator = 0.obs; // For the dots below the grey card
  var selectedAddon = 2.obs; // Default to 'Background' (index 2)

  // --- Go Live Specific State ---
  var selectedPosition = "Support".obs; // Default position
  var selectedDuration = "15m".obs; // Default debate duration
  var argumentText = "".obs; // To track character count if needed

  final TextEditingController debateInputController = TextEditingController();

  // Change between Poll and Go Live tabs
  void changeTab(int index) {
    selectedTab.value = index;
  }

  // Update the Carousel indicator (dots)
  void updateIndicator(int index) {
    currentPollIndicator.value = index;
  }

  // Select Text, Media, or Background addon
  void selectAddon(int index) {
    selectedAddon.value = index;
  }

  // Set position (Against / Support)
  void setPosition(String pos) {
    selectedPosition.value = pos;
  }

  // Set duration (10m, 15m, etc.)
  void setDuration(String dur) {
    selectedDuration.value = dur;
  }

  @override
  void onClose() {
    debateInputController.dispose();
    super.onClose();
  }

  // Function to handle the final post/start logic
  void handleAction() {
    if (selectedTab.value == 0) {
      // Logic for posting a poll
      Get.snackbar("Success", "Poll posted successfully!");
    } else {
      // Logic for starting a live debate
      Get.snackbar("Debate", "Searching for opponent...");
    }
  }
}