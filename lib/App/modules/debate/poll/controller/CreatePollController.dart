import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollController extends GetxController {
  var selectedTab = 0.obs; // 0 for Poll, 1 for Go Live
  var argumentText = "".obs;
  var selectedPosition = "".obs;
  var selectedDuration = "10m".obs; // Default duration

  List<String> get tips {
    if (selectedTab.value == 0) {
      return [
        "Ask clear, thought-provoking questions",
        "Present a balanced argument",
        "Use media to support your point",
        "Keep it respectful and engaging",
      ];
    } else {
      return [
        "Choose a clear, debatable topic",
        "Be respectful to your opponent",
        "Present strong arguments",
        "Engage with your audience",
      ];
    }
  }

  final TextEditingController textController = TextEditingController();

  final List<String> durations = ["10m", "15m", "30m", "45m", "60m", "75m"];
  final List<String> proDurations = ["30m", "45m", "60m", "75m"];

  void updateText(String val) => argumentText.value = val;
  void selectPosition(String pos) => selectedPosition.value = pos;
  void selectDuration(String dur) => selectedDuration.value = dur;
  void changeTab(int index) {
    selectedTab.value = index;
    textController.clear();
    argumentText.value = "";
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}