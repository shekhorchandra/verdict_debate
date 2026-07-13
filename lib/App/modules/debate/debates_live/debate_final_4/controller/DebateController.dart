import 'package:get/get.dart';

class DebateController extends GetxController {
  // Observables for live data
  var timerText = "10:41".obs;
  var viewerCount = "452".obs;
  var voteLeftPercent = 23.obs;
  var voteRightPercent = 77.obs;

  void onChallenge() => print("Challenge button clicked");
  void onSendGift() => print("Gift button clicked");
  void onBack() {
    Get.back();
  }
}