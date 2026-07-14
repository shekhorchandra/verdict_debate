import 'package:get/get.dart';
import '../controller/LiveStreamController.dart';


class LiveStreamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveStreamController());
  }
}