import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../../../../core/widgets/App_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    // The requested button/indicator gradient
    final primaryGradient = LinearGradient(
      colors: [
      AppColor.primaryScale.s600, // Blue 800
        AppColor.primaryScale.s500, // Indigo 500

      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: Colors.transparent, // Important for GlobalBackground
      body: Stack(
        children: [
          // 1. BACKGROUND PAGEVIEW
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              final page = controller.pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // THE IMAGE
                  Image.asset(
                    page['image']!,
                    fit: BoxFit.cover,
                  ),

                  // THE FULL PAGE GRADIENT OVERLAY
                  // This matches the image: dark tint at top, deep indigo middle, black bottom
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // Top: Slight dark tint (not fully transparent)
                          AppColor.primaryScale.s950.withOpacity(0.3),
                          // Upper Middle: Indigo wash
                          AppColor.primaryScale.s950.withOpacity(0.6),
                          // Lower Middle: Very dark indigo/black blend
                          Colors.black.withOpacity(0.8),
                          // Bottom: Solid black for text/button contrast
                          // Colors.black,
                          AppColor.primaryScale.s950.withOpacity(0.1),
                        ],
                        stops: const [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                  ),

                  // TEXT CONTENT
                  Positioned(
                    left: 30,
                    right: 30,
                    bottom: 230,
                    child: Column(
                      children: [
                        Text(
                          page['title']!,
                          textAlign: TextAlign.center,
                          style: AppText.h1.bold.copyWith(
                            color: const Color(0xFFA5B4FC),
                            fontSize: 24,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppText.body2.regular.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. FIXED UI (INDICATORS & BUTTONS)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // PAGE INDICATORS
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.pages.length,
                        (index) {
                      bool isActive = controller.currentPage.value == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 5,
                        width: isActive ? 22 : 10,
                        decoration: BoxDecoration(
                          gradient: isActive ? primaryGradient : null,
                          color: isActive
                              ? null
                              : AppColor.primaryScale.s900.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                )),

                const SizedBox(height: 40),

                // NEXT BUTTON WITH GRADIENT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Obx(() {
                        final isLastPage =
                            controller.currentPage.value == controller.pages.length - 1;

                        return Text(
                          isLastPage ? 'Get Started' : 'Next',
                          style: AppText.body1.bold.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // SKIP BUTTON
                GestureDetector(
                  onTap: controller.skip,
                  child: Text(
                    'Skip',
                    style: AppText.body2.medium.copyWith(
                      color: AppColor.neutral.s500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
