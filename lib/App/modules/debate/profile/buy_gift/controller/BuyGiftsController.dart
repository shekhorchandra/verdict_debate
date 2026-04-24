import 'package:get/get.dart';

class BuyGiftsController extends GetxController {
  var selectedIndex = (-1).obs;

  // NEW: Quantity state
  var quantity = 1.obs;

  final List<Map<String, dynamic>> gifts = [
    {"name": "Microphone", "price": "1", "icon": "🎤"},
    {"name": "Megaphone", "price": "5", "icon": "📢"},
    {"name": "Boxing Glove", "price": "10", "icon": "🥊"},
    {"name": "Crown", "price": "25", "icon": "👑"},
    {"name": "Lightning Bolt", "price": "50", "icon": "⚡"},
    {"name": "Big Muscular Cow", "price": "100", "icon": "🐂"},
  ];

  void selectGift(int index) {
    selectedIndex.value = index;
    quantity.value = 1; // Reset quantity on new selection
  }

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  void onProceedToPay() {
    Get.back(); // Close popup
    Get.snackbar("Payment", "Proceeding to pay for ${quantity.value} items");
  }
}