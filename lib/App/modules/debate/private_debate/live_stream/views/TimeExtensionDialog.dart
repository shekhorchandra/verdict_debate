import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/LiveStreamController.dart';


class TimeExtensionDialog extends GetView<LiveStreamController> {
  const TimeExtensionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2E2B5F), // Deep Purple
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Your debate time is almost up!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Timer Display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF8A8AFF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(() => RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    children: [
                      // This will show 00:59s, 00:58s... inside the popup
                      TextSpan(text: "00:${controller.totalSeconds.value.toString().padLeft(2, '0')}s"),
                      const TextSpan(text: " left", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ))
              ),

              const SizedBox(height: 15),
              const Text(
                "Want to keep the conversation going? Extend your debate by using gems and continue the discussion!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
              ),

              const SizedBox(height: 25),

              // Plan Selection Cards
              Row(
                children: [
                  _buildPlanCard(0, "15", "+ 5 minutes"),
                  const SizedBox(width: 10),
                  _buildPlanCard(1, "30", "+ 10 minutes"),
                ],
              ),
              const SizedBox(height: 15),
              _buildPlanCard(2, "45", "+ 15 minutes", isFullWidth: true),

              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(child: _actionBtn("Cancel", const Color(0xFFFF4B4B), () => Get.back())),
                  const SizedBox(width: 15),
                  Expanded(child: _actionBtn("Confirm", const Color(0xFF5D5FEF), controller.onConfirmExtension, isGradient: true)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index, String gems, String time, {bool isFullWidth = false}) {
    return Expanded(
      flex: isFullWidth ? 0 : 1,
      child: Obx(() {
        bool isSelected = controller.selectedPlan.value == index;
        return GestureDetector(
          onTap: () => controller.selectedPlan.value = index,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: isFullWidth ? 180 : double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF5351FB).withOpacity(isSelected ? 0.8 : 0.4),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? Border.all(color: Colors.white, width: 1.5) : null,
                ),
                child: Center(
                  child: Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              // Gem Badge
              Positioned(
                top: -12,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9061F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.diamond, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(gems, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _actionBtn(String label, Color color, VoidCallback onTap, {bool isGradient = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isGradient ? null : color,
          gradient: isGradient ? const LinearGradient(colors: [Color(0xFF5D5FEF), Color(0xFF7E86FF)]) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }
}