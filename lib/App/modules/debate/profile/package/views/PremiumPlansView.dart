import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/PremiumPlansController.dart';

class PremiumPlansView extends GetView<PremiumPlansController> {
  const PremiumPlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E28), // Matches dark background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildPlanCard(
                      title: "Premium",
                      subtitle: "Unlimited access, maximum benefits",
                      price: "19.99",
                      accentColor: const Color(0xFF6366F1),
                      benefits: [
                        "Unlimited Live Debates",
                        "Unlimited Private Debates",
                        "Unlimited Poll Creation",
                        "Unlimited Voting",
                        "95% of Earnings",
                        "Unlimited Gems",
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildPlanCard(
                      title: "Gold",
                      subtitle: "More debates more rewards",
                      price: "14.99",
                      accentColor: const Color(0xFFFFD700), // Gold Color
                      benefits: [
                        "Unlimited Live debates",
                        "Unlimited Private Debates",
                        "Unlimited Poll Creation",
                        "Unlimited Voting",
                        "80% of Earnings",
                        "1,000 Free Gems/ month",
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildPlanCard(
                      title: "Free",
                      subtitle: "Get started with basic access",
                      price: "0",
                      accentColor: Colors.white70,
                      isCurrentPlan: true,
                      benefits: [
                        "5 Live Debates /month",
                        "15 Private Debates /month",
                        "Unlimited Poll Creation",
                        "Unlimited Voting",
                        "25% or Earnings",
                      ],
                    ),
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
          Text("Premium Plans", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required Color accentColor,
    required List<String> benefits,
    bool isCurrentPlan = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCurrentPlan ? Colors.transparent : accentColor.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.h3.bold.copyWith(color: accentColor)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppText.label().copyWith(color: Colors.white54)),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "\$$price",
                      style: AppText.h2.bold.copyWith(color: Colors.white),
                    ),
                    TextSpan(
                      text: " /month",
                      style: AppText.label().copyWith(color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ...benefits.map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: accentColor, size: 18),
                const SizedBox(width: 10),
                Text(benefit, style: AppText.body2().copyWith(color: Colors.white)),
              ],
            ),
          )),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: isCurrentPlan
                  ? null
                  : const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4338CA)]),
              color: isCurrentPlan ? Colors.white.withOpacity(0.1) : null,
            ),
            child: ElevatedButton(
              onPressed: isCurrentPlan ? null : () => controller.selectPlan(title),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                isCurrentPlan ? "Current Plan" : "Choose Plan",
                style: AppText.body1.bold.copyWith(
                  color: isCurrentPlan ? Colors.white38 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}