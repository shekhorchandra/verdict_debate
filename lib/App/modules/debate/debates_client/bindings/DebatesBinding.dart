import 'package:get/get.dart';
import '../controller/DebatesController.dart';


class DebatesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebatesController>(() => DebatesController());
  }
}