import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/common/country/binding/GenderSelectionBinding.dart';
import '../modules/common/country/view/GenderSelectionView.dart';
import '../modules/common/onboarding/bindings/onboarding_binding.dart';
import '../modules/common/onboarding/views/onboarding_view.dart';
import '../modules/common/splash/bindings/splash_binding.dart';
import '../modules/common/splash/views/splash_view.dart';
import '../modules/debate/User_bottom_nav_bar/bindings/user_navigation_bar_binding.dart';
import '../modules/debate/User_bottom_nav_bar/views/bottom_nav_view.dart';
import '../modules/debate/arena_debate/bindings/ArenaBinding.dart';
import '../modules/debate/arena_debate/views/ArenaView.dart';
import '../modules/debate/debates_live/challenge_1/binding/challenge_binding.dart';
import '../modules/debate/debates_live/challenge_1/views/challenge_view.dart';

import '../modules/debate/debates_live/debate_final_4/binding/DebateBinding.dart';
import '../modules/debate/debates_live/debate_final_4/views/DebateView.dart';
import '../modules/debate/debates_live/live_challenge_2/binding/LiveChallengeBinding.dart';
import '../modules/debate/debates_live/live_challenge_2/views/LiveChallengeView.dart';
import '../modules/debate/debates_live/live_debtae_3/binding/live_debate_binding.dart';
import '../modules/debate/debates_live/live_debtae_3/views/live_debate_view.dart';
import '../modules/debate/explore_polls/explore/binding/DebateBinding.dart';
import '../modules/debate/explore_polls/explore/views/ExploreView.dart';
import '../modules/debate/explore_polls/explore_details/binding/DebateDetailBinding.dart';
import '../modules/debate/explore_polls/explore_details/views/DebateDetailView.dart';
import '../modules/debate/explore_polls/voting/binding/VotingInsightsBinding.dart';
import '../modules/debate/explore_polls/voting/views/VotingInsightsView.dart';
import '../modules/debate/poll/boost/binding/boost_poll_binding.dart';
import '../modules/debate/poll/boost/views/boost_poll_view.dart';
import '../modules/debate/poll/create_poll/binding/CreatePollBinding.dart';
import '../modules/debate/poll/create_poll/views/CreatePollView.dart';
import '../modules/debate/poll/liveDebate_own/binding/LiveDebateBinding.dart';
import '../modules/debate/poll/liveDebate_own/views/LiveDebateView.dart';
import '../modules/debate/poll/waitting_own/binding/WaitingBinding.dart';
import '../modules/debate/poll/waitting_own/views/WaitingView.dart';
import '../modules/debate/private_debate/country_filter/binding/CountryFilterBinding.dart';
import '../modules/debate/private_debate/country_filter/views/CountryFilterView.dart';
import '../modules/debate/private_debate/gender_filter/binding/GenderFilterBinding.dart';
import '../modules/debate/private_debate/gender_filter/views/GenderFilterView.dart';
import '../modules/debate/private_debate/live_stream/binding/live_stream_binding.dart';
import '../modules/debate/private_debate/live_stream/views/live_stream_view.dart';
import '../modules/debate/private_debate/match/binding/MatchSettingsBinding.dart';
import '../modules/debate/private_debate/match/views/MatchSettingsView.dart';
import '../modules/debate/private_debate/pvt_debate/binding/PrivateDebateBinding.dart';
import '../modules/debate/private_debate/pvt_debate/views/PrivateDebateView.dart';
import '../modules/debate/profile/about_us/views/About_View.dart';
import '../modules/debate/profile/account_setting/change_password/bindings/ChangePasswordBinding.dart';
import '../modules/debate/profile/account_setting/change_password/views/ChangePasswordView.dart';
import '../modules/debate/profile/account_setting/delete_account/bindings/DeleteAccountBinding.dart';
import '../modules/debate/profile/account_setting/delete_account/views/DeleteAccountView.dart';
import '../modules/debate/profile/account_setting/pause_account/bindings/PauseAccountBinding.dart';
import '../modules/debate/profile/account_setting/pause_account/views/PauseAccountView.dart';
import '../modules/debate/profile/account_setting/setting/bindings/AccountSettingsBinding.dart';
import '../modules/debate/profile/account_setting/setting/views/AccountSettingsView.dart';
import '../modules/debate/profile/buy_gift/bindings/BuyGiftsBinding.dart';
import '../modules/debate/profile/buy_gift/views/BuyGiftsView.dart';
import '../modules/debate/profile/chat/chat_conversation/binding/ChatBinding.dart';
import '../modules/debate/profile/chat/chat_conversation/views/ChatView.dart';
import '../modules/debate/profile/chat/message/binding/MessagesBinding.dart';
import '../modules/debate/profile/chat/message/views/MessagesView.dart';
import '../modules/debate/profile/edit_profile/binding/EditProfileBinding.dart';
import '../modules/debate/profile/edit_profile/views/EditProfileView.dart';
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
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    /// onboarding screen
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    /// auth screen
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.GENDER_SELECTION,
      page: () => const GenderSelectionView(),
      binding: GenderSelectionBinding(),

    ),


    /// User Bottom Nav Bar
    GetPage(
      name: AppRoutes.USER_BOTTOM_NAV,
      page: () => const UserNavigationBarPage(),
      binding: UserNavigationBinding(),
    ),

    /// Explore screen
    GetPage(
      name: AppRoutes.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreDebateBinding(),
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

    /// LIVE screen
    GetPage(
      name: AppRoutes.CHALLENGE,
      page: () => const ChallengeView(),
      binding: ChallengeBinding(),
    ),

    ///LIve challenge
    GetPage(
      name: AppRoutes.LIVECHALLENGE,
      page: () => const LiveChallengeView(),
      binding: LiveChallengeBinding(),
    ),

    ///LIve debate
    GetPage(
      name: AppRoutes.LIVEDEBATE,
      page: () => const LiveDebateView(),
      binding: LiveDebateBinding(),
    ),

    ///LIve final debate
    GetPage(
      name: AppRoutes.FINALDEBATES,
      page: () => const DebateView(),
      binding: DebateBinding(),
    ),

    /// private debate
    GetPage(
      name: AppRoutes.PRIVATE_DEBATE,
      page: () => const PrivateDebateView(),
      binding: PrivateDebateBinding(),
      transition: Transition.fadeIn, // Matches the smooth transition of the app
    ),

    /// country filter
    GetPage(
      name: AppRoutes.COUNTRY_FILTER,
      page: () => const CountryFilterView(),
      binding: CountryFilterBinding(),
      // Bottom-to-top transition makes it feel like a persistent bottom sheet
      transition: Transition.downToUp,
    ),

    /// gender filter
    GetPage(
      name: AppRoutes.GENDER_FILTER,
      page: () => const GenderFilterView(),
      binding: GenderFilterBinding(),
      // This transition makes the page slide up over the live screen
      transition: Transition.downToUp,
    ),

    /// matches
    GetPage(
      name: AppRoutes.MATCH_SETTINGS,
      page: () => const MatchSettingsView(),
      binding: MatchSettingsBinding(),
      transition: Transition.rightToLeft, // Standard forward transition
    ),

    GetPage(
      name: AppRoutes.LIVE_STREAM,
      page: () => const LiveStreamView(),
      binding: LiveStreamBinding(),
      // Adding a transition for a smooth "going live" feel
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    /// Arena Screen
    GetPage(
      name: AppRoutes.AREANA,
      page: () => const ArenaView(),
      binding: ArenaBinding(),
    ),

    /// Profile
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    /// edit profile
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),

    /// create poll
    GetPage(
      name: AppRoutes.CREATE_POLL,
      page: () => const CreatePollView(),
      binding: CreatePollBinding(),
    ),

    GetPage(
      name: AppRoutes.WAITING_ROOM,
      page: () => const WaitingView(),
      binding: WaitingBinding(),
      // Optional: Add a transition like the design implies
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: AppRoutes.LIVEOWN_DEBATE,
      page: () => const LiveDebateOwnView(),
      binding: LiveDebateOwnBinding(),
      // Adding a fade transition for a smooth "going live" feel
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    GetPage(
      name: AppRoutes.BOOST_POLL,
      page: () => const BoostPollView(),
      binding: BoostPollBinding(),
      // Adding a transition to match the iOS style back button in the UI
      transition: Transition.cupertino,
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
    GetPage(
      name: AppRoutes.GIFT,
      page: () => const GiftsView(),
      binding: GiftsBinding(),
    ),

    /// withdraw earnings
    GetPage(
      name: AppRoutes.WITHDRAW_EARNINGS,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),

    /// messages
    GetPage(
      name: AppRoutes.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),

    ///chat conversation
    GetPage(
      name: AppRoutes.CHAT_DETAILS,
      page: () => const ChatView(),
      binding: ChatBinding(),
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

        return PaymentMethodsView(
          isSelectable: args['isSelectable'] as bool? ?? false,
        );
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

    GetPage(
      name: AppRoutes.PAUSE_ACCOUNT,
      page: () => const PauseAccountView(),
      binding: PauseAccountBinding(),
    ),

    GetPage(name: AppRoutes.ABOUT, page: () => const AboutView()),
    GetPage(
      name: AppRoutes.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
    ),
    GetPage(
      name: AppRoutes.TERMS_CONDITION,
      page: () => const TermsConditionView(),
    ),
    GetPage(name: AppRoutes.HELP_SUPPORT, page: () => const HelpSupportView()),
  ];
}
