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
import '../modules/debate/profile/about_us/views/About_View.dart';
import '../modules/debate/profile/account_setting/change_password/bindings/ChangePasswordBinding.dart';
import '../modules/debate/profile/account_setting/change_password/views/ChangePasswordView.dart';
import '../modules/debate/profile/account_setting/delete_account/bindings/DeleteAccountBinding.dart';
import '../modules/debate/profile/account_setting/delete_account/views/DeleteAccountView.dart';
import '../modules/debate/profile/account_setting/setting/bindings/AccountSettingsBinding.dart';
import '../modules/debate/profile/account_setting/setting/views/AccountSettingsView.dart';
import '../modules/debate/profile/buy_gift/bindings/BuyGiftsBinding.dart';
import '../modules/debate/profile/buy_gift/views/BuyGiftsView.dart';
import '../modules/debate/profile/gems/bindings/GemsShopBinding.dart';
import '../modules/debate/profile/gems/views/GemsShopView.dart';
import '../modules/debate/profile/gift/bindings/GiftsBinding.dart';
import '../modules/debate/profile/gift/views/GiftsView.dart';
import '../modules/debate/profile/help_support/help_support_view/Help_Support_View.dart';
import '../modules/debate/profile/my_profile_view/bindings/MyProfileBinding.dart';
import '../modules/debate/profile/my_profile_view/views/MyProfileView.dart';
import '../modules/debate/profile/package/bindings/PremiumPlansBinding.dart';
import '../modules/debate/profile/package/views/PremiumPlansView.dart';
import '../modules/debate/profile/payment_method/bindings/payment_method_binding.dart';
import '../modules/debate/profile/payment_method/view/add_new_card_view.dart';
import '../modules/debate/profile/payment_method/view/payment_methods_view.dart';
import '../modules/debate/profile/privacy_policy/privacy_policy_view/Privacy_Policy_View.dart';
import '../modules/debate/profile/terms_condition/terms_condition_view/Terms_Condition_View.dart';
import '../modules/debate/profile/user_profile/bindings/ProfileBinding.dart';
import '../modules/debate/profile/user_profile/views/ProfileView.dart';
import '../modules/debate/profile/widthdraw_earning/bindings/WithdrawBinding.dart';
import '../modules/debate/profile/widthdraw_earning/views/WithdrawView.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    /// splash screen
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashView(), binding: SplashBinding()),

    /// onboarding screen
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    /// auth screen
    GetPage(name: AppRoutes.AUTH, page: () => const AuthView(), binding: AuthBinding()),

    /// User Bottom Nav Bar
    GetPage(
      name: AppRoutes.USER_BOTTOM_NAV,
      page: () => const UserNavigationBarPage(),
      binding: UserNavigationBinding(),
    ),

    /// Explore screen
    GetPage(name: AppRoutes.EXPLORE, page: () => const ExploreView(), binding: DebateBinding()),

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

    /// debates screen
    GetPage(name: AppRoutes.DEBATES, page: () => const DebatesView(), binding: DebatesBinding()),

    /// Arena Screen
    GetPage(name: AppRoutes.AREANA, page: () => const ArenaView(), binding: ArenaBinding()),

    /// Profile
    GetPage(name: AppRoutes.PROFILE, page: () => const ProfileView(), binding: ProfileBinding()),

    /// create poll
    GetPage(
      name: AppRoutes.CREATE_POLL,
      page: () => const CreatePollView(),
      binding: CreatePollBinding(),
    ),

    ///gems shop
    GetPage(
      name: AppRoutes.GEMS_SHOP,
      page: () => const GemsShopView(),
      binding: GemsShopBinding(),
    ),

    /// premium package
    GetPage(
      name: AppRoutes.PREMIUM_PLANS,
      page: () => const PremiumPlansView(),
      binding: PremiumPlansBinding(),
    ),

    /// user own profile
    GetPage(
      name: AppRoutes.MY_PROFILE,
      page: () => const MyProfileView(),
      binding: MyProfileBinding(),
    ),

    /// gift profile
    GetPage(name: AppRoutes.GIFT, page: () => const GiftsView(), binding: GiftsBinding()),

    /// withdraw earnings
    GetPage(
      name: AppRoutes.WITHDRAW_EARNINGS,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),

    /// Buy gifts
    GetPage(
      name: AppRoutes.BUY_GIFTS,
      page: () => const BuyGiftsView(),
      binding: BuyGiftsBinding(),
    ),

    /// paymernt method
    GetPage(
      name: AppRoutes.ADD_PAYMENT_METHOD,
      page: () => AddNewCardView(),
      binding: PaymentMethodBinding(),
    ),

    GetPage(
      name: AppRoutes.PAYMENT_METHOD,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};

        return PaymentMethodsView(isSelectable: args['isSelectable'] as bool? ?? false);
      },
      binding: PaymentMethodBinding(),
    ),

    GetPage(
      name: AppRoutes.ACCOUNT_SETTING,
      page: () => const AccountSettingsView(),
      binding: AccountSettingsBinding(),
    ),

    GetPage(
      name: AppRoutes.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),

    GetPage(
      name: AppRoutes.DELETE_ACCOUNT,
      page: () => const DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
    GetPage(name: AppRoutes.ABOUT, page: () => const AboutView()),
    GetPage(name: AppRoutes.PRIVACY_POLICY, page: () => const PrivacyPolicyView()),
    GetPage(name: AppRoutes.TERMS_CONDITION, page: () => const TermsConditionView()),
    GetPage(name: AppRoutes.HELP_SUPPORT, page: () => const HelpSupportView()),
  ];
}
