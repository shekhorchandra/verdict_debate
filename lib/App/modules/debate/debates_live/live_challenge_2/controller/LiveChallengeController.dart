import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../views/LiveChallengeDialog.dart';
import '../views/LiveChallengeView.dart';

class GiftModel {
  final String name;
  final String icon;
  final String count;
  GiftModel({required this.name, required this.icon, required this.count});
}

class LiveChallengeController extends GetxController {
  // Mock data for the UI
  var topVotes = 124.obs;
  var bottomVotes = 458.obs;
  var timerText = "10:41".obs;
  var viewerCount = 452.obs;

  // Progress bar calculation
  double get votePercentage => 0.23; // 23% vs 77%

  var selectedGiftIndex = 0.obs;

  final List<GiftModel> gifts = [
    GiftModel(name: "Microphone", icon: "🎤", count: "3x"),
    GiftModel(name: "Megaphone", icon: "📢", count: "0x"),
    GiftModel(name: "Boxing Glove", icon: "🥊", count: "2x"),
    GiftModel(name: "Crown", icon: "👑", count: "0x"),
    GiftModel(name: "Lightning Bolt", icon: "⚡", count: "1x"),
    GiftModel(name: "Big Muscular Cow", icon: "🐂", count: "0x"),
  ];

  void selectGift(int index) => selectedGiftIndex.value = index;

  void showGiftBottomSheet() {
    Get.bottomSheet(
      const GiftBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }

  // Chat messages list
  final RxList<Map<String, String>> messages =
      <Map<String, String>>[
        {
          "user": "viewer_327",
          "msg": "Disagree!",
          "color": "white"
        },
        {
          "user": "viewer_520",
          "msg": "Sends a Microphone",
          "color": "yellow"
        },
      ].obs;

  void sendGift() => print("Gift sent!");

  void LiveshowChallengePopup() {
    Get.dialog(
      const LiveChallengeDialog(),
      barrierColor: Colors.black.withOpacity(0.7),
    );
  }

  void sendRequest() {

    Get.toNamed(AppRoutes.LIVEDEBATE);
  }
  void onBack() {
    Get.back();
  }
}

