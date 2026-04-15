import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_color.dart';
import '../../../core/values/app_text.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryGradient = const LinearGradient(
      colors: [Color(0xFF6366F1), Color(0xFF3730A3)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      // Set to transparent so the main.dart background is visible
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Obx(
                () => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // Deep navy with high opacity to look like the image
                color: const Color(0xFF1E1B4B).withOpacity(0.9),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  // --- CUSTOM TABS ---
                  _buildTabs(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      children: [
                        Text(
                          controller.isSignIn.value ? "Welcome" : "Create New Account",
                          style: AppText.h2.bold.copyWith(
                            color: const Color(0xFFC7D2FE),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.isSignIn.value
                              ? "Please enter your details to Sign In"
                              : "Please enter your details to Sign up.",
                          style: AppText.label.regular.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 32),

                        // --- DYNAMIC FORM FIELDS ---
                        if (!controller.isSignIn.value) ...[
                          _buildTextField(hint: "User Name", icon: Icons.person_outline),
                          const SizedBox(height: 16),
                        ],

                        _buildTextField(hint: "Email", icon: Icons.email_outlined),
                        const SizedBox(height: 16),

                        if (!controller.isSignIn.value) ...[
                          _buildTextField(
                            hint: "Birth Date",
                            icon: Icons.calendar_today_outlined,
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Password Field
                        _buildTextField(
                          hint: controller.isSignIn.value ? "Password" : "Set Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: controller.obscurePassword.value,
                          onSuffixTap: controller.togglePasswordVisibility,
                        ),

                        if (!controller.isSignIn.value) ...[
                          const SizedBox(height: 16),
                          _buildTextField(
                            hint: "Confirm Password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: controller.obscureConfirmPassword.value,
                            onSuffixTap: controller.toggleConfirmPasswordVisibility,
                          ),
                        ],

                        // Forgot Password (Only for Sign In)
                        if (controller.isSignIn.value)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: AppText.label.medium.copyWith(color: Colors.white60),
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // --- ACTION BUTTON ---
                        _buildGradientButton(
                          primaryGradient,
                          controller.isSignIn.value ? "Sign In" : "Sign Up",
                        ),

                        const SizedBox(height: 24),
                        _buildDivider(),
                        const SizedBox(height: 24),

                        // --- SOCIAL BUTTONS ---
                        Row(
                          children: [
                            Expanded(
                              child: _buildSocialButton(
                                "Google",
                                "assets/icons/google.png",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSocialButton(
                                "Apple",
                                "assets/icons/apple.png",
                                isApple: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildTabs() {
    return Row(
      children: [
        _tabItem(
          label: "Sign In",
          icon: Icons.login,
          isActive: controller.isSignIn.value,
          isLeft: true,
        ),
        _tabItem(
          label: "Sign Up",
          icon: Icons.person_add_alt,
          isActive: !controller.isSignIn.value,
          isLeft: false,
        ),
      ],
    );
  }

  Widget _tabItem({
    required String label,
    required IconData icon,
    required bool isActive,
    required bool isLeft,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.isSignIn.value = isLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isActive ? Colors.transparent : Colors.black38,
            borderRadius: isLeft
                ? const BorderRadius.only(
              topLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            )
                : const BorderRadius.only(
              topRight: Radius.circular(28),
              bottomLeft: Radius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isActive ? AppColor.primaryScale.s400 : Colors.white38),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColor.primaryScale.s400 : Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
  }) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Color(0xFF1E1B4B), fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9BA3AF)),
        prefixIcon: Icon(icon, color: const Color(0xFF9BA3AF), size: 20),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFF9BA3AF),
            size: 20,
          ),
          onPressed: onSuffixTap,
        )
            : null,
        filled: true,
        fillColor: const Color(0xFFE0E7FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildGradientButton(Gradient grad, String text) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(gradient: grad, borderRadius: BorderRadius.circular(12)),
      child: ElevatedButton(
        onPressed: () {
            Get.toNamed(AppRoutes.USER_BOTTOM_NAV);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(text, style: AppText.body1.bold.copyWith(color: Colors.white)),
      ),
    );
  }

  Widget _buildSocialButton(String label, String assetPath, {bool isApple = false}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF312E81).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            height: 22,
            color: isApple ? Colors.white : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.white10, endIndent: 10)),
        Text("Or continue with", style: AppText.label.regular.copyWith(color: Colors.white38)),
        const Expanded(child: Divider(color: Colors.white10, indent: 10)),
      ],
    );
  }
}