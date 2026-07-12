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

        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),

        title: Text(
          "Settings",
          style: AppText.h4.bold.copyWith(
            color: Colors.white,
          ),
        ),

        actions: [
          GestureDetector(
            onTap: () => _showLanguageDialog(context),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.translate,
                    size: 14,
                    color: Colors.white70,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    "English",
                    style: AppText.label().copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),

                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),
        ],
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
              onTap: () => Get.toNamed(AppRoutes.AREANA),
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
              useGradient: false,
              onTap: () => Get.toNamed(AppRoutes.GIFT),
            ),
            const SizedBox(width: 12),
            _actionBtn(
              Icons.diamond_outlined,
              "Gems Shop",
              useGradient: false,
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
        bool useGradient = true,
        VoidCallback? onTap,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: useGradient ? null : const Color(0xFF252348),
            gradient: useGradient
                ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF44418B),
                Color(0xFF242260),

              ],
            )
                : null,
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
                  color: Colors.white,
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
      // onTap: () => Get.toNamed(AppRoutes.MY_PROFILE),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF242260),
              Color(0xFF44418B),
            ],
          ),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF383482),
              Color(0xFF4A216E),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF44418B),
            Color(0xFF242137),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Colors.white.withOpacity(0.12),
              ),
          ],
        ],
      ),
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
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF3730A3),
            Color(0xFF6366F1),
          ],
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
