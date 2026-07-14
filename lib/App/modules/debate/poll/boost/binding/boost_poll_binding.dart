import 'package:get/get.dart';

import '../controller/boost_poll_controller.dart';


class BoostPollBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BoostPollController());
  }
}