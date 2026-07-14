import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/WaitingController.dart';

class WaitingView extends GetView<WaitingController> {
  const WaitingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // --- TOP SECTION (User Preview) ---
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Background Image with Teal Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            const Color(0xFF00ACC1).withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildBackButton(),
                // Header Buttons
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight, // Positions the stack on the top right
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Takes only needed space
                        crossAxisAlignment: CrossAxisAlignment.end, // Aligns items to the right edge
                        children: [
                          // 1. Timer Badge on top
                          _timerBadge(),

                          const SizedBox(height: 12), // Vertical spacing

                          // 2. Circle Button (People icon) below it
                          _circleButton(Icons.group_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
                // Center Content (Avatar & Name)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.cyan, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.username.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("🇫🇷", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bottom Cyan Border
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(height: 3, color: Colors.cyan),
                ),
              ],
            ),
          ),

          // --- MIDDLE SECTION (Topic) ---
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            width: double.infinity,
            color: const Color(0xFF0F0F23),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.star, color: Colors.indigoAccent, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "TOPIC",
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  controller.topic.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // --- BOTTOM SECTION (Waiting Area) ---
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // ... your existing Gradient Container ...

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "?",
                        style: TextStyle(color: Colors.pinkAccent, fontSize: 80, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Waiting for Opponent...",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),

                      // --- ADDED TIMER HERE ---
                      const SizedBox(height: 15),
                      Obx(() => Text(
                        controller.formattedTime, // Displays 09:59, 09:58...
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      )),
                      // ------------------------

                      const SizedBox(height: 30),
                      // Your Challenge Button would go here
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---
  // Helper method inside your View class
  Widget _buildBackButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 10.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => controller.onBack(), // Call controller function
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3), // Semi-transparent black
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white10),
              ),
              child: const Icon(
                Icons.chevron_left, // iOS style back arrow
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _timerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF7E86FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        // --- ADD THIS LINE TO FIX FULL WIDTH ---
        mainAxisSize: MainAxisSize.min,

        children: [
          const Icon(Icons.timer_outlined, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Obx(() => Text(
            controller.timerValue.value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
