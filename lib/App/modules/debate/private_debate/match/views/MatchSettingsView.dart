import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/MatchSettingsController.dart';

class MatchSettingsView extends GetView<MatchSettingsController> {
  const MatchSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Dark background
      body: Column(
        children: [
          // 1. Video Preview Area
          _buildVideoPreview(),

          // 2. Filter Buttons and Duration
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gender & Country Row
                  Row(
                    children: [
                      Flexible(
                        child: _filterBtn(
                          Icons.female,
                          controller.selectedGender,
                          controller.openGenderFilter,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: _filterBtn(
                          Icons.public,
                          controller.selectedCountry,
                          controller.openCountryFilter,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: const [
                      Icon(Icons.access_time, color: Colors.white54, size: 20),
                      SizedBox(width: 8),
                      Text("Duration", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Duration Grid
                  _buildDurationGrid(),

                  const SizedBox(height: 30),

                  // Action Button
                  _buildFindMatchBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPreview() {
    return SizedBox(
      height: Get.height * 0.58,
      child: Stack(
        children: [
          // Background Image (Live simulation)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6",
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(0, 0, 0, .25),
                          Color(0xFF0A091E),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),



          // Gem Balance
          Positioned(
            top: 50, right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF2E2C5C), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.diamond, color: Color(0xFF818CF8), size: 18),
                  const SizedBox(width: 6),
                  Obx(() => Text("${controller.gemBalance.value}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ),

          // Controls (Camera, Volume, Mic)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _iconCircle(Icons.videocam_outlined),
                  const SizedBox(width: 20),
                  _iconCircle(Icons.volume_up_outlined),
                  const SizedBox(width: 20),
                  _iconCircle(Icons.mic_none_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterBtn(
      IconData icon,
      RxString label,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF252348),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
                () => Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: Colors.white54,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    label.value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white54,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurationGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.durations.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (_, index) {
        final dur = controller.durations[index];
        final isPro = controller.proDurations.contains(dur);

        return Obx(() {
          final selected =
              controller.selectedDuration.value == dur;

          return GestureDetector(
            onTap: () => controller.selectDuration(dur),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xff3F3D79)
                        : const Color(0xff252348),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected
                          ? const Color(0xff818CF8)
                          : Colors.white10,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dur,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.white60,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (isPro)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffffc107),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "PRO",
                        style: TextStyle(
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
    );
  }

  Widget _buildFindMatchBtn() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color(0xff34306E),
            Color(0xff4C4690),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: controller.findMatch,
          child: const Center(
            child: Text(
              "Find A Match",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconCircle(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.35),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}