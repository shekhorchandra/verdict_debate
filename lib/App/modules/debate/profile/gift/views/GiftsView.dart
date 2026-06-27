import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../routes/app_routes.dart';
import '../controller/GiftsController.dart';

class GiftsView extends GetView<GiftsController> {
  const GiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important for GlobalBackground
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGiftsCard(),
                      const SizedBox(height: 25),
                      _buildHistoryHeader(),
                      const SizedBox(height: 15),
                      controller.selectedTab.value == 0
                          ? _buildReceivedHistory()
                          : _buildPurchaseHistory(),
                      const SizedBox(height: 100), // Bottom nav space
                    ],
                  ),
                ),
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
          Text("Gifts", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _tabItem("Received Gifts", Icons.card_giftcard, 0),
            _tabItem("My Gift Box", Icons.shopping_cart_outlined, 1),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String label, IconData icon, int index) {
    bool isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFF6366F1)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white54,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppText.body2.medium.copyWith(
                  color: isSelected ? Colors.white : Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGiftsCard() {
    bool isReceived = controller.selectedTab.value == 0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF44418B), Color(0xFF242260)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isReceived ? "Gift Earnings" : "My Gifts",
            style: AppText.h4.bold.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 15,
            children: controller.giftInventory.map((gift) => _giftItem(gift)).toList(),
          ),
          const SizedBox(height: 25),

          // Passing navigation logic here
          _gradientButton(
            isReceived ? "Redeem Earnings" : "Buy Gifts",
            isReceived ? Icons.ios_share : null,
            onTap: () {
              if (isReceived) {
                // Navigate to Withdraw Earnings page
                Get.toNamed(AppRoutes.WITHDRAW_EARNINGS);
              } else {
                // Navigate to Gems Shop / Buy Gifts page
                Get.toNamed(AppRoutes.BUY_GIFTS);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _giftItem(Map<String, dynamic> gift) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 75,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Text(
                gift['icon'],
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 5),
              Text(
                gift['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10, // increased
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF818CF8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              gift['count'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _gradientButton(String label, IconData? icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // Ensures the whole button area is clickable
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6366F1),
              Color(0xFF3730A3),
            ],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: Colors.white, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Row(
      children: [
        const Icon(Icons.history, color: Colors.white, size: 20),
        const SizedBox(width: 8),
        Text("History", style: AppText.body1.bold.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildReceivedHistory() {
    return Column(
      children: [
        _receivedHistoryTile("Lightning Bolt", "@wayne_roney", "⚡"),
        _receivedHistoryTile("Boxing Glove", "@rafaelleao", "🥊"),
      ],
    );
  }

  Widget _receivedHistoryTile(String title, String sender, String icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        // color: const Color(0xFF818CF8).withOpacity(0.5),
        gradient: const LinearGradient(colors: [Color(0xFF44418B), Color(0xFF242260)]),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF818CF8).withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppText.body2.bold.copyWith(color: Colors.white)),
                    Text("Send by $sender", style: AppText.label().copyWith(color: Colors.white54)),
                  ],
                ),
              ),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: Text(
                      icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),

                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFF6366F1),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "5x",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFA5B4FC).withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'From: "Should remote work be the default for tech....',
              style: TextStyle(color: Color(0xFF312E81), fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseHistory() {
    return Column(
      children: [
        _purchaseHistoryTile("3x Microphone", "02/04/26"),
        _purchaseHistoryTile("2x Lightning Bolt", "02/04/26"),
      ],
    );
  }

  Widget _purchaseHistoryTile(String items, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF44418B),
            Color(0xFF242137),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Text(
              "Your purchase of $items has been received.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            date,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
