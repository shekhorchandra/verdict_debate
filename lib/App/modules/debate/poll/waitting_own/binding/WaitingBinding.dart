import 'package:get/get.dart';
import '../controller/WaitingController.dart';


class WaitingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WaitingController());
  }
}