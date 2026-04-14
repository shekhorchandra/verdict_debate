import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../explore_details/views/DebateDetailsPage.dart';

class DebateController extends GetxController {
  var currentIndex = 0.obs;
  var selectedTab = 0.obs;

  var cardOffset = Offset.zero.obs;
  var isAnimating = false.obs;

  final List<Map<String, dynamic>> debates = [
    {
      "user": "@zara_debates",
      "title": "Should remote work be the default?",
      "desc": "Remote work increases productivity...",
      "image": "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800",
      "disagree": 23,
      "agree": 77,
    },
    {
      "user": "@tech_insider",
      "title": "Will AI replace Junior Devs?",
      "desc": "As LLMs get better at coding...",
      "image": "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800",
      "disagree": 40,
      "agree": 60,
    },
  ];

  /// ================= CORE =================

  void resetCard() {
    cardOffset.value = Offset.zero;
  }

  void nextCard() {
    currentIndex.value = (currentIndex.value + 1) % debates.length;
    cardOffset.value = Offset.zero;
    isAnimating.value = false;
  }

  /// ================= SWIPE ACTIONS =================

  void swipeRight() async {
    if (isAnimating.value) return;
    isAnimating.value = true;

    cardOffset.value = const Offset(500, 0);
    await Future.delayed(const Duration(milliseconds: 180));

    _vote("AGREE");
  }

  void swipeLeft() async {
    if (isAnimating.value) return;
    isAnimating.value = true;

    cardOffset.value = const Offset(-500, 0);
    await Future.delayed(const Duration(milliseconds: 180));

    _vote("DISAGREE");
  }

  void swipeUp() async {
    if (isAnimating.value) return;
    isAnimating.value = true;

    cardOffset.value = const Offset(0, -500);
    await Future.delayed(const Duration(milliseconds: 180));

    nextCard();
  }

  void swipeDown() async {
    if (isAnimating.value) return;

    isAnimating.value = true;

    cardOffset.value = const Offset(0, 500);

    await Future.delayed(const Duration(milliseconds: 180));

    Get.toNamed(
      AppRoutes.EXPLORE_DETAILS,
      // transition: Transition.downToUp,
    );

    resetCard();
    isAnimating.value = false;
  }

  /// ================= TAP (NEW FEATURE) =================

  void openDetails() {
    Get.toNamed(
      AppRoutes.EXPLORE_DETAILS,
      // transition: Transition.downToUp,
    );
  }

  /// ================= VOTE =================

  void _vote(String type) {
    Get.snackbar(
      "Voted",
      type,
      snackPosition: SnackPosition.BOTTOM,
    );

    nextCard();
  }

  /// ================= TAB =================

  void changeTab(int index) {
    selectedTab.value = index;
  }
}