// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CreatePollController extends GetxController {
//   // 0 = Poll, 1 = Go Live
//   var selectedTab = 0.obs;
//
//   // --- Poll Specific State ---
//   var currentPollIndicator = 0.obs; // For the dots below the grey card
//   var selectedAddon = 2.obs; // Default to 'Background' (index 2)
//
//   // --- Go Live Specific State ---
//   var selectedPosition = "Support".obs; // Default position
//   var selectedDuration = "15m".obs; // Default debate_final_4 duration
//   var argumentText = "".obs; // To track character count if needed
//
//   final TextEditingController debateInputController = TextEditingController();
//
//   // Change between Poll and Go Live tabs
//   void changeTab(int index) {
//     selectedTab.value = index;
//   }
//
//   // Update the Carousel indicator (dots)
//   void updateIndicator(int index) {
//     currentPollIndicator.value = index;
//   }
//
//   // Select Text, Media, or Background addon
//   void selectAddon(int index) {
//     selectedAddon.value = index;
//   }
//
//   // Set position (Against / Support)
//   void setPosition(String pos) {
//     selectedPosition.value = pos;
//   }
//
//   // Set duration (10m, 15m, etc.)
//   void setDuration(String dur) {
//     selectedDuration.value = dur;
//   }
//
//   @override
//   void onClose() {
//     debateInputController.dispose();
//     super.onClose();
//   }
//
//   // Function to handle the final post/start logic
//   void handleAction() {
//     if (selectedTab.value == 0) {
//       // Logic for posting a poll
//       Get.snackbar("Success", "Poll posted successfully!");
//     } else {
//       // Logic for starting a live debate_final_4
//       Get.snackbar("Debate", "Searching for opponent...");
//     }
//   }
// }

///////////////////////////////// for phase 1 //////////////////////////
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePollController extends GetxController {
  /// 0 = Text, 1 = Media, 2 = Background
  var selectedAddon = 2.obs;
  var selectedTab = 0.obs;
  var selectedDuration = "10m".obs;
  var currentPollIndicator = 0.obs;

  var pollText = "write your\npoll question".obs;

  Rx<File?> selectedMediaFile = Rx<File?>(null);

  /// Caption position inside preview
  var captionX = 24.0.obs;
  var captionY = 140.0.obs;

  /// image / video / empty
  var selectedMediaType = "".obs;

  final List<String> liveDurations = [
    "10m",
    "15m",
    "30m",
    "45m",
    "60m",
  ];

  final List<String> proDurations = [
    "30m",
    "45m",
    "60m",
    "75m"
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void selectDuration(String duration) {
    selectedDuration.value = duration;
  }

  void findOpponent() {
    debugPrint(
      "Finding opponent for ${selectedDuration.value}",
    );

    Get.snackbar(
      "Searching",
      "Looking for an opponent...",
      snackPosition: SnackPosition.BOTTOM,
    );
  }



  final TextEditingController pollTextController = TextEditingController();
  final PageController backgroundPageController = PageController();

  final ImagePicker imagePicker = ImagePicker();

  final List<Color> backgroundColors = const [
    Color(0xFF71717A),
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF14B8A6),
    Color(0xFFF59E0B),
    Color(0xFF780418),
    Color(0xFF25E91E),
    Color(0xFF070707),
    Color(0x8CAEAEF1),
    Color(0xFF0022FD),
  ];

  void selectAddon(int index) {
    selectedAddon.value = index;
  }

  void updateIndicator(int index) {
    currentPollIndicator.value = index;
  }

  void updatePollText(String value) {
    pollText.value = value.trim().isEmpty
        ? "write your\npoll question"
        : value.trim();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      selectedMediaFile.value = File(pickedFile.path);
      selectedMediaType.value = "image";
      selectedAddon.value = 1;
    } catch (e) {
      debugPrint("IMAGE PICK ERROR: $e");
      Get.snackbar(
        "Error",
        "Unable to pick image. Please restart the app and try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> pickVideoFromGallery() async {
    try {
      final XFile? pickedFile = await imagePicker.pickVideo(
        source: ImageSource.gallery,
      );

      if (pickedFile == null) return;

      selectedMediaFile.value = File(pickedFile.path);
      selectedMediaType.value = "video";
      selectedAddon.value = 1;
    } catch (e) {
      debugPrint("VIDEO PICK ERROR: $e");
      Get.snackbar(
        "Error",
        "Unable to pick video. Please restart the app and try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeMedia() {
    selectedMediaFile.value = null;
    selectedMediaType.value = "";
  }

  void handleAction() {
    final data = {
      "question": pollText.value,
      "backgroundColor":
      backgroundColors[currentPollIndicator.value].value.toRadixString(16),
      "selectedBackgroundIndex": currentPollIndicator.value,
      "mediaType": selectedMediaType.value,
      "mediaPath": selectedMediaFile.value?.path,
    };

    debugPrint("POST POLL DATA: $data");

    Get.snackbar(
      "Success",
      "Poll generated successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    pollTextController.dispose();
    backgroundPageController.dispose();
    super.onClose();
  }
}