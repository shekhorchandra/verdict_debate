import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/values/app_text.dart';
import '../controller/ChangePasswordController.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E28), // Dark background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildInputLabel("Current Password"),
                    _buildPasswordField(
                      controller: controller.currentPassController,
                      isObscured: controller.isCurrentObscured,
                      onToggle: controller.toggleCurrent,
                    ),
                    const SizedBox(height: 25),
                    _buildInputLabel("New Password"),
                    _buildPasswordField(
                      controller: controller.newPassController,
                      isObscured: controller.isNewObscured,
                      onToggle: controller.toggleNew,
                    ),
                    const SizedBox(height: 25),
                    _buildInputLabel("Confirm Password"),
                    _buildPasswordField(
                      controller: controller.confirmPassController,
                      isObscured: controller.isConfirmObscured,
                      onToggle: controller.toggleConfirm,
                    ),
                    const SizedBox(height: 40),
                    _buildSaveButton(),
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
          Text("Change Password", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(label, style: AppText.body1.medium.copyWith(color: Colors.white)),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required RxBool isObscured,
    required VoidCallback onToggle,
  }) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF), // Light lavender input bg
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscured.value,
        style: const TextStyle(color: Color(0xFF1E1B4B), fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: IconButton(
            icon: Icon(
              isObscured.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: const Color(0xFF9BA3AF),
              size: 22,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    ));
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        ),
      ),
      child: ElevatedButton(
        onPressed: controller.onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text("Save & Continue",
            style: AppText.body1.bold.copyWith(color: Colors.white)),
      ),
    );
  }
}