import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../controller/ArenaController.dart';

class ArenaView extends GetView<ArenaController> {
  const ArenaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let GlobalBackground show through
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),

        title: Text(
          "Arena",
          style: AppText.h4.bold.copyWith(
            color: Colors.white,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. PINNED FILTER BAR - This stays visible
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverFilterBarDelegate(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF242260),
                        Color(0xFF3A385D),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildFilterBar(),
                ),
              ),
            ),
          ),

          // 2. SCROLLABLE HEADER TEXT (Trending Now / Top Polls)
          SliverToBoxAdapter(
            child: Obx(
              () => controller.selectedFilter.value == 3
                  ? _buildPollHeader()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Text(
                        "Trending Now",
                        style: AppText.h4.bold.copyWith(color: Colors.white),
                      ),
                    ),
            ),
          ),

          // 3. THE MAIN LIST
          Obx(() {
            final isPoll = controller.selectedFilter.value == 3;
            final itemCount = isPoll
                ? controller.topPolls.length
                : controller.trendingDebates.length;

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (isPoll) {
                    return _buildPollPostCard(controller.topPolls[index]);
                  }
                  return _buildDebateCard(controller.trendingDebates[index]);
                }, childCount: itemCount),
              ),
            );
          }),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  // ---------------- HEADER HELPERS ----------------

  Widget _buildPollHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Polls",
            style: AppText.h4.bold.copyWith(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                "All Time",
                style: AppText.body2().copyWith(color: Colors.white70),
              ),
              const Icon(Icons.arrow_right, color: Colors.white70),
            ],
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
          final filterItem = controller.filters[index];
          return Obx(() {
            bool isSelected = controller.selectedFilter.value == index;
            return GestureDetector(
              onTap: () => controller.selectedFilter.value = index,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColor.primaryScale.s600
                      : Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      filterItem['icon'] as IconData,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      filterItem['label'] as String,
                      style: AppText.body2().copyWith(color: Colors.white),
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

  // ---------------- POLL CARD COMPONENTS ----------------

  Widget _buildPollPostCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // Light background to match poll design
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0F8C94), width: 2),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(data['userImg']),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        data['user'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text("🇺🇦", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Text(
                    data['time'],
                    style: const TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            data['question'],
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data['description'],
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              data['pollImg'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.poll_outlined, size: 18, color: Colors.black38),
              const SizedBox(width: 4),
              Text(
                "${data['votes']} votes",
                style: const TextStyle(
                  color: Colors.black45,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _interactionIcon(Icons.favorite_border, data['likes']),
              _interactionIcon(Icons.repeat, data['shares']),
              _interactionIcon(Icons.chat_bubble_outline, data['comments']),
            ],
          ),
          const SizedBox(height: 16),
          _buildPollResult(data['disagree'], data['agree']),
        ],
      ),
    );
  }

  Widget _interactionIcon(IconData icon, String val) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black38),
          const SizedBox(width: 4),
          Text(
            val,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollResult(int disagree, int agree) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$disagree%",
                  style: const TextStyle(
                    color: Color(0xFFE91E63),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Disagree",
                  style: TextStyle(color: Color(0xFFE91E63), fontSize: 12),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$agree%",
                  style: const TextStyle(
                    color: Color(0xFF00B4D8),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Agree",
                  style: TextStyle(color: Color(0xFF00B4D8), fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                flex: disagree,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: agree,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00B4D8),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- DEBATE CARD COMPONENTS ----------------

  Widget _buildDebateCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 300,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF901C4C).withOpacity(0.95),
            const Color(0xFF0F8C94).withOpacity(0.95),
          ],
        ),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Opacity(
                  opacity: 0.15,
                  child: Image.network(data['p1']['img'], fit: BoxFit.cover),
                ),
              ),
              const VerticalDivider(width: 1, color: Colors.white10),
              Expanded(
                child: Opacity(
                  opacity: 0.15,
                  child: Image.network(data['p2']['img'], fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconLabel(Icons.remove_red_eye_outlined, data['views']),
                    _iconLabel(Icons.access_time, "${data['time']} min"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _avatar(
                      data['p1'],
                      const Color(0xFFFFCC00),
                      hasCrown: true,
                    ),
                    SvgPicture.asset(
                      AppAssets.war,
                      width: 45,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                    _avatar(data['p2'], const Color(0xFF00B4D8)),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: Color(0xFFA5B4FC),
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "TOPIC",
                      style: AppText.label.bold.copyWith(
                        color: const Color(0xFFA5B4FC),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Climate change requires immediate action",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                _buildPollBar(data['p1']['votes'], data['p2']['votes']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(
    Map<String, dynamic> user,
    Color ringColor, {
    bool hasCrown = false,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: 3),
              ),
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(user['img']),
              ),
            ),
            if (hasCrown)
              const Positioned(
                top: -15,
                right: -5,
                child: Text("👑", style: TextStyle(fontSize: 28)),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user['name'],
              style: AppText.body2.medium.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.person_add_alt_1_outlined,
              color: Colors.white70,
              size: 16,
            ),
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
            Text(
              "$v1% votes",
              style: AppText.label.bold.copyWith(
                color: const Color(0xFFE91E63),
              ),
            ),
            Text(
              "$v2% votes",
              style: AppText.label.bold.copyWith(
                color: const Color(0xFF00B4D8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
          child: Row(
            children: [
              Expanded(
                flex: v1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: v2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00B4D8),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconLabel(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppText.body2().copyWith(color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}

// ---------------- STICKY HEADER DELEGATE ----------------

class _SliverFilterBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _SliverFilterBarDelegate({required this.child});

  @override
  double get minExtent => 65.0; // Height of filter bar + padding
  @override
  double get maxExtent => 65.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
