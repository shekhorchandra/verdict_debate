import 'package:get/get.dart';

import '../controller/DebateDetailController.dart';


class DebateDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebateDetailController>(() => DebateDetailController());
  }
}