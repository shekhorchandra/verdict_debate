import 'package:get/get.dart';
import '../controller/explore_details_controller.dart';

class DebateDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebateDetailController>(() => DebateDetailController());
  }
}
