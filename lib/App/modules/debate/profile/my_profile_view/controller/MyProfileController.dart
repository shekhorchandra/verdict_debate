import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../routes/app_routes.dart';

class MyProfileController extends GetxController {
  // Current active tab (0: Polls, 1: Debates, 2: Reposts)
  var selectedTab = 0.obs;

  // Mock User Data
  var username = "Tonoy_Saha".obs;
  var followers = "3455".obs;
  var debatesWon = "134".obs;
  var pollsCount = "86".obs;

  // 1. Mock Data for Polls Tab
  final List<Map<String, dynamic>> myPolls = [
    {
      "votes": "3,420",
      "likes": "1655",
      "comments": "32",
      "title": "Should remote work be the default for tech companies?",
      "desc": "Remote work increases productivity and work-life balance...",
      "image": "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800",
      "time": "Ends 1 week ago",
    }
  ];

  // 2. Mock Data for Debates Tab (Arena Cards)
  final List<Map<String, dynamic>> myDebates = [
    {
      "views": "125.7k",
      "time": "30 min",
      "topic": "Climate change requires immediate action",
      "isWinner": true,
      "p1": "jamie_vardy",
      "p2": "emily_watson11",
      "votes1": 39,
      "votes2": 61,
    },
    {
      "views": "88k",
      "time": "15 min",
      "topic": "Is AI art real art?",
      "isWinner": false,
      "p1": "jamie_vardy",
      "p2": "art_critic_99",
      "votes1": 45,
      "votes2": 55,
    }
  ];

  // 3. Mock Data for Reposts Tab
  final List<Map<String, dynamic>> myReposts = [
    {
      "repostedBy": "Tonoy_Saha",
      "repostTime": "1 day ago",
      "originalUser": "@zara_debates",
      "originalTime": "Ends 1 week ago",
      "title": "Should remote work be the default for tech companies?",
      "image": "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800",
      "userComment": "Remote work increases productivity and work-life balance...",
    }
  ];

  /// Changes the active tab index
  void changeTab(int index) {
    selectedTab.value = index;
  }

  /// Navigation to Edit Profile
  void editProfile() {
    // Navigate to the edit profile page
    Get.toNamed(AppRoutes.EDIT_PROFILE);
  }

  /// Navigation for "View All" button
  void viewAllItems() {
    String type = selectedTab.value == 0 ? "Polls" : "Debates";
    print("Viewing all $type");
  }

  /// Action for Watch Debate button
  void watchDebate(int index) {
    Get.snackbar("Arena", "Opening Debate Stream...");
  }
}