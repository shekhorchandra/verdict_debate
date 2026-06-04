import 'package:get/get.dart';
import '../controller/ExploreController.dart';

class DebateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreViewController>(() => ExploreViewController());
  }
}