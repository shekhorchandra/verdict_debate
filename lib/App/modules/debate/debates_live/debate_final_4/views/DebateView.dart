import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/DebateController.dart';

class DebateView extends GetView<DebateController> {
  const DebateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F24), // Dark Navy Background
      body: Column(
        children: [
          // --- 1. TOP VIDEO SECTION (Split 2 ways) ---
          Expanded(
            child: Row(
              children: [
                _buildVideoTile(
                  imageUrl:
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                  name: "@jamie_vardy 🇬🇧",
                  badgeValue: "124",
                  badgeColor: const Color(0xFF00B8D4), // Cyan
                  showBack: true,
                ),
                _buildVideoTile(
                  imageUrl:
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
                  name: "@liana216 🇨🇭",
                  badgeValue: "124",
                  badgeColor: const Color(0xFF00B8D4), // Cyan
                  isRightSide: true,
                ),
              ],
            ),
          ),

          // --- 2. MIDDLE VOTING & CHALLENGE SECTION ---
          _buildMiddleSection(),

          // --- 3. BOTTOM VIDEO SECTION (Split 2 ways) ---
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildBottomVideo(
                        imageUrl:
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
                        name: "@emily_watson11 🇺🇦",
                        stats: "458",
                        statsColor: Colors.pinkAccent,
                      ),
                    ),
                    Expanded(
                      child: _buildBottomVideo(
                        imageUrl:
                        "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400",
                        name: "@stuart133 🇯🇵",
                        stats: "124",
                        statsColor: const Color(0xFF00B8D4),
                      ),
                    ),
                  ],
                ),

                _buildChatInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Individual Video Stream Tile
  Widget _buildVideoTile({
    required String imageUrl,
    required String name,
    String? badgeValue,
    Color? badgeColor,
    bool showBack = false,
    bool isRightSide = false,
    bool topBorder = false,
  }) {
    return Expanded(
      child: Stack(
        children: [
          // Background Video/Image
          Positioned.fill(child: Image.network(imageUrl, fit: BoxFit.cover)),

          // Section Borders
          if (topBorder)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 3,
                color: badgeColor ?? Colors.transparent,
              ),
            ),
          if (!topBorder && !isRightSide)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 3,
                color: badgeColor ?? Colors.transparent,
              ),
            ),



          // Overlays
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left (Back button) or Top Right (Stats)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showBack)
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: controller.onBack,
                        ),
                      if (isRightSide) ...[
                        const Spacer(),
                        _glassBadge(Icons.group, controller.viewerCount.value),
                        const SizedBox(width: 6),
                        _timerBadge(),
                      ],
                    ],
                  ),

                  // Bottom Label & Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 4)],
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (badgeValue != null)
                        Row(
                          children: [
                            _statsBadge(badgeValue, badgeColor!),
                            const SizedBox(width: 8),
                            _giftButton(),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isRightSide && !topBorder)
            Positioned(
              right: 12,
              bottom: 80,
              child: Icon(
                Icons.volume_up,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    return Container(
      color: const Color(0xFF0F0F24),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Climate change requires immediate action",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Live Votes",
            style: TextStyle(color: Colors.grey, fontSize: 11),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.77,
                      minHeight: 6,
                      backgroundColor: Colors.pinkAccent,
                      color: const Color(0xFF00B8D4),
                    ),
                  ),
                ),
              ),
              const Text(
                "77%",
                style: TextStyle(
                  color: Color(0xFF00B8D4),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

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



  // UI Components
  Widget _statsBadge(String val, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        const Icon(Icons.show_chart, color: Colors.white, size: 14),
        Text(" $val", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );

  Widget _giftButton() => Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: const Color(0xFF3F51B5).withOpacity(0.7),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Icon(Icons.card_giftcard, color: Colors.white, size: 16),
  );

  Widget _timerBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFF7E86FF),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        const Icon(Icons.timer, color: Colors.white, size: 14),
        Text(
          " ${controller.timerText}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );

  Widget _glassBadge(IconData icon, String txt) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black38,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.white24),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 14),
        Text(" $txt", style: const TextStyle(color: Colors.white)),
      ],
    ),
  );


  Widget _buildBottomVideo({
    required String imageUrl,
    required String name,
    required String stats,
    required Color statsColor,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),

        // Dark overlay
        Container(
          color: Colors.black.withOpacity(.15),
        ),

        // Top border
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 3,
            color: statsColor,
          ),
        ),

        // Streamer Info
        // Streamer Info
        Positioned(
          top: 12,
          left: 10,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  _statsBadge(stats, statsColor),

                  const SizedBox(width: 8),

                  _giftButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
