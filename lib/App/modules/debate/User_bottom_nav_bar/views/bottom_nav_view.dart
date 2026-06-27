// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../../core/values/app_assets.dart';
// import '../../../../core/values/app_color.dart';
// import '../../../../routes/app_routes.dart';
// import '../controllers/bottom_nav_controller.dart';
//
// import 'dart:ui';
//
// import 'BottomNavClipper.dart';
//
// class UserNavigationBarPage extends GetView<UserNavigationBarController> {
//   const UserNavigationBarPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserNavigationBarController());
//
//     return Scaffold(
//       extendBody: true, // Crucial: content flows behind the nav bar
//       backgroundColor: Colors.transparent,
//       body: Obx(() {
//         return Stack(
//           children: [
//             controller.screens[controller.selectedIndex.value],
//             if (controller.currentOverlayPage.value != null) controller.currentOverlayPage.value!,
//           ],
//         );
//       }),
//       bottomNavigationBar: Container(
//         height: 130, // Height to accommodate floating button
//         padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//         child: Stack(
//           alignment: Alignment.bottomCenter,
//           children: [
//             // 1. The Background Bar with Notch and Blur
//             ClipPath(
//               clipper: BottomNavClipper(),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                 child: Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                     // Deep indigo background from your scale
//                     color: AppColor.primaryScale.s950.withOpacity(0.85),
//                     border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
//                   ),
//                   child: Obx(
//                     () => Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _navItem(0, 'Polls', AppAssets.polls, controller),
//                         _navItem(1, 'Live', AppAssets.live, controller),
//                         const SizedBox(width: 60), // Spacer for center button
//                         _navItem(2, 'Debate', AppAssets.debate, controller),
//                         _navItem(3, 'Profile', AppAssets.profile, controller),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             // 2. The Floating Action Button (Center)
//             Positioned(
//               top: 0,
//               child: GestureDetector(
//                 onTap: () {
//                   // NAVIGATE TO THE CREATE POLL PAGE
//                   Get.toNamed(AppRoutes.CREATE_POLL);
//                 },
//                 child: Container(
//                   height: 65,
//                   width: 65,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColor.primaryScale.s600,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColor.primaryScale.s600.withOpacity(0.4),
//                         blurRadius: 15,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                     border: Border.all(color: Colors.black.withOpacity(0.3), width: 4),
//                   ),
//                   child: const Icon(Icons.add, color: Colors.white, size: 35),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _navItem(int index, String label, String asset, UserNavigationBarController controller) {
//     bool isSelected = controller.selectedIndex.value == index;
//     // Highlight color (s400) or inactive color (s400 with opacity)
//     Color color = isSelected
//         ? AppColor.primaryScale.s50
//         : AppColor.primaryScale.s400.withOpacity(0.5);
//
//     return GestureDetector(
//       onTap: () => controller.changeTab(index),
//       behavior: HitTestBehavior.opaque,
//       child: SizedBox(
//         width: 60,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               asset,
//               width: 24,
//               height: 24,
//               colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

////////////////////////////// For only fist phase  ///////////////////////////////////
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_color.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/bottom_nav_controller.dart';

class UserNavigationBarPage extends GetView<UserNavigationBarController> {
  const UserNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserNavigationBarController());

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,

      body: Obx(() {
        return Stack(
          children: [
            controller.screens[controller.selectedIndex.value],
            if (controller.currentOverlayPage.value != null)
              controller.currentOverlayPage.value!,
          ],
        );
      }),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(42),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: 86,
                  width: 250, // ✅ controls total nav width
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42),
                    color: const Color(0xFF120A2A).withOpacity(0.82),
                    border: Border.all(
                      color: AppColor.primaryScale.s500.withOpacity(0.55),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryScale.s700.withOpacity(0.35),
                        blurRadius: 28,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Add Button
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.CREATE_POLL);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 68,
                          width: 68,
                          child: Center(
                            child: Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.08),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryScale.s500
                                        .withOpacity(0.25),
                                    blurRadius: 16,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white.withOpacity(0.92),
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 18), // ✅ small gap only
                      /// Profile Button
                      /// Profile Button
                      Obx(() {
                        final bool isSelected =
                            controller.selectedIndex.value == 0;

                        return GestureDetector(
                          onTap: () {
                            controller.changeTab(0);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            height: 68,
                            width: 92,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.profile,
                                  width: 25,
                                  height: 25,
                                  colorFilter: ColorFilter.mode(
                                    isSelected
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.85),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.82),
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
