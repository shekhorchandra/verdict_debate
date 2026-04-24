import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../controller/ProfileController.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E28), // Matches the dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Profile", style: AppText.h4.bold.copyWith(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildMainProfileCard(),
            const SizedBox(height: 20),
            _buildActionRow(),
            const SizedBox(height: 20),
            _buildPremiumCard(),
            const SizedBox(height: 20),
            _buildSettingGroup([
              _settingTile(Icons.payment_outlined, "Payment Methods"),
              _settingTile(Icons.person_outline, "Account Settings"),
              _settingTile(Icons.headset_mic_outlined, "Help & Support"),
            ]),
            const SizedBox(height: 20),
            _buildSettingGroup([
              _settingTile(Icons.info_outline, "About Us"),
              _settingTile(Icons.shield_outlined, "Privacy Policy"),
              _settingTile(Icons.description_outlined, "Terms & Condition"),
            ]),
            const SizedBox(height: 30),
            _buildLogoutButton(),
            const SizedBox(height: 200), // Space for Bottom Nav
          ],
        ),
      ),
    );
  }

  Widget _buildMainProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.primaryScale.s900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          // Avatar with Border
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF818CF8), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Obx(() => Text(controller.username.value, style: AppText.body1.bold.copyWith(color: Colors.white))),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white70),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Stats Column
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

  Widget _divider() => Container(height: 1, width: 80, color: Colors.white10, margin: const EdgeInsets.symmetric(vertical: 8));

  Widget _buildActionRow() {
    return Row(
      children: [
        _actionBtn(Icons.translate, "English", hasArrow: true),
        const SizedBox(width: 12),
        _actionBtn(Icons.card_giftcard, "Gifts"),
        const SizedBox(width: 12),
        _actionBtn(Icons.diamond_outlined, "Gems Shop"),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, {bool hasArrow = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(label, style: AppText.label.bold.copyWith(color: Colors.white)),
            if (hasArrow) const Icon(Icons.arrow_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF3B2D60), Color(0xFF6366F1)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.diamond, color: Color(0xFFC7D2FE), size: 30),
          const SizedBox(width: 15),
          Text("Get Premium", style: AppText.body1.bold.copyWith(color: Colors.white)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildSettingGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70, size: 22),
      title: Text(title, style: AppText.body2.medium.copyWith(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white38),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
      ),
      child: ElevatedButton(
        onPressed: controller.logout,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Text("Log Out", style: AppText.body1.bold.copyWith(color: Colors.white)),
      ),
    );
  }

}