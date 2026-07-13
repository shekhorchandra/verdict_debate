import 'package:get/get.dart';
import '../controller/DebateController.dart';

class DebateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DebateController());
  }
}