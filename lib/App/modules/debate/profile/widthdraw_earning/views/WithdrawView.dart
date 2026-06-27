import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/WithdrawController.dart';

class WithdrawView extends GetView<WithdrawController> {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildConversionCard(),
                    const SizedBox(height: 20),
                    _buildWithdrawCard(),
                    const SizedBox(height: 25),
                    Text("Payout Method", style: AppText.body1.bold.copyWith(color: Colors.white)),
                    const SizedBox(height: 12),
                    _buildPayoutMethodTile(),
                    const SizedBox(height: 25),
                    _buildHistorySection(),
                    const SizedBox(height: 100), // Bottom nav space
                  ],
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
          Text("Withdraw Earnings", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildConversionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF44418B),
            Color(0xFF242260),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gift Values",
            style: AppText.body2.medium.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 12),

          // Gift Legend
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Wrap(
              spacing: 15,
              runSpacing: 10,
              children: controller.giftValues
                  .map((g) => _giftValueItem(g['icon']!, g['value']!))
                  .toList(),
            ),
          ),

          const SizedBox(height: 20),

          // Conversion Inputs
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "🎤 3x",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.compare_arrows,
                  color: Colors.white54,
                  size: 28,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "\$3",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          _gradientButton("Convert", controller.onConvert),
        ],
      ),
    );
  }

  Widget _giftValueItem(String icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 4),
        Text(
          "= $value",
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildWithdrawCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF44418B),
            Color(0xFF242260),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: "Available Funds: "),
                      TextSpan(
                        text: "\$${controller.availableFunds.value}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "\$${controller.withdrawAmount.value}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _gradientButton("Withdraw", controller.onWithdraw),
        ],
      ),
    );
  }

  Widget _buildPayoutMethodTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF44418B),
            Color(0xFF242137),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.account_balance,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              "Bank of USA 1234****55465",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 8),

          SizedBox(
            height: 34,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF3730A3),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 13,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.history, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text("History", style: AppText.body1.bold.copyWith(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 15),
        _historyTile(),
        _historyTile(),
      ],
    );
  }

  Widget _historyTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF44418B), Color(0xFF242137)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your withdrawal amount has been successfully debited to your payout account 1234****55465",
                  style: TextStyle(color: Colors.white, fontSize: 11, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text("02/04/26", style: TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _gradientButton(String label, VoidCallback onTap) {
    return Container(
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
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
