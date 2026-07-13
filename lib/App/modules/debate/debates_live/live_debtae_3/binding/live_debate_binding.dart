import 'package:get/get.dart';
import '../controller/live_debate_controller.dart';

class LiveDebateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveDebateController());
  }
}