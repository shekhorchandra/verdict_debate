import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/values/app_assets.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../core/widgets/common_app_bar.dart';
import '../../../../../routes/app_routes.dart';
import '../controller/CreatePollController.dart';

class CreatePollView extends GetView<CreatePollController> {
  const CreatePollView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: CommonAppBar(
          backgroundColor: Colors.transparent,
          showBack: true,
          titleWidget: Text(
            "Create Poll",
            style: AppText.h4.semiBold.copyWith(color: Colors.white),
          ),
        ),

        body: Column(
          children: [
            const SizedBox(height: 10),

            _buildTopTabs(),

            const SizedBox(height: 10),

            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // COMMON POLL SECTION
                      _buildPollUI(),

                      // ONLY GO LIVE EXTRA SECTION
                      if (controller.selectedTab.value == 1) ...[

                        _buildLiveDuration(),

                        const SizedBox(height: 30),

                        _buildFindOpponentButton(),
                      ],

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== POLL CONTENT ====================

  Widget _buildPollUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerLabel("Poll Question", hasInfo: true),
        _subLabel("Ask a clear, engaging question."),
        const SizedBox(height: 15),

        _buildPollPreview(),

        const SizedBox(height: 30),
        _buildHeaderLabel("Add to your poll (Optional)", hasInfo: false),
        _subLabel("Add text, media or set a background."),
        const SizedBox(height: 20),

        _buildAddonRow(),
        const SizedBox(height: 30),

        _buildBoostSection(),
        const SizedBox(height: 30),

        Obx(() {
          if (controller.selectedTab.value == 0) {
            return _mainActionBtn("Post Poll", AppAssets.poll);
          }

          return const SizedBox();
        }),
      ],
    );
  }

  Widget _buildPollPreview() {
    return Center(
      child: SizedBox(
        height: 360,
        width: Get.width * 0.9,
        child: Obx(() {
          final mediaFile = controller.selectedMediaFile.value;
          final mediaType = controller.selectedMediaType.value;
          final hasMedia = mediaFile != null;

          /// ===============================
          /// IF MEDIA SELECTED: SHOW DIRECT MEDIA
          /// ===============================
          if (hasMedia) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    /// Image Preview
                    if (mediaType == "image")
                      Positioned.fill(
                        child: Image.file(mediaFile, fit: BoxFit.cover),
                      ),

                    /// Video Preview
                    if (mediaType == "video")
                      Positioned.fill(
                        child: LocalVideoPreview(videoFile: mediaFile),
                      ),

                    /// Dark overlay for readable text
                    Positioned.fill(
                      child: Container(color: Colors.black.withOpacity(0.25)),
                    ),

                    /// Caption / Poll Text
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          controller.pollText.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            height: 1.15,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Remove media button
                    Positioned(
                      top: 14,
                      right: 14,
                      child: GestureDetector(
                        onTap: controller.removeMedia,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          /// ===============================
          /// IF NO MEDIA: SHOW BACKGROUND COLOR SWIPE
          /// ===============================
          return PageView.builder(
            controller: controller.backgroundPageController,
            itemCount: controller.backgroundColors.length,
            onPageChanged: controller.updateIndicator,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: controller.backgroundColors[index],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    /// Poll Text
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Obx(
                          () => Text(
                            controller.pollText.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Background indicator dots
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.backgroundColors.length,
                            (i) {
                              final isActive =
                                  controller.currentPollIndicator.value == i;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: isActive ? 18 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isActive
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.55),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
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
      final bool isSelected = controller.selectedAddon.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectAddon(index);

          if (index == 0) {
            _showTextCaptionBottomSheet();
          }

          if (index == 1) {
            _showMediaPickerBottomSheet();
          }
        },
        child: Container(
          width: (Get.width - 64) / 3,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1B4B).withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? const Color(0xFF6366F1) : Colors.white10,
            ),
          ),
          child: Column(
            children: [
              icon is String
                  ? Text(
                      icon,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF6366F1)
                            : Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Icon(
                      icon,
                      color: isSelected
                          ? const Color(0xFF6366F1)
                          : Colors.white,
                      size: 24,
                    ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF6366F1) : Colors.white38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBoostSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        // --- ADD THIS ONTAP TO NAVIGATE ---
        onTap: () => Get.toNamed(AppRoutes.BOOST_POLL),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1B4B).withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                "Boost Poll",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white38,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainActionBtn(String text, String iconPath) {
    return GestureDetector(
      onTap: () {
        if (controller.selectedTab.value == 0) {
          // Poll action
          controller.handleAction();
        } else {
          // Go Live action
          controller.findOpponent();
        }
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),

        child: Container(
          width: double.infinity,
          height: 56,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),

            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                text,

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 16,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 10),

              SvgPicture.asset(
                iconPath,

                width: 20,

                height: 20,

                colorFilter: const ColorFilter.mode(
                  Colors.white,

                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderLabel(String text, {required bool hasInfo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasInfo)
            GestureDetector(
              onTap: _showTipsPopup,
              child: const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _subLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white38, fontSize: 13),
      ),
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
            color: const Color(0xFF3F3D79),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber, size: 22),
                  SizedBox(width: 12),
                  Text(
                    "Tips for a Great Poll",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _tipItem("Ask clear, thought-provoking questions"),
              _tipItem("Present a balanced argument"),
              _tipItem("Use media to support your point"),
              _tipItem("Keep it respectful and engaging"),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    "Got it",
                    style: TextStyle(color: Color(0xFF818CF8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _tipItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerLabel(String text, {required bool hasInfo}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (hasInfo)
            GestureDetector(
              onTap: _showTipsPopup,
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white38,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showTextCaptionBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF171530),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Write Poll Question",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: controller.pollTextController,
                maxLines: 4,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onTap: () {
                  controller.updatePollText(controller.pollTextController.text);
                  Get.back();
                },
                decoration: InputDecoration(
                  hintText: "Type your poll question...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF252348),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  controller.updatePollText(controller.pollTextController.text);
                  Get.back();
                },
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Apply Text",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showMediaPickerBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF171530),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Media",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _mediaOptionCard(
                    icon: Icons.image_outlined,
                    title: "Image",
                    onTap: () {
                      Get.back();
                      controller.pickImageFromGallery();
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _mediaOptionCard(
                    icon: Icons.videocam_outlined,
                    title: "Video",
                    onTap: () {
                      Get.back();
                      controller.pickVideoFromGallery();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _mediaOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: const Color(0xFF252348),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabs() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,

        decoration: BoxDecoration(
          color: const Color(0xff1E1B4B),
          borderRadius: BorderRadius.circular(14),
        ),

        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.changeTab(0);
                },

                child: Container(
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 0
                        ? const Color(0xff6366F1)
                        : Colors.transparent,

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Text(
                    "Poll",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.changeTab(1);
                },

                child: Container(
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 1
                        ? const Color(0xff6366F1)
                        : Colors.transparent,

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: const Text(
                    "Go Live",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveDuration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Live Duration",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            itemCount: controller.liveDurations.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),

            itemBuilder: (context, index) {
              final duration = controller.liveDurations[index];

              final isPro = controller.proDurations.contains(duration);

              return Obx(() {
                final selected = controller.selectedDuration.value == duration;

                return GestureDetector(
                  onTap: () {
                    controller.selectDuration(duration);
                  },

                  child: Stack(
                    clipBehavior: Clip.none,

                    children: [
                      Container(
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xff6366F1)
                              : const Color(0xff252348),

                          borderRadius: BorderRadius.circular(12),

                          border: Border.all(
                            color: selected
                                ? const Color(0xff818CF8)
                                : Colors.white10,
                          ),
                        ),

                        child: Text(
                          duration,

                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white60,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // PRO BADGE
                      if (isPro)
                        Positioned(
                          top: -6,
                          right: -6,

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xffffc107),

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: const Text(
                              "PRO",

                              style: TextStyle(
                                color: Colors.black,

                                fontSize: 8,

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFindOpponentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: GestureDetector(
        onTap: controller.findOpponent,

        child: Container(
          height: 56,

          width: double.infinity,

          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff6366F1), Color(0xff4F46E5)],
            ),

            borderRadius: BorderRadius.circular(16),
          ),

          child: const Center(
            child: Text(
              "Find Opponent",

              style: TextStyle(
                color: Colors.white,

                fontSize: 16,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LocalVideoPreview extends StatefulWidget {
  final File videoFile;

  const LocalVideoPreview({super.key, required this.videoFile});

  @override
  State<LocalVideoPreview> createState() => _LocalVideoPreviewState();
}

class _LocalVideoPreviewState extends State<LocalVideoPreview> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();

    videoController = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        videoController.setLooping(true);
        videoController.play();

        if (mounted) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (!videoController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: videoController.value.size.width,
        height: videoController.value.size.height,
        child: VideoPlayer(videoController),
      ),
    );
  }
}
