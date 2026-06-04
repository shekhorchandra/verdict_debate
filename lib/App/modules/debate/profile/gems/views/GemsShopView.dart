import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/GemsShopController.dart';

class GemsShopView extends GetView<GemsShopController> {
  const GemsShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E), // Deep dark background from design
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),

            // 1. Gems Balance Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text("Gems you have:", style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252348).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.diamond_outlined, color: Color(0xFFA5B4FC), size: 20),
                        const SizedBox(width: 8),
                        Obx(() => Text(
                          "${controller.currentBalance.value}",
                          style: AppText.body1.bold.copyWith(color: Colors.white),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. Gem Packs Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gem Packs", style: AppText.h4.bold.copyWith(color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(
                    "Buy gems and use them to unlock premium features",
                    style: AppText.label().copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Gem Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.82, // Made slightly taller to match design
                ),
                itemCount: controller.gemPacks.length,
                itemBuilder: (context, index) => _buildGemCard(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF252348), // Dark purple circle
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
              ),
            ),
          ),
          Text("Gems Shop", style: AppText.h5.bold.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildGemCard(int index) {
    final pack = controller.gemPacks[index];
    return GestureDetector(
      onTap: () => controller.purchasePack(index),
      child: Container(
        decoration: BoxDecoration(
          // Gradient or solid vibrant violet matches the design
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.diamond_outlined, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text("${pack['gems']} Gems", style: AppText.body1.medium.copyWith(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "\$${pack['price']}",
              style: AppText.h3.bold.copyWith(color: Colors.white, fontSize: 34),
            ),
            const SizedBox(height: 6),
            Text(
              "\$${pack['unit']}/ gem",
              style: AppText.label().copyWith(color: Colors.white.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }
}