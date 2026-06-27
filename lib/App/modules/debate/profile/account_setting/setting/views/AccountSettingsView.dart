import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/values/app_text.dart';
import '../controller/AccountSettingsController.dart';

class AccountSettingsView extends GetView<AccountSettingsController> {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important for GlobalBackground
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
                    _buildInputLabel("User Name"),
                    _buildSettingsField(
                      controller: controller.usernameController,
                      showEditIcon: true,
                    ),
                    const SizedBox(height: 25),
                    _buildInputLabel("Email"),
                    _buildSettingsField(
                      controller: controller.emailController,
                      showEditIcon: false, // Matches image
                      isReadOnly: true,
                    ),
                    const SizedBox(height: 25),
                    _buildInputLabel("Birth Date"),
                    _buildSettingsField(
                      controller: controller.dobController,
                      showEditIcon: true,
                    ),
                    const SizedBox(height: 30),
                    _buildActionLinks(),
                    const SizedBox(height: 100), // Space for bottom nav
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
          Text("Account Settings", style: AppText.h5.bold.copyWith(color: Colors.white)),
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

  Widget _buildSettingsField({
    required TextEditingController controller,
    bool showEditIcon = false,
    bool isReadOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF), // Light blue/white input background
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        style: const TextStyle(color: Color(0xFF1E1B4B), fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: showEditIcon
              ? const Icon(Icons.edit_outlined, color: Color(0xFF1E1B4B), size: 22)
              : null,
        ),
      ),
    );
  }

  Widget _buildActionLinks() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF050514),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          _actionLinkTile(
            icon: Icons.key_outlined,
            title: "Change Password",
            onTap: controller.changePassword,
          ),

          _actionDivider(),

          _actionLinkTile(
            icon: Icons.person_outline,
            title: "Pause Account",
            onTap: controller.pauseAccount,
          ),

          _actionDivider(),

          _actionLinkTile(
            icon: Icons.do_not_disturb_alt_outlined,
            title: "Delete Account",
            onTap: controller.deleteAccount,
          ),
        ],
      ),
    );
  }

  Widget _actionLinkTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF818CF8),
              size: 22,
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF818CF8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF818CF8),
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withOpacity(0.12),
    );
  }
}