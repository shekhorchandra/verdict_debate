import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_color.dart';
import '../../live/controller/DebatesController.dart';


class DebatesWaitingView extends GetView<DebatesController> {
  const DebatesWaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    // This view is now just the middle section of the screen
    return Column(
      children: [
        const Spacer(flex: 2),
        _buildVersusSection(),
        const SizedBox(height: 40),
        _buildTopicSection(),
        const Spacer(flex: 3),
        _buildFooter(),
      ],
    );
  }

  Widget _buildVersusSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text("VS", style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.15))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _avatarSlot("waiting...", null, const Color(0xFFFF006E)),
              _avatarSlot("Olivia_carter", 'https://i.pravatar.cc/150?u=olivia', const Color(0xFF00B4D8)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _avatarSlot(String label, String? url, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 3)),
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white10,
            backgroundImage: url != null ? NetworkImage(url) : null,
            child: url == null ? const Icon(Icons.person_outline, color: Colors.white, size: 40) : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildTopicSection() {
    return Column(
      children: [
        Text("⭐ TOPIC", style: TextStyle(color: Colors.indigo[100], letterSpacing: 1.2, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Climate change requires immediate action",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Text("🕒 15 min", style: TextStyle(color: Colors.white60, fontSize: 14)),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.warning,
            minimumSize: const Size(200, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text("⚔️ Challenge", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text("Swipe up for next", style: TextStyle(color: Colors.white54, fontSize: 12)),
        Icon(Icons.keyboard_arrow_down, color: Colors.white54),
      ],
    );
  }
}