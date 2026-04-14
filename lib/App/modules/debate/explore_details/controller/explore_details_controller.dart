import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebateDetailController extends GetxController {
  // UI State
  var isFollowing = false.obs;
  var isDescriptionExpanded = false.obs;

  // Voting data (mock)
  var disagreePercent = 23.obs;
  var agreePercent = 77.obs;

  // Text Controller for comment input
  final TextEditingController commentController = TextEditingController();

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  void toggleDescription() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
  }

  void onVote(bool isAgree) {
    if (isAgree) {
      agreePercent.value++;
      disagreePercent.value--;
    } else {
      disagreePercent.value++;
      agreePercent.value--;
    }
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
