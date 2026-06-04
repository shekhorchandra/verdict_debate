import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../arena_debate/views/ArenaView.dart';
import '../../debates_live/live/views/DebatesView.dart';
import '../../explore_polls/explore/views/ExploreView.dart';
import '../../profile/user_profile/views/ProfileView.dart';

class UserNavigationBarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  Rx<Widget?> currentOverlayPage = Rx<Widget?>(null);

  void openOverlayPage(Widget page) {
    currentOverlayPage.value = page;
  }

  void closeOverlayPage() {
    currentOverlayPage.value = null;
  }

  final screens = [
    const ExploreView(),
    const DebatesView(),
    const ArenaView(),
    const ProfileView(),
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
    closeOverlayPage();
  }
}
