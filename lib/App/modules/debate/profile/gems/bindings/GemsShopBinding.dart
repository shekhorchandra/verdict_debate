import 'package:get/get.dart';
import '../controller/GemsShopController.dart';

class GemsShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GemsShopController>(() => GemsShopController());
  }
}