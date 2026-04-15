import 'package:get/get.dart';

class VotingInsightsController extends GetxController {
  // 0 for Agree, 1 for Disagree
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  // Mock data for the lists
  final agreeData = [
    "London", "Jakarta", "Rome", "Dhaka", "Riyadh", "Paris", "Lisbon"
  ];

  final disagreeData = [
    "Dubai", "Feni", "Delhi", "Lisbon", "London", "New York", "Al-ajman"
  ];
}