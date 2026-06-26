import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/core/widgets/common_app_bar.dart';
import '../../../../../core/values/app_color.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../routes/app_routes.dart';
import '../controller/ProfileController.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set a dark background similar to the image
      backgroundColor: Colors.transparent, // Important for GlobalBackground
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile", style: TextStyle(color: Colors.white)),
        // 1. Language Changer instead of Back Button
        leadingWidth: 110,
        leading: Center(
          child: GestureDetector(
            onTap: () => _showLanguageDialog(context),
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.translate, size: 14, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    "English",
                    style: AppText.label().copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right,
                    size: 18,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildMainProfileCard(),
            const SizedBox(height: 20),

            // 2. Modified Action Rows (Messages/Arena and Gifts/Gems Shop)
            _buildActionRows(),

            const SizedBox(height: 20),
            _buildPremiumCard(),
            const SizedBox(height: 20),

            _buildSettingGroup([
              _settingTile(
                Icons.payment_outlined,
                "Payment Methods",
                onTap: () => Get.toNamed(AppRoutes.PAYMENT_METHOD),
              ),
              _settingTile(
                Icons.person_outline,
                "Account Settings",
                onTap: () => Get.toNamed(AppRoutes.ACCOUNT_SETTING),
              ),
              _settingTile(
                Icons.headset_mic_outlined,
                "Help & Support",
                onTap: () => Get.toNamed(AppRoutes.HELP_SUPPORT),
              ),
            ]),

            const SizedBox(height: 20),

            _buildSettingGroup([
              _settingTile(
                Icons.info_outline,
                "About Us",
                onTap: () => Get.toNamed(AppRoutes.ABOUT),
              ),
              _settingTile(
                Icons.shield_outlined,
                "Privacy Policy",
                onTap: () => Get.toNamed(AppRoutes.PRIVACY_POLICY),
              ),
              _settingTile(
                Icons.description_outlined,
                "Terms & Condition",
                onTap: () => Get.toNamed(AppRoutes.TERMS_CONDITION),
              ),
            ]),

            const SizedBox(height: 30),
            _buildLogoutButton(),
            const SizedBox(height: 130),
          ],
        ),
      ),
    );
  }

  // ---------------- MODIFIED ACTION ROWS ----------------

  Widget _buildActionRows() {
    return Column(
      children: [
        // Row 1: Large buttons with arrows
        Row(
          children: [
            _actionBtn(
              Icons.near_me_rounded,
              "Messages",
              hasArrow: true,
              onTap: () => Get.toNamed(AppRoutes.MESSAGES),
            ),
            const SizedBox(width: 12),
            _actionBtn(
              Icons.local_fire_department_rounded,
              "Arena",
              hasArrow: true,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Row 2: Smaller buttons
        Row(
          children: [
            _actionBtn(
              Icons.card_giftcard,
              "Gifts",
              onTap: () => Get.toNamed(AppRoutes.GIFT),
            ),
            const SizedBox(width: 12),
            _actionBtn(
              Icons.diamond_outlined,
              "Gems Shop",
              onTap: () => Get.toNamed(AppRoutes.GEMS_SHOP),
            ),
          ],
        ),
      ],
    );
  }

  Widget _actionBtn(
    IconData icon,
    String label, {
    bool hasArrow = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF252348), // Translucent indigo
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppText.label.bold.copyWith(color: Colors.white),
              ),
              if (hasArrow) ...[
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white38,
                  size: 12,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- EXISTING WIDGETS (STYLED) ----------------

  Widget _buildMainProfileCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.MY_PROFILE),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColor.primaryScale.s900.withOpacity(0.5),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF818CF8),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/tonoy.jpg'),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Obx(
                      () => Text(
                        controller.username.value,
                        style: AppText.body1.bold.copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statItem(controller.followers.value, "Followers"),
                _divider(),
                _statItem(controller.debatesWon.value, "Debates Won"),
                _divider(),
                _statItem(controller.polls.value, "Polls"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(value, style: AppText.h4.bold.copyWith(color: Colors.white)),
        Text(label, style: AppText.label().copyWith(color: Colors.white54)),
      ],
    );
  }

  Widget _divider() => Container(
    height: 1,
    width: 80,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: Colors.white10,
  );

  Widget _buildPremiumCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.PREMIUM_PLANS),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3B2D60), Color(0xFF6366F1)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: const [
            Icon(Icons.diamond, color: Color(0xFFC7D2FE), size: 30),
            SizedBox(width: 15),
            Text("Get Premium", style: TextStyle(color: Colors.white)),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252348).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingTile(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(
        title,
        style: AppText.body2.medium.copyWith(color: Colors.white),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.white38,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        ),
      ),
      child: ElevatedButton(
        onPressed: controller.logout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          "Log Out",
          style: AppText.body1.bold.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    // Implement language selection logic here
  }
}
