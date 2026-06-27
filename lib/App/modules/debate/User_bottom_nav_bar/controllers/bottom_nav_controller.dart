// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../arena_debate/views/ArenaView.dart';
// import '../../debates_live/live/views/DebatesView.dart';
// import '../../explore_polls/explore/views/ExploreView.dart';
// import '../../profile/user_profile/views/ProfileView.dart';
//
// class UserNavigationBarController extends GetxController {
//   final Rx<int> selectedIndex = 0.obs;
//
//   Rx<Widget?> currentOverlayPage = Rx<Widget?>(null);
//
//   void openOverlayPage(Widget page) {
//     currentOverlayPage.value = page;
//   }
//
//   void closeOverlayPage() {
//     currentOverlayPage.value = null;
//   }
//
//   final screens = [
//     const ExploreView(),
//     const DebatesView(),
//     const ArenaView(),
//     const ProfileView(),
//   ];
//
//   void changeTab(int index) {
//     selectedIndex.value = index;
//     closeOverlayPage();
//   }
// }


///////////////////////// for phase 1 ///////////////////////////////
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/user_profile/views/ProfileView.dart';

class UserNavigationBarController extends GetxController {
  /// First phase bottom nav default screen
  /// 0 = Profile
  final RxInt selectedIndex = 0.obs;

  /// Optional overlay page support
  final Rx<Widget?> currentOverlayPage = Rx<Widget?>(null);

  void openOverlayPage(Widget page) {
    currentOverlayPage.value = page;
  }

  void closeOverlayPage() {
    currentOverlayPage.value = null;
  }

  /// First phase: only Profile screen
  final List<Widget> screens = const [
    ProfileView(),
  ];

  void changeTab(int index) {
    if (index < 0 || index >= screens.length) return;

    selectedIndex.value = index;
    closeOverlayPage();
  }
}
