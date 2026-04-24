import 'package:get/get.dart';

class PremiumPlansController extends GetxController {
  // Logic to handle plan selection
  void selectPlan(String planName) {
    Get.snackbar("Subscription", "Redirecting to $planName payment gateway...");
  }
}