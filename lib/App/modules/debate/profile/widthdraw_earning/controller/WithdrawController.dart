import 'package:get/get.dart';

class WithdrawController extends GetxController {
  var availableFunds = "154".obs;
  var withdrawAmount = "24".obs;

  // Data for gift values
  final List<Map<String, String>> giftValues = [
    {"icon": "🎤", "value": "\$1"},
    {"icon": "📢", "value": "\$5"},
    {"icon": "🥊", "value": "\$10"},
    {"icon": "👑", "value": "\$25"},
    {"icon": "⚡", "value": "\$50"},
    {"icon": "🐂", "value": "\$100"},
  ];

  void onConvert() {
    Get.snackbar("Conversion", "Gifts successfully converted to funds.");
  }

  void onWithdraw() {
    Get.snackbar("Withdrawal", "Withdrawal request submitted successfully.");
  }
}