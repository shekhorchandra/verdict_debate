import 'package:get/get.dart';
import '../controller/GiftsController.dart';

class GiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiftsController>(() => GiftsController());
  }
}