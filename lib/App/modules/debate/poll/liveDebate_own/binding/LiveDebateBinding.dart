import 'package:get/get.dart';
import '../controller/LiveDebateController.dart';


class LiveDebateOwnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveDebateOwnController());
  }
}