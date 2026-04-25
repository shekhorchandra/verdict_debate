import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/GemsShopController.dart';

class GemsShopView extends GetView<GemsShopController> {
  const GemsShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gem Packs", style: AppText.h3.bold.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    "Buy gems and use them to unlock premium features",
                    style: AppText.body2().copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
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
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            ),
          ),
          const Spacer(),
          Text("Gems Shop", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40), // Balance the back button
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
          color: const Color(0xFF818CF8).withOpacity(0.85), // Vibrant purple from your scale
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.diamond_outlined, color: Colors.white, size: 24),
                const SizedBox(width: 8),
                Text("${pack['gems']} Gems", style: AppText.body1.bold.copyWith(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            Text("\$${pack['price']}",
                style: AppText.title.bold.copyWith(color: Colors.white, fontSize: 32)
            ),
            const SizedBox(height: 8),
            Text("\$${pack['unit']}/ gem",
                style: AppText.label().copyWith(color: Colors.white70)
            ),
          ],
        ),
      ),
    );
  }
}