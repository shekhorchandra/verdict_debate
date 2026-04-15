import 'package:get/get.dart';

import '../controller/VotingInsightsController.dart';


class VotingInsightsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VotingInsightsController>(() => VotingInsightsController());
  }
}