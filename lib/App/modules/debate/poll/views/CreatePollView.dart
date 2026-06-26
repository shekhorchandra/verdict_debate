import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_text.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../controller/CreatePollController.dart';

class CreatePollView extends GetView<CreatePollController> {
  const CreatePollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important for GlobalBackground
      appBar: CommonAppBar(
      backgroundColor: Colors.transparent,
      showBack: true,
      // Using titleWidget to handle the dynamic title from GetX controller
      titleWidget: Obx(() => Text(
        controller.selectedTab.value == 0 ? "Create Poll" : "Go Live",
        style: AppText.h4.semiBold.copyWith(color: Colors.white),
      )),
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCustomTabBar(),
            const SizedBox(height: 20),

            Obx(() {
              // --- SWITCH CONTENT HERE ---
              if (controller.selectedTab.value == 0) {
                return _buildPollUI(); // The Poll Preview Code
              } else {
                return _buildGoLiveUI(); // The Debate Settings Code
              }
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ==================== POLL TAB CONTENT (Grey Card) ====================

  Widget _buildPollUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerLabel("Poll Question", hasInfo: true),
        _subLabel("Ask a clear, engaging question."),
        const SizedBox(height: 15),

        // The Grey Preview Card
        _buildPollPreview(),

        const SizedBox(height: 30),
        _buildHeaderLabel("Add to your poll (Optional)", hasInfo: false),
        _subLabel("Add text, media or set a background."),
        const SizedBox(height: 20),

        _buildAddonRow(),
        const SizedBox(height: 30),

        _buildBoostSection(),
        const SizedBox(height: 30),

        _mainActionBtn("Post Poll", Icons.send_rounded),
      ],
    );
  }

  Widget _buildPollPreview() {
    return Center(
      child: Container(
        height: 360, width: Get.width * 0.9,
        decoration: BoxDecoration(color: const Color(0xFF71717A), borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Is Coffee\nyour go-to\nmorning fix?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900)
                  ),
                  SizedBox(height: 20),
                  Icon(Icons.coffee, color: Colors.white, size: 60),
                ],
              ),
            ),
            Positioned(
              bottom: 20, left: 0, right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8, height: 8,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: i == 0 ? const Color(0xFF6366F1) : Colors.white54),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _addonCard("Aa", "Text", 0),
          _addonCard(Icons.image_outlined, "Media", 1),
          _addonCard(Icons.grid_view_rounded, "Background", 2),
        ],
      ),
    );
  }

  Widget _addonCard(dynamic icon, String label, int index) {
    return Obx(() {
      bool isSelected = controller.selectedAddon.value == index;
      return GestureDetector(
        onTap: () => controller.selectAddon(index),
        child: Container(
          width: (Get.width - 64) / 3,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1B4B).withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isSelected ? const Color(0xFF6366F1) : Colors.white10),
          ),
          child: Column(
            children: [
              icon is String
                  ? Text(icon, style: TextStyle(color: isSelected ? const Color(0xFF6366F1) : Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
                  : Icon(icon, color: isSelected ? const Color(0xFF6366F1) : Colors.white, size: 24),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: isSelected ? const Color(0xFF6366F1) : Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      );
    });
  }

  // ==================== GO LIVE TAB CONTENT (Debate Settings) ====================

  Widget _buildGoLiveUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderLabel("Debate Argument", hasInfo: false),
          const SizedBox(height: 10),
          _buildDebateInput(),
          const SizedBox(height: 25),

          _buildHeaderLabel("Your Position", hasInfo: false),
          const SizedBox(height: 12),
          _buildPositionRow(),
          const SizedBox(height: 25),

          Row(children: const [Icon(Icons.access_time, color: Colors.white, size: 18), SizedBox(width: 8), Text("Duration per opponent", style: TextStyle(color: Colors.white))]),
          const SizedBox(height: 15),
          _buildDurationGrid(),
          const SizedBox(height: 25),

          _buildTipsCard(),
          const SizedBox(height: 25),

          _mainActionBtn("Find Opponent & Start Debate", Icons.bar_chart_rounded),
        ],
      ),
    );
  }

  Widget _buildDebateInput() {
    return Container(
      height: 140, padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(12)),
      child: const TextField(
        maxLines: 4, style: TextStyle(color: Colors.black),
        decoration: InputDecoration(hintText: "What will you debate about?", border: InputBorder.none),
      ),
    );
  }

  Widget _buildPositionRow() {
    return Row(
      children: [
        _posBtn("Against", const Color(0xFFFF006E), true),
        const SizedBox(width: 12),
        _posBtn("Support", const Color(0xFF00B4D8), false),
      ],
    );
  }

  Widget _posBtn(String text, Color color, bool isOutline) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isOutline ? Colors.transparent : color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2),
        ),
        child: Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  Widget _buildDurationGrid() {
    final list = ["10m", "15m", "30m", "45m", "60m", "75m"];
    return Wrap(
      spacing: 10, runSpacing: 12,
      children: list.map((dur) => _durItem(dur, ["30m","45m","60m","75m"].contains(dur))).toList(),
    );
  }

  Widget _durItem(String l, bool isPro) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: (Get.width - 64) / 3, height: 45,
          decoration: BoxDecoration(color: const Color(0xFF252348), borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(l, style: const TextStyle(color: Colors.white70))),
        ),
        if (isPro) Positioned(top: -5, right: -3, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)), child: const Text("PRO", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)))),
      ],
    );
  }

  // ==================== SHARED REUSABLE COMPONENTS ====================

  Widget _buildCustomTabBar() {
    return Obx(() => Row(
      children: [
        _tabItem("Poll", Icons.bar_chart_rounded, 0),
        _tabItem("Go Live", Icons.bar_chart_rounded, 1),
      ],
    ));
  }

  Widget _tabItem(String title, IconData icon, int index) {
    bool isActive = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, color: isActive ? const Color(0xFF818CF8) : Colors.white38, size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.white38, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 10),
            Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 10), color: isActive ? const Color(0xFF818CF8) : Colors.white10),
          ],
        ),
      ),
    );
  }

  Widget _buildBoostSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E1B4B).withOpacity(0.4), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.rocket_launch, color: Colors.white, size: 20)),
          const SizedBox(width: 15),
          const Text("Boost Poll", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 14),
        ]),
      ),
    );
  }

  Widget _mainActionBtn(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity, height: 56,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)])),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Icon(icon, color: Colors.white, size: 20),
        ]),
      ),
    );
  }

  Widget _buildHeaderLabel(String text, {required bool hasInfo}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        if (hasInfo)
          GestureDetector(
            onTap: () => _showTipsPopup(), // Trigger the popup
            child: const Padding(
              padding: EdgeInsets.all(4.0), // Padding to make it easier to click
              child: Icon(Icons.info_outline, color: Colors.white54, size: 20),
            ),
          ),
      ],
    );
  }

  Widget _subLabel(String t) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), child: Text(t, style: const TextStyle(color: Colors.white38, fontSize: 13)));

  Widget _buildTipsCard() {
    return Container(
      padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF252348), borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        Row(children: [Icon(Icons.lightbulb_outline, color: Colors.amber, size: 18), SizedBox(width: 8), Text("Tips for a Great Debate", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))]),
        SizedBox(height: 12),
        Text("• Choose a clear, debatable topic", style: TextStyle(color: Colors.white54, fontSize: 13)),
        Text("• Be respectful to your opponent", style: TextStyle(color: Colors.white54, fontSize: 13)),
        Text("• Present strong arguments", style: TextStyle(color: Colors.white54, fontSize: 13)),
        Text("• Engage with your audience", style: TextStyle(color: Colors.white54, fontSize: 13)),
      ]),
    );
  }

  void _showTipsPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF3F3D79), // Dark purple background from image
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Lightbulb
              Row(
                children: const [
                  Icon(Icons.lightbulb_outline, color: Colors.amber, size: 22),
                  SizedBox(width: 12),
                  Text(
                    "Tips for a Great Poll",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bullet points using a helper method
              _tipItem("Ask clear, thought-provoking questions"),
              _tipItem("Present a balanced argument"),
              _tipItem("Use media to support your point"),
              _tipItem("Keep it respectful and engaging"),

              const SizedBox(height: 20),

              // Optional: Close button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Got it", style: TextStyle(color: Color(0xFF818CF8))),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: true, // Close when tapping outside
    );
  }

// Helper to build individual bullet points
  Widget _tipItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerLabel(String t, {required bool hasInfo}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(t, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        if (hasInfo)
          GestureDetector(
            onTap: _showTipsPopup, // <--- Link to your function
            child: const Padding(
              padding: EdgeInsets.all(4.0), // Adds a larger touch area
              child: Icon(Icons.info_outline, color: Colors.white38, size: 20),
            ),
          ),
      ],
    ),
  );
}