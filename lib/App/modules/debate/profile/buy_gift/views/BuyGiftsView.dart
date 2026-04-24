import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/BuyGiftsController.dart';

class BuyGiftsView extends GetView<BuyGiftsController> {
  const BuyGiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Matches the dark background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.gifts.length,
                itemBuilder: (context, index) => _buildGiftCard(index),
              ),
            ),
            _buildBuyButton(),
            const SizedBox(height: 20), // Space for notched bottom nav
          ],
        ),
      ),
    );
  }

  void _showPurchasePopup() {
    final gift = controller.gifts[controller.selectedIndex.value];

    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1E1B4B), // Dark navy from image
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.white70),
                ),
              ),

              // Gift Info Card
              Container(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(gift['icon'], style: const TextStyle(fontSize: 50)),
                    const SizedBox(height: 10),
                    Text(gift['name'], style: AppText.body2.medium.copyWith(color: Colors.white)),
                    const SizedBox(height: 5),
                    Text("\$${gift['price']}", style: AppText.h3.bold.copyWith(color: Colors.white)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Quantity Selector
              Row(
                children: [
                  Text("Enter Quantity:", style: AppText.body1.bold.copyWith(color: Colors.white)),
                  const Spacer(),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E7FF), // Light blue input bg
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _quantityBtn(Icons.remove, controller.decrement),
                        SizedBox(
                          width: 60,
                          child: Obx(() => Center(
                            child: Text(
                              "${controller.quantity.value}",
                              style: AppText.body1.bold.copyWith(color: Colors.black54),
                            ),
                          )),
                        ),
                        _quantityBtn(Icons.add, controller.increment),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Proceed Button
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
                ),
                child: ElevatedButton(
                  onPressed: controller.onProceedToPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text("Proceed To Pay", style: AppText.body1.bold.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF818CF8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
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
          Text("Buy Gifts", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildGiftCard(int index) {
    final gift = controller.gifts[index];
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectGift(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6366F1).withOpacity(0.3)
                : const Color(0xFF1E1B4B).withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? const Color(0xFF818CF8) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(gift['icon'], style: const TextStyle(fontSize: 45)),
              const SizedBox(height: 12),
              Text(gift['name'], style: AppText.body2.medium.copyWith(color: Colors.white70)),
              const SizedBox(height: 8),
              Text("\$${gift['price']}", style: AppText.h3.bold.copyWith(color: Colors.white)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBuyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        bool hasSelection = controller.selectedIndex.value != -1;
        return Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: hasSelection
                  ? [const Color(0xFF818CF8), const Color(0xFF4F46E5)]
                  : [
                const Color(0xFFC7D2FE).withOpacity(0.5),
                const Color(0xFFC7D2FE).withOpacity(0.5),
              ],
            ),
          ),
          child: ElevatedButton(
            // UPDATED: Now calls the popup instead of controller.onBuyNow
            onPressed: hasSelection ? () => _showPurchasePopup() : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              "Buy Now",
              style: AppText.body1.bold.copyWith(
                color: hasSelection ? Colors.white : Colors.white38,
              ),
            ),
          ),
        );
      }),
    );
  }
}
