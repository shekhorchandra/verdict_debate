import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/common/onboarding/bindings/onboarding_binding.dart';
import '../modules/common/onboarding/views/onboarding_view.dart';
import '../modules/common/splash/bindings/splash_binding.dart';
import '../modules/common/splash/views/splash_view.dart';
import '../modules/debate/User_bottom_nav_bar/bindings/user_navigation_bar_binding.dart';
import '../modules/debate/User_bottom_nav_bar/views/bottom_nav_view.dart';
import '../modules/debate/arena/bindings/ArenaBinding.dart';
import '../modules/debate/arena/views/ArenaView.dart';
import '../modules/debate/debates_client/live/bindings/DebatesBinding.dart';
import '../modules/debate/debates_client/live/views/DebatesView.dart';
import '../modules/debate/explore_debate/explore/binding/ExploreBinding.dart';
import '../modules/debate/explore_debate/explore/views/ExploreView.dart';
import '../modules/debate/explore_debate/explore_details/binding/explore_details_binding.dart';
import '../modules/debate/explore_debate/explore_details/views/DebateDetailsPage.dart';
import '../modules/debate/explore_debate/voting/binding/VotingInsightsBinding.dart';
import '../modules/debate/explore_debate/voting/views/VotingInsightsView.dart';
import '../modules/debate/poll/binding/CreatePollBinding.dart';
import '../modules/debate/poll/views/CreatePollView.dart';
import '../modules/debate/profile/bindings/ProfileBinding.dart';
import '../modules/debate/profile/views/ProfileView.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.EXPLORE,
      page: () => const ExploreView(),
      binding: DebateBinding(),
    ),

    GetPage(
      name: AppRoutes.EXPLORE_DETAILS,
      page: () => const DebateDetailView(),
      binding: DebateDetailBinding(),
      transition: Transition.downToUp,
    ),

    GetPage(
      name: AppRoutes.VOTING_INSIGHTS,
      page: () => const VotingInsightsView(),
      binding: VotingInsightsBinding(),
    ),

    /// User Bottom Nav Bar
    GetPage(
      name: AppRoutes.USER_BOTTOM_NAV,
      page: () => const UserNavigationBarPage(),
      binding: UserNavigationBinding(),
    ),

    GetPage(
      name: AppRoutes.DEBATES,
      page: () => const DebatesView(),
      binding: DebatesBinding(),
    ),
    GetPage(
      name: AppRoutes.AREANA,
      page: () => const ArenaView(),
      binding: ArenaBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    /// create poll
    GetPage(
      name: AppRoutes.CREATE_POLL,
      page: () => const CreatePollView(),
      binding: CreatePollBinding(),
    ),

  ];
}