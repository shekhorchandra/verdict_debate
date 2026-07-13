import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/challenge_controller.dart';

class ChallengeView extends GetView<ChallengeController> {
  const ChallengeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Column(
        children: [
          // --- TOP SECTION ---
          Expanded(
            child: Stack(
              children: [
                // Background Image (Man)
                Positioned.fill(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=800',
                    fit: BoxFit.cover,
                  ),
                ),
                // Top Navigation/Status Overlay
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircleButton(
                          Icons.chevron_left,
                          controller.onBack,
                        ),
                        Row(
                          children: [
                            _buildCircleButton(Icons.people_outline, () {}),
                            const SizedBox(width: 8),
                            _buildTimerBadge(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Username Bottom Overlay
                _buildUsernameOverlay(
                  "@jamie_vardy 🇬🇧",
                  Alignment.bottomCenter,
                ),
                // Bottom Cyan Border line
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(height: 3, color: Colors.cyan),
                ),
              ],
            ),
          ),

          // --- MIDDLE TEXT BAR ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            width: double.infinity,
            color: const Color(0xFF0F0F1E),
            child: Obx(
              () => Text(
                controller.statement.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // --- BOTTOM SECTION ---
          Expanded(
            child: Stack(
              children: [
                // Background Image (Woman - Blurred)
                Positioned.fill(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=800',
                    fit: BoxFit.cover,
                  ),
                ),
                // Blur Effect
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black.withOpacity(0.1)),
                  ),
                ),
                // Top Pink Border line
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(height: 3, color: Colors.pinkAccent),
                ),
                // Username Top Overlay
                _buildUsernameOverlay("@you 🇫🇷", Alignment.topCenter),
                // Challenge Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: controller.showChallengePopup,

                    label: const Text(
                      "⚔️ Challenge",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF29E03),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Circular Buttons (Back/Users)
  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  // Helper Widget: 10 Min Timer Badge
  Widget _buildTimerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF8A8AFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: Colors.white, size: 18),
          const SizedBox(width: 4),
          Obx(
            () => Text(
              controller.timeRemaining.value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Username with shadow/gradient
  Widget _buildUsernameOverlay(String text, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
          ),
        ),
      ),
    );
  }
}
