import 'package:get/get.dart';
import '../../arena/controller/ArenaController.dart';
import '../../debates_client/controller/DebatesController.dart';
import '../../explore_debate/explore/controller/DebateController.dart';
import '../../profile/controller/ProfileController.dart';
import '../controllers/bottom_nav_controller.dart';

class UserNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserNavigationBarController>(() => UserNavigationBarController());

    Get.lazyPut<DebateController>(() => DebateController());
    Get.lazyPut<DebatesController>(() => DebatesController());
    Get.lazyPut<ArenaController>(() => ArenaController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}