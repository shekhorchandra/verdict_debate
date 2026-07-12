import 'package:get/get.dart';
import '../controller/PrivateDebateController.dart';

class PrivateDebateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivateDebateController>(() => PrivateDebateController());
  }
}