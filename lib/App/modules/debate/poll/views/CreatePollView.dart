import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../../../../core/widgets/common_app_bar.dart';
import '../controller/CreatePollController.dart';

class CreatePollView extends GetView<CreatePollController> {
  const CreatePollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(
        backgroundColor: Colors.transparent,
        showBack: true,
        titleWidget: Obx(
          () => Text(
            controller.selectedTab.value == 0 ? "Create Poll" : "Go Live",
            style: AppText.h4.bold.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Obx(
          () => Card(
            color: const Color(0xFF818CF8).withOpacity(0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTabBar(),
                  const SizedBox(height: 10),

                  _buildLabel(
                    controller.selectedTab.value == 0 ? "Your Argument" : "Debate Argument",
                  ),

                  _buildArgumentField(),
                  _buildCharCounter(),

                  // const SizedBox(height: 10),
                  _buildLabel("Your Position"),
                  _buildPositionButtons(),

                  const SizedBox(height: 10),

                  controller.selectedTab.value == 0
                      ? _buildMediaSection()
                      : _buildDurationSection(),

                  const SizedBox(height: 20),

                  _buildTipsCard(),

                  const SizedBox(height: 20),

                  _buildActionButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildTabBar() {
    return Row(
      children: [
        _tabItem("Poll", AppAssets.poll, 0),
        _tabItem("Go Live", AppAssets.war, 1), // Placeholder for Sword Icon
      ],
    );
  }

  Widget _tabItem(String title, String iconPath, int index) {
    bool isActive = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isActive ? Colors.white : Colors.white38,
                    BlendMode.srcIn,
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  title,
                  style: AppText.h5().copyWith(color: isActive ? Colors.white : Colors.white38),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Container(height: 2, color: isActive ? AppColor.primaryScale.s300 : Colors.white10),
          ],
        ),
      ),
    );
  }

  Widget _buildArgumentField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller.textController,
        maxLines: 5,
        onChanged: controller.updateText,
        style: const TextStyle(color: Color(0xFF1E1B4B)),
        decoration: InputDecoration(
          hintText: controller.selectedTab.value == 0
              ? "Explain your position on this topic...."
              : "What will you debate about?",
          hintStyle: const TextStyle(color: Colors.black26),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            _buildLabel("Duration per opponent"),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
          ),
          itemCount: controller.durations.length,
          itemBuilder: (context, index) {
            String dur = controller.durations[index];
            bool isPro = controller.proDurations.contains(dur);
            return _durationBtn(dur, isPro);
          },
        ),
      ],
    );
  }

  Widget _durationBtn(String label, bool isPro) {
    return Obx(() {
      bool isSelected = controller.selectedDuration.value == label;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => controller.selectDuration(label),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryScale.s600 : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(label, style: AppText.body1.bold.copyWith(color: Colors.white)),
              ),
            ),
          ),
          if (isPro)
            Positioned(
              top: -8,
              right: -5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColor.warning,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "PRO",
                  style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildTipsCard() {
    bool isPoll = controller.selectedTab.value == 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF818CF8).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                isPoll ? "Tips for a Great Poll" : "Tips for a Great Debate",
                style: AppText.body2.bold.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isPoll) ...[
            _tipPoint("Ask clear, thought-provoking questions", 0),
            _tipPoint("Present a balanced argument", 1),
            _tipPoint("Use media to support your point", 2),
            _tipPoint("Keep it respectful and engaging", 3),
          ] else ...[
            _tipPoint("Choose a clear, debatable topic", 0),
            _tipPoint("Be respectful to your opponent", 1),
            _tipPoint("Present strong arguments", 2),
            _tipPoint("Engage with your audience", 3),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    bool isPoll = controller.selectedTab.value == 0;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF3730A3)]),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isPoll ? "Post Poll" : "Find Opponent & Start Debate",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 10),

            SvgPicture.asset(
              isPoll ? AppAssets.send : AppAssets.war,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE HELPERS (from previous implementation) ---
  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(text, style: AppText.body1.bold.copyWith(color: Colors.white)),
  );
  Widget _buildCharCounter() => Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        "${controller.argumentText.value.length}/${controller.selectedTab.value == 0 ? 150 : 15}",
        style: AppText.label().copyWith(color: Colors.white54),
      ),
    ),
  );
  Widget _buildPositionButtons() => Row(
    children: [
      _posBtn("Against", const Color(0xFFFF006E)),
      const SizedBox(width: 15),
      _posBtn("Support", const Color(0xFF00B4D8)),
    ],
  );
  Widget _posBtn(String label, Color color) {
    bool isSelected = controller.selectedPosition.value == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectPosition(label),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(label, style: AppText.body1.bold.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel("Add Media (Optional)"),
      Row(
        children: [
          _mediaBtn("Image", Icons.image_outlined, [
            const Color(0xFF6366F1),
            const Color(0xFF3730A3),
          ]),
          const SizedBox(width: 15),
          _mediaBtn("Video", Icons.videocam_outlined, [
            const Color(0xFF312E81),
            const Color(0xFF1E1B4B),
          ]),
        ],
      ),
    ],
  );
  Widget _mediaBtn(String l, IconData i, List<Color> g) => Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: g),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(i, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(l, style: AppText.body1.medium.copyWith(color: Colors.white)),
        ],
      ),
    ),
  );
  Widget _tipPoint(String text, int index) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${index + 1}.",
          style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Text(text, style: AppText.label().copyWith(color: Colors.white70)),
        ),
      ],
    ),
  );
}
