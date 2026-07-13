import 'package:get/get.dart';

import '../controller/LiveChallengeController.dart';

class LiveChallengeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveChallengeController>(
          () => LiveChallengeController(),
    );
  }
}