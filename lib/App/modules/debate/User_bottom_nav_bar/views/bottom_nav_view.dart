import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_color.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/bottom_nav_controller.dart';

import 'dart:ui';

import 'BottomNavClipper.dart';

class UserNavigationBarPage extends GetView<UserNavigationBarController> {
  const UserNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserNavigationBarController());

    return Scaffold(
      extendBody: true, // Crucial: content flows behind the nav bar
      backgroundColor: Colors.transparent,
      body: Obx(() {
        return Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            if (controller.currentOverlayPage.value != null) controller.currentOverlayPage.value!,
          ],
        );
      }),
      bottomNavigationBar: Container(
        height: 130, // Height to accommodate floating button
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // 1. The Background Bar with Notch and Blur
            ClipPath(
              clipper: BottomNavClipper(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    // Deep indigo background from your scale
                    color: AppColor.primaryScale.s950.withOpacity(0.85),
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navItem(0, 'Polls', AppAssets.polls, controller),
                        _navItem(1, 'Live', AppAssets.live, controller),
                        const SizedBox(width: 60), // Spacer for center button
                        _navItem(2, 'Debate', AppAssets.debate, controller),
                        _navItem(3, 'Profile', AppAssets.profile, controller),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 2. The Floating Action Button (Center)
            Positioned(
              top: 0,
              child: GestureDetector(
                onTap: () {
                  // NAVIGATE TO THE CREATE POLL PAGE
                  Get.toNamed(AppRoutes.CREATE_POLL);
                },
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primaryScale.s600,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryScale.s600.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: Colors.black.withOpacity(0.3), width: 4),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, String label, String asset, UserNavigationBarController controller) {
    bool isSelected = controller.selectedIndex.value == index;
    // Highlight color (s400) or inactive color (s400 with opacity)
    Color color = isSelected
        ? AppColor.primaryScale.s400
        : AppColor.primaryScale.s400.withOpacity(0.5);

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
