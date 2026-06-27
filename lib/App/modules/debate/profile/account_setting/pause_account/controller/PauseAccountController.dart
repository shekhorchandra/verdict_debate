import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/values/app_text.dart';

class PauseAccountController extends GetxController {
  final TextEditingController confirmController = TextEditingController();

  // Observable to track if the input matches "YES"
  var canDelete = false.obs;

  void validateInput(String value) {
    canDelete.value = value.trim().toUpperCase() == "YES";
  }

  void onDeleteAccount() {
    if (canDelete.value) {
      Get.dialog(
        Dialog(
          backgroundColor: const Color(0xFF1E1B4B), // Dark navy background
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Warning Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_rounded, color: Colors.orange, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Note: Once your account is deleted, all your data will be permanently lost, including:",
                        style: AppText.body1.bold.copyWith(color: Colors.white, height: 1.3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Consequence List
                _bulletPoint("Your polls and debates"),
                _bulletPoint("Gift history and earnings"),
                _bulletPoint("Profile and personal settings"),

                const SizedBox(height: 30),

                // Action Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC7D2FE), // Light lavender/blue
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: AppText.body1.bold.copyWith(color: Colors.grey[700]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Confirm Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Final Logic
                          Get.offAllNamed('/auth');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 32),
      child: Text(
        "- $text",
        style: const TextStyle(color: Colors.white70, fontSize: 15),
      ),
    );
  }

  @override
  void onClose() {
    confirmController.dispose();
    super.onClose();
  }
}