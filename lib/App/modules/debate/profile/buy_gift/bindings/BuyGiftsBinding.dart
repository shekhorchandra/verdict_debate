import 'package:get/get.dart';
import '../controller/BuyGiftsController.dart';

class BuyGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyGiftsController>(() => BuyGiftsController());
  }
}