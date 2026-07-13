import 'package:get/get.dart';
import '../../debates_live/challenge_1/controller/challenge_controller.dart';
import '../../explore_polls/explore/controller/ExploreController.dart';
import '../../private_debate/pvt_debate/controller/PrivateDebateController.dart';
import '../../profile/my_profile_view/controller/MyProfileController.dart';
import '../../profile/user_profile/controller/ProfileController.dart';
import '../controllers/bottom_nav_controller.dart';

class UserNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserNavigationBarController>(
      () => UserNavigationBarController(),
    );

    Get.lazyPut<ExploreViewController>(() => ExploreViewController());
    Get.lazyPut<ChallengeController>(() => ChallengeController());
    Get.lazyPut<PrivateDebateController>(() => PrivateDebateController());
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
