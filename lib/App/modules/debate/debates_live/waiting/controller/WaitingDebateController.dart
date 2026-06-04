import 'package:get/get.dart';

class WaitingDebateController extends GetxController {
  // 0: All, 1: Live Now, 2: Waiting
  var selectedTab = 2.obs;

  void changeTab(int index) {
    selectedTab.value = index;
    // Navigation logic based on tab can go here
  }

  void onChallengePressed() {
    // Logic for challenging the debate
    print("Challenge initiated");
  }
}