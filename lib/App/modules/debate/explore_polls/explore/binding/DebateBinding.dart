import 'package:get/get.dart';
import '../controller/ExploreController.dart';

class ExploreDebateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreViewController>(() => ExploreViewController());
  }
}