import 'package:get/get.dart';

import '../controller/WaitingDebateController.dart';


class WaitingDebateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitingDebateController>(() => WaitingDebateController());
  }
}