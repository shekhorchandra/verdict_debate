import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import '../../../core/values/app_color.dart';
import '../../../core/values/app_text.dart';
import '../controller/bottom_nav_controller.dart';
import 'BottomNavClipper.dart';
// Import your color/text files here
// import 'path_to_your_app_color.dart';

class CustomNavigationBar extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.transparent,
      child: Stack(
        children: [
          // The background shape
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ClipPath(
                clipper: BottomNavClipper(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.primaryScale.s950.withOpacity(0.85),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 0.5,
                      ),
                    ),
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.public, "Explore", 0),
                        _buildNavItem(Icons.public, "Debates", 1), // Swap with your sword icon
                        const SizedBox(width: 60), // Space for the center button
                        _buildNavItem(Icons.local_fire_department, "Arena", 2),
                        _buildNavItem(Icons.person_outline, "Profile", 3),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
          // The Floating Center Button
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryScale.s600,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryScale.s600.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = controller.currentIndex.value == index;
    Color color = isSelected ? AppColor.primaryScale.s400 : AppColor.neutral.s400;

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppText.label().copyWith(
              color: color,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}