import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_color.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/DebatesController.dart';

class DebatesLiveNowView extends GetView<DebatesController> {
  const DebatesLiveNowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Subtle background face image (Low opacity to blend with parent gradient)
        Opacity(
          opacity: 0.15,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/800?u=bg_face'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80), // Offset for the fixed Top Nav
              _buildLiveHeader(),
              const Spacer(flex: 2),
              _buildMatchupSection(),
              const SizedBox(height: 40),
              _buildTopicSection(),
              const Spacer(flex: 3),
              _buildFooter(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // "LIVE NOW" Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B3B), // Bright Red
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, color: Colors.white, size: 8),
                const SizedBox(width: 8),
                Text("LIVE NOW",
                    style: AppText.label.bold.copyWith(color: Colors.white, letterSpacing: 0.5)),
              ],
            ),
          ),
          // Viewers Count (Glassmorphism effect)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white24),
              color: Colors.white.withOpacity(0.1),
            ),
            child: Row(
              children: [
                const Icon(Icons.group_outlined, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text("452", style: AppText.label.medium.copyWith(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchupSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Large Background "VS"
        Text(
          "VS",
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.15),
          ),
        ),
        // Avatars
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _userAvatar('ronan_debates', const Color(0xFFFF006E), 'https://i.pravatar.cc/150?u=1'),
              _userAvatar('emily_watson11', const Color(0xFF00B4D8), 'https://i.pravatar.cc/150?u=2'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userAvatar(String name, Color ringColor, String url) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: 3),
          ),
          child: CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(url),
          ),
        ),
        const SizedBox(height: 12),
        Text(name, style: AppText.body2().copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildTopicSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // TOPIC line design
          Row(
            children: [
              Expanded(child: Container(height: 1, color: Colors.white24)),
              const SizedBox(width: 10),
              const Icon(Icons.star, color: Color(0xFF818CF8), size: 22),
              const SizedBox(width: 6),
              Text(
                "TOPIC",
                style: AppText.label.bold.copyWith(color: const Color(0xFF818CF8), letterSpacing: 2),
              ),
              const SizedBox(width: 10),
              Expanded(child: Container(height: 1, color: Colors.white24)),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Climate change requires immediate action",
            textAlign: TextAlign.center,
            style: AppText.h4.bold.copyWith(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text("15 min", style: AppText.body1().copyWith(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 35),
          // "Join Live" Neon Green Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12D157),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: const StadiumBorder(), // Pill shape
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow_rounded, size: 28),
                const SizedBox(width: 8),
                Text("Join Live", style: AppText.h5.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Text("Swipe up for next", style: AppText.body2().copyWith(color: Colors.white70)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.15),
          ),
          child: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}