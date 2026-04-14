import 'package:get/get.dart';
import '../controller/DebateController.dart';

class DebateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebateController>(() => DebateController());
  }
}