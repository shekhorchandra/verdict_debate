import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/values/app_text.dart';
import '../controller/DeleteAccountController.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E28),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Are you sure you want to permanently delete your account?",
                      style: AppText.h3.bold.copyWith(color: Colors.white, height: 1.3),
                    ),
                    const SizedBox(height: 20),
                    _buildWarningSection(),
                    const SizedBox(height: 40),
                    Text(
                      "Type \"YES\" to proceed with account deletion.",
                      style: AppText.body2.medium.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    _buildConfirmationField(),
                    const SizedBox(height: 30),
                    _buildDeleteButton(),
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
          Text("Delete Account", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildWarningSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, color: Colors.white70, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "This action cannot be undone, and all your data will be lost.",
            style: AppText.label().copyWith(color: Colors.white70, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller.confirmController,
        onChanged: controller.validateInput,
        style: const TextStyle(color: Color(0xFF1E1B4B), fontWeight: FontWeight.w600),
        decoration: const InputDecoration(
          hintText: "YES",
          hintStyle: TextStyle(color: Colors.black26),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Obx(() {
      final bool isActive = controller.canDelete.value;
      return Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isActive
              ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)])
              : null,
          color: isActive ? null : Colors.white.withOpacity(0.1),
        ),
        child: ElevatedButton(
          onPressed: isActive ? controller.onDeleteAccount : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            "Delete Account",
            style: AppText.body1.bold.copyWith(
              color: isActive ? Colors.white : Colors.white24,
            ),
          ),
        ),
      );
    });
  }
}