import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/LiveDebateController.dart';


class LiveDebateOwnView extends GetView<LiveDebateOwnController> {
  const LiveDebateOwnView({Key? key}) : super(key: key);

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
                _buildVideo('https://images.unsplash.com/photo-1552058544-f2b08422138a?w=600'), // Older man
                _buildTopOverlays(),
                _buildUserLabel("@you 🇫🇷", Alignment.bottomLeft),
                _buildScoreBadge("124", const Color(0xFF00E5FF), Alignment.bottomRight),
                _buildSectionBorder(Alignment.bottomCenter, const Color(0xFF00E5FF)),
              ],
            ),
          ),

          // 2. MIDDLE CONTROL PANEL
          _buildMiddlePanel(),

          // 3. BOTTOM VIDEO SECTION
          Expanded(
            child: Stack(
              children: [
                _buildVideo('https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=600'), // Younger man
                _buildUserLabel("@Joseph131 🇺🇸", Alignment.topLeft),
                _buildScoreBadge("458", Colors.pinkAccent, Alignment.topRight),
                _buildChatOverlay(),
                _buildReactionOverlay(),
                _buildBottomControls(),
                _buildSectionBorder(Alignment.topCenter, Colors.pinkAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Sub-Widgets ---

  Widget _buildVideo(String url) => Positioned.fill(
    child: Image.network(url, fit: BoxFit.cover),
  );

  Widget _buildTopOverlays() => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _glassBadge(Icons.group, controller.viewerCount.value),
          _timerBadge(),
        ],
      ),
    ),
  );

  Widget _buildMiddlePanel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          const Text("Climate change requires immediate action", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          const Text("Live Votes", style: TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("${controller.voteLeftPercent}%", style: const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.77,
                      minHeight: 6,
                      backgroundColor: Colors.pinkAccent,
                      color: const Color(0xFF00E5FF),
                    ),
                  ),
                ),
              ),
              Text("${controller.voteRightPercent}%", style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          _buildChallengeButton(),
        ],
      ),
    );
  }

  Widget _buildChallengeButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          label: const Text("⚔️ Challenges"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        Positioned(
          top: -5, right: -5,
          child: CircleAvatar(
            radius: 10, backgroundColor: Colors.red,
            child: Text("${controller.challengeNotifications}", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget _buildChatOverlay() {
    return Positioned(
      bottom: 80, left: 12,
      child: SizedBox(
        width: 220,
        height: 120,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.messages.length,
          itemBuilder: (context, i) {
            final m = controller.messages[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "${m['user']}: ", style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12)),
                    TextSpan(text: m['msg'], style: TextStyle(color: m['color'] == 'yellow' ? Colors.yellow : Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _circleControl(Icons.videocam),
            _circleControl(Icons.volume_up),
            _circleControl(Icons.mic),
            _circleControl(Icons.exit_to_app, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _circleControl(IconData icon, {Color color = Colors.white24}) =>
      CircleAvatar(backgroundColor: color, radius: 22, child: Icon(icon, color: Colors.white, size: 20));

  Widget _glassBadge(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white24)),
    child: Row(children: [Icon(icon, size: 14, color: Colors.white), Text(" $text", style: const TextStyle(color: Colors.white))]),
  );

  Widget _timerBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFF8A8AFF), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [const Icon(Icons.timer, size: 14, color: Colors.white), Text(" ${controller.timerText}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
  );

  Widget _buildUserLabel(String name, Alignment align) => Align(
    alignment: align,
    child: Padding(padding: const EdgeInsets.all(12), child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, shadows: [Shadow(blurRadius: 4)]))),
  );

  Widget _buildScoreBadge(String val, Color col, Alignment align) => Align(
    alignment: align,
    child: Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.show_chart, size: 14, color: Colors.white), Text(" $val", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
    ),
  );

  Widget _buildReactionOverlay() => const Positioned(
    right: 12, bottom: 80,
    child: Column(children: [Text("🥊", style: TextStyle(fontSize: 22)), Text("🔥", style: TextStyle(fontSize: 22)), Text("💪", style: TextStyle(fontSize: 22)), Text("⚡", style: TextStyle(fontSize: 22))]),
  );

  Widget _buildSectionBorder(Alignment alignment, Color color) => Align(
    alignment: alignment,
    child: Container(height: 3, color: color),
  );
}