import 'package:get/get.dart';
import '../../arena/controller/ArenaController.dart';

import '../../debates_client/live/controller/DebatesController.dart';
import '../../explore_debate/explore/controller/ExploreController.dart';
import '../../profile/controller/ProfileController.dart';
import '../controllers/bottom_nav_controller.dart';

class UserNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserNavigationBarController>(() => UserNavigationBarController());

    Get.lazyPut<ExploreViewController>(() => ExploreViewController());
    Get.lazyPut<DebatesController>(() => DebatesController());
    Get.lazyPut<ArenaController>(() => ArenaController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}