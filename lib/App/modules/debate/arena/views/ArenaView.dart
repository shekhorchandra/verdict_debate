import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../controller/ArenaController.dart';

class ArenaView extends GetView<ArenaController> {
  const ArenaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E28), // Dark indigo background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Arena", style: AppText.h4.bold.copyWith(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white, size: 28)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildFilterBar(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Trending Now", style: AppText.h4.bold.copyWith(color: Colors.white)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.trendingDebates.length,
              itemBuilder: (context, index) => _buildDebateCard(controller.trendingDebates[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.filters.length,
        itemBuilder: (context, index) {
          // Store the map item in a local variable to avoid repeat lookups
          final filterItem = controller.filters[index];

          return Obx(() {
            bool isSelected = controller.selectedFilter.value == index;
            return GestureDetector(
              onTap: () => controller.selectedFilter.value = index,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColor.primaryScale.s600 : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Accessing Map keys
                    Icon(filterItem['icon'] as IconData, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                        filterItem['label'] as String,
                        style: AppText.body2().copyWith(color: Colors.white)
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildDebateCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF901C4C).withOpacity(0.9), // Pink tint
            const Color(0xFF0F8C94).withOpacity(0.9), // Teal tint
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Face (Blurred)
          Opacity(
            opacity: 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network("https://i.pravatar.cc/500?u=bg", fit: BoxFit.cover, width: double.infinity),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconLabel(Icons.remove_red_eye_outlined, data['views']),
                    _iconLabel(Icons.access_time, data['time']),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _avatar(data['p1'], const Color(0xFFFF006E)),
                    const Icon(Icons.title, color: Colors.white38, size: 40), // VS Sword Icon
                    _avatar(data['p2'], const Color(0xFF00B4D8)),
                  ],
                ),
                const Spacer(),
                _buildPollBar(data['p1']['votes'], data['p2']['votes']),
                const SizedBox(height: 20),
                _buildWatchButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(Map<String, dynamic> user, Color ringColor) {
    bool isWinner = user['isWinner'];
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isWinner ? Colors.amber : ringColor, width: 3),
              ),
              child: CircleAvatar(radius: 35, backgroundImage: NetworkImage(user['img'])),
            ),
            if (isWinner)
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(Icons.workspace_premium, color: Colors.amber, size: 28), // Crown
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(user['name'], style: AppText.body2().copyWith(color: Colors.white70)),
            const SizedBox(width: 4),
            const Icon(Icons.person_add_alt, color: Colors.white38, size: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildPollBar(int v1, int v2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$v1% votes", style: AppText.label.bold.copyWith(color: const Color(0xFFFF006E))),
            Text("$v2% votes", style: AppText.label.bold.copyWith(color: const Color(0xFF00B4D8))),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(flex: v1, child: Container(height: 6, decoration: const BoxDecoration(color: Color(0xFFFF006E), borderRadius: BorderRadius.horizontal(left: Radius.circular(10))))),
            Expanded(flex: v2, child: Container(height: 6, decoration: const BoxDecoration(color: Color(0xFF00B4D8), borderRadius: BorderRadius.horizontal(right: Radius.circular(10))))),
          ],
        ),
      ],
    );
  }

  Widget _buildWatchButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4338CA)]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Watch The Debate", style: AppText.h5.bold.copyWith(color: Colors.white)),
          const SizedBox(width: 10),
          const Icon(Icons.title, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  Widget _iconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 6),
        Text(label, style: AppText.body2().copyWith(color: Colors.white70)),
      ],
    );
  }
}