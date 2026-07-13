import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/live_debate_controller.dart';

class LiveDebateView extends GetView<LiveDebateController> {
  const LiveDebateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23), // Dark Navy
      body: Column(
        children: [
          // --- TOP SECTION (Two side-by-side) ---
          Expanded(
            flex: 4,
            child: Row(
              children: [
                _buildStreamerTile(
                  imageUrl:
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                  name: "@jamie_vardy 🇬🇧",
                  stats: "124",
                  statsColor: const Color(0xFF00ACC1),
                  hasBack: true,
                ),
                _buildStreamerTile(
                  imageUrl:
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
                  name: "@liana216 🇨🇭",
                  stats: "124",
                  statsColor: const Color(0xFF00ACC1),
                  hasBack: true,
                ),
              ],
            ),
          ),

          // --- MIDDLE SECTION (Voting & Info) ---
          _buildMiddleSection(),

          // --- BOTTOM SECTION (Large Single View) ---
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                // Background Video Image
                Positioned.fill(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800',
                    fit: BoxFit.cover,
                  ),
                ),
                // Top Border
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(height: 3, color: Colors.pinkAccent),
                ),
                // Streamer Info
                _buildStreamerOverlay(
                  name: "@emily_watson11 🇺🇦",
                  stats: "458",
                  statsColor: Colors.pinkAccent,
                ),
                // Chat Input
                _buildChatInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Individual streamer tile for the top row
  Widget _buildStreamerTile({
    required String imageUrl,
    required String name,
    String? stats,
    Color? statsColor,
    bool hasBack = false,
    bool isRightSide = false,
  }) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),
          if (hasBack)
            Positioned(
              top: 50,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: controller.onBack,
              ),
            ),

          if (isRightSide) ...[
            Positioned(
              top: 50,
              right: 16,
              child: Row(
                children: [
                  _glassBadge(
                    Icons.people_outline,
                    controller.viewerCount.value,
                  ),
                  const SizedBox(width: 8),
                  _timerBadge(),
                ],
              ),
            ),
            Positioned(
              top: 140,
              right: 16,
              child: Icon(
                Icons.volume_up,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],

          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (!isRightSide)
                  Row(
                    children: [
                      _statsBadge(stats!, statsColor!),
                      const SizedBox(width: 8),
                      _giftButton(),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Container(
      color: const Color(0xFF0F0F23),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
              Text(
                "${controller.voteAPercent}%",
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.77,
                      minHeight: 6,
                      backgroundColor: Colors.pinkAccent,
                      color: const Color(0xFF00ACC1),
                    ),
                  ),
                ),
              ),
              Text(
                "${controller.voteBPercent}%",
                style: const TextStyle(
                  color: Color(0xFF00ACC1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: controller.LiveDebateshowChallengePopup,

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

  Widget _buildStreamerOverlay({
    required String name,
    required String stats,
    required Color statsColor,
  }) {
    return Positioned(
      top: 12,
      left: 12,
      right: 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              _statsBadge(stats, statsColor),
              const SizedBox(width: 8),
              _giftButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
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
                color: const Color(0xFF5C6BC0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // --- Common UI Components ---
  Widget _statsBadge(String value, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const Icon(Icons.show_chart, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _giftButton() => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFF3F51B5).withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Icon(Icons.card_giftcard, color: Colors.white, size: 18),
  );

  Widget _glassBadge(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white24),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 14),
        Text(" $text", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _timerBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFF7E86FF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        const Icon(Icons.timer, color: Colors.white, size: 14),
        Obx(
          () => Text(
            " ${controller.timerValue}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
