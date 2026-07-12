import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/GenderFilterController.dart';

class GenderFilterView extends GetView<GenderFilterController> {
  const GenderFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Live Video Background (Placeholder image)
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6",
              fit: BoxFit.cover,
            ),
          ),

          // 2. Translucent Overlay and Top UI
          _buildTopOverlay(),

          // 3. Video Action Buttons (Camera, Volume, Mic)
          _buildVideoControls(),

          // 4. Bottom Selection Menu
          _buildBottomMenu(),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.diamond, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Obx(() => Text("${controller.gemBalance.value}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Positioned(
      bottom: Get.height * 0.42, // Positioned just above the bottom menu
      left: 0, right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controlIcon(Icons.videocam_outlined),
          const SizedBox(width: 20),
          _controlIcon(Icons.volume_up_outlined),
          const SizedBox(width: 20),
          _controlIcon(Icons.mic_none_outlined),
        ],
      ),
    );
  }

  Widget _controlIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildBottomMenu() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF2E2C5C), // Dark purple menu
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Gender Filter", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 20),

            // Gender Cards Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _genderCard("Random", "https://cdn-icons-png.flaticon.com/512/3468/3468301.png", 0),
                _genderCard("Male", "https://cdn-icons-png.flaticon.com/512/4140/4140048.png", 1, cost: 25),
                _genderCard("Female", "https://cdn-icons-png.flaticon.com/512/4140/4140047.png", 2, cost: 25),
              ],
            ),

            const Spacer(),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: _buildConfirmButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderCard(String label, String iconUrl, int index, {int? cost}) {
    return Obx(() {
      bool isSelected = controller.selectedGender.value == index;
      return GestureDetector(
        onTap: () => controller.selectGender(index),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Get.width * 0.28,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1) : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? Colors.white : Colors.white10),
              ),
              child: Column(
                children: [
                  Image.network(iconUrl, height: 50),
                  const SizedBox(height: 10),
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            if (cost != null)
              Positioned(
                top: -8, right: -5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF2E2C5C), width: 2)),
                  child: Row(
                    children: [
                      const Icon(Icons.diamond, color: Colors.white, size: 10),
                      const SizedBox(width: 4),
                      Text("$cost", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity, height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
      ),
      child: ElevatedButton(
        onPressed: controller.onConfirm,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Confirm & Continue", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            const Icon(Icons.diamond, color: Colors.white, size: 18),
            const SizedBox(width: 4),
            Text("${controller.filterCost}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}