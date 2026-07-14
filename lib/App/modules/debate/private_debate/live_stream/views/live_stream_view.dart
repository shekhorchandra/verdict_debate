import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/LiveStreamController.dart';


class LiveStreamView extends GetView<LiveStreamController> {
  const LiveStreamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Stack(
        children: [
          // 1. MAIN BACKGROUND VIDEO (Placeholder Image)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1595152772835-219674b2a8a6?w=800',
              fit: BoxFit.cover,
            ),
          ),

          // 2. PICTURE-IN-PICTURE (Top Left)
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24, width: 1),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 3. TIMER BADGE (Top Right)
          Positioned(
            top: 60,
            right: 20,
            child: _buildTimerBadge(),
          ),

          // 4. CENTER OVERLAY (Swipe Up Hint)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Swipe up for skip",
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.keyboard_double_arrow_up, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
          ),

          // 5. BOTTOM PROFILE & ACTION BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProfileRow(),
                const SizedBox(height: 20),
                _buildControlBar(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTimerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF7E86FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Obx(() => Text(
            controller.formattedTime, // Displays the live countdown
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Avatar
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF7E86FF), width: 2),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a'),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("@alexender145 🇬🇷",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Obx(() => Text("${controller.followerCount} Followers",
                    style: const TextStyle(color: Colors.white70, fontSize: 14))),
              ],
            ),
          ),
          // Follow Button
          Obx(() => GestureDetector(
            onTap: controller.toggleFollow,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF5E5CE6), Color(0xFF4C4AD9)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                controller.isFollowing.value ? "Following" : "Follow +",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2E42),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circleIcon(Icons.videocam_outlined, controller.toggleCamera),
          _circleIcon(Icons.volume_up_outlined, controller.toggleVolume),
          _circleIcon(Icons.mic_none_outlined, controller.toggleMic),
          _circleIcon(Icons.logout, controller.onExit, isExit: true),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap, {bool isExit = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isExit ? const Color(0xFFFF3B30) : Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}