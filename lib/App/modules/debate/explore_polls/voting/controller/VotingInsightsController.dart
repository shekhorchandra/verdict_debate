import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotingData {
  final String location;
  final double agreePercentage;
  final double disagreePercentage;
  final int totalVotes;

  VotingData({
    required this.location,
    required this.agreePercentage,
    required this.disagreePercentage,
    required this.totalVotes,
  });
}

class VotingInsightsController extends GetxController {
  // Tabs: 0 for Agree, 1 for Disagree
  var selectedTab = 0.obs;

  // Combined data for all locations
  final List<VotingData> allVotingData = [
    VotingData(location: "London", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Jakarta", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Rome", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Dhaka", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Riyadh", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Paris", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
    VotingData(location: "Lisbon", agreePercentage: 0.60, disagreePercentage: 0.40, totalVotes: 24),
  ];

  // Getters for filtered data based on selected tab (though we'll use combined data)
  List<String> get agreeData => allVotingData.map((data) => data.location).toList();
  List<String> get disagreeData => allVotingData.map((data) => data.location).toList();

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void onBack() => Get.back();
}