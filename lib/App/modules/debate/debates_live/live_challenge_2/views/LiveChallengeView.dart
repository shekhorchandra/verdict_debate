import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/routes/app_routes.dart';

import '../controller/LiveChallengeController.dart';

class LiveChallengeView extends GetView<LiveChallengeController> {
  const LiveChallengeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Column(
        children: [
          // 1. TOP VIDEO SECTION
          Expanded(
            child: Stack(
              children: [
                _buildVideoBg(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
                ),
                _buildTopHeader(),
                _buildSideMuteButton(),
                _buildUserOverlay(
                  name: "@jamie_vardy 🇬🇧",
                  voteCount: "124",
                  badgeColor: Colors.cyan[600]!,
                  isBottom: true,
                ),
                _buildSectionBorder(Alignment.bottomCenter, Colors.cyan),
              ],
            ),
          ),

          // 2. MIDDLE VOTING SECTION
          _buildVotingSection(),

          // 3. BOTTOM VIDEO SECTION
          Expanded(
            child: Stack(
              children: [
                _buildVideoBg(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
                ),
                _buildUserOverlay(
                  name: "@emily_watson11 🇺🇦",
                  voteCount: "458",
                  badgeColor: Colors.pinkAccent,
                  isBottom: false,
                ),
                _buildChatOverlays(),
                _buildReactionOverlay(),
                _buildChatInput(),
                _buildSectionBorder(Alignment.topCenter, Colors.pinkAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildVideoBg(String url) =>
      Positioned.fill(child: Image.network(url, fit: BoxFit.cover));

  Widget _buildTopHeader() => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: controller.onBack,
          ),
          const Spacer(),
          _buildGlassBadge(Icons.group, "452"),
          const SizedBox(width: 8),
          _buildTimerBadge(),
        ],
      ),
    ),
  );

  Widget _buildVotingSection() {
    return Container(
      color: const Color(0xFF0F0F1E),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Climate change requires immediate action",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Live Votes",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "23%",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.77,
                      minHeight: 6,
                      backgroundColor: Colors.pinkAccent,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              const Text(
                "77%",
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Inside your LiveChallengeView build method:
          Center(
            child: ElevatedButton.icon(
              onPressed: controller.LiveshowChallengePopup,

              label: const Text(
                "⚔️ Challenge",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF29E03),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserOverlay({
    required String name,
    required String voteCount,
    required Color badgeColor,
    required bool isBottom,
  }) {
    return Align(
      alignment: isBottom ? Alignment.bottomCenter : Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 4)],
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.show_chart,
                        size: 14,
                        color: Colors.white,
                      ),
                      Text(
                        " $voteCount",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildGiftButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatOverlays() {
    return Positioned(
      bottom: 90,
      left: 16,
      // --- STEP 1: Add SizedBox to bound the height ---
      child: SizedBox(
        height: 160, // Give it a specific maximum height
        width: 220, // Give it a width
        child: Obx(() {
          final chatMessages = controller.messages;

          return ListView.builder(
            padding: EdgeInsets.zero,
            reverse: true,
            itemCount: chatMessages.length,
            itemBuilder: (context, index) {
              final m = chatMessages[chatMessages.length - 1 - index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      shadows: [Shadow(blurRadius: 2)],
                    ),
                    children: [
                      TextSpan(
                        text: "${m['user']}: ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: m['msg'],
                        style: TextStyle(
                          color: m['color'] == 'yellow'
                              ? Colors.yellow
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildReactionOverlay() {
    return const Positioned(
      right: 12,
      bottom: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("🥊", style: TextStyle(fontSize: 24)),
          Text("⚡", style: TextStyle(fontSize: 24)),
          Text("💪", style: TextStyle(fontSize: 24)),
          Text("👑", style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "Join The Chat",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Icons ---
  Widget _buildGlassBadge(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white24),
    ),
    child: Row(
      children: [
        Icon(icon, size: 14, color: Colors.white),
        Text(" $text", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _buildTimerBadge() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF8A8AFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.timer, size: 14, color: Colors.white),

            Text(
              " ${controller.timerText.value}",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftButton() => GestureDetector(
    onTap: () => controller.showGiftBottomSheet(),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.indigo[800]?.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.card_giftcard, color: Colors.white, size: 20),
    ),
  );

  Widget _buildSideMuteButton() => Positioned(
    right: 12,
    top: 120,
    child: CircleAvatar(
      backgroundColor: Colors.black26,
      child: const Icon(Icons.volume_up, color: Colors.white, size: 20),
    ),
  );

  Widget _buildSectionBorder(Alignment alignment, Color color) => Align(
    alignment: alignment,
    child: Container(height: 3, color: color),
  );
}

class GiftBottomSheet extends GetView<LiveChallengeController> {
  const GiftBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFF2E2B5F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 20),

              // Header
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send a Gift",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Gifts go directly to the debater's earnings",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.sync, color: Colors.white),

                  const SizedBox(width: 12),

                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Gift Grid
              Obx(() {
                final selectedIndex = controller.selectedGiftIndex.value;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),

                  itemCount: controller.gifts.length,

                  itemBuilder: (context, index) {
                    final gift = controller.gifts[index];

                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () => controller.selectGift(index),

                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5D5FEF)
                              : const Color(0xFF3F418E),

                          borderRadius: BorderRadius.circular(16),

                          border: isSelected
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              gift.count,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),

                            Text(
                              gift.icon,
                              style: const TextStyle(fontSize: 32),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              gift.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),

              const SizedBox(height: 24),

              // Send Button
              Obx(() {
                final selectedIndex = controller.selectedGiftIndex.value;
                final selectedGift = controller.gifts[selectedIndex];

                return SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.sendGift();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5D5FEF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send ${selectedGift.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.card_giftcard, size: 20),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
