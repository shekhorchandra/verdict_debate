import 'package:get/get.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/common/onboarding/bindings/onboarding_binding.dart';
import '../modules/common/onboarding/views/onboarding_view.dart';
import '../modules/common/splash/bindings/splash_binding.dart';
import '../modules/common/splash/views/splash_view.dart';
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
      binding: AuthBinding(), // Link the binding here
    ),
  ];
}