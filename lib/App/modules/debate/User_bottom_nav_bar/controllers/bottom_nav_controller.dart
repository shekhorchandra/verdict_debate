import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../arena/views/ArenaView.dart';

import '../../debates_client/live/views/DebatesView.dart';
import '../../explore_debate/explore/views/DebateView.dart';
import '../../profile/views/ProfileView.dart';





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
    const DebateView(),
    const DebatesView(),
    const ArenaView(),
    const ProfileView(),
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
    closeOverlayPage();
  }
}
