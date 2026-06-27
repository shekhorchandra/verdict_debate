import 'package:get/get.dart';
import '../controller/PauseAccountController.dart';

class PauseAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PauseAccountController>(() => PauseAccountController());
  }
}