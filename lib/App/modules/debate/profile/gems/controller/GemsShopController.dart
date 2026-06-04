import 'package:get/get.dart';

class GemsShopController extends GetxController {
  // Aligned with the image provided
  final List<Map<String, dynamic>> gemPacks = [
    {"gems": "150", "price": "4.99", "unit": "0.03"},
    {"gems": "300", "price": "7.99", "unit": "0.02"},
    {"gems": "1,000", "price": "10.99", "unit": "0.01"},
    {"gems": "3,000", "price": "19.99", "unit": "0.006"},
  ];

  var currentBalance = 500.obs;

  void purchasePack(int index) {
    String gems = gemPacks[index]['gems'];
    Get.snackbar("Shop", "Redirecting to payment for $gems Gems...");
  }
}