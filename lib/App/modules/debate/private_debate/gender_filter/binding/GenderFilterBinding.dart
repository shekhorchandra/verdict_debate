import 'package:get/get.dart';
import '../controller/GenderFilterController.dart';

class GenderFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenderFilterController>(() => GenderFilterController());
  }
}