import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:verdict_debate/App/core/values/app_assets.dart';
import '../../../../../core/values/app_color.dart';
import '../../../../../core/values/app_text.dart';
import '../../../../../routes/app_routes.dart';
import '../controller/MyProfileController.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderCard(),
                    const SizedBox(height: 20),
                    _buildCustomTabBar(),
                    const SizedBox(height: 20),

                    // REACTIVE BODY CONTENT
                    Obx(() {
                      switch (controller.selectedTab.value) {
                        case 0:
                          return _buildPollsTab();
                        case 1:
                          return _buildDebatesTab();
                        case 2:
                          return _buildRepostsTab();
                        default:
                          return const SizedBox();
                      }
                    }),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TOP NAVIGATION ---
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                "Profile",
                style: AppText.h5.bold.copyWith(color: Colors.white),
              ),
            ),

            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.PROFILE),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- USER HEADER CARD ---
  Widget _buildHeaderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFF242260), Color(0xFF44418B)],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF818CF8), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/tonoy.jpg'),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tonoy_Saha",
                          style: AppText.h4.bold.copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Text("🇧🇩", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: controller.editProfile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF6366F1), Color(0xFF3730A3)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Edit Profile",
                              style: AppText.label.bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    color: Colors.white70,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Free",
                    style: AppText.label().copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 25, thickness: 1.3, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _headerStat("3455", "Followers"),
              _headerStat("134", "Devates Won"),
              _headerStat("86", "Polls"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppText.h4.bold.copyWith(color: Colors.white)),
        Text(label, style: AppText.label().copyWith(color: Colors.white54)),
      ],
    );
  }

  // --- TAB BAR ---
  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF1E1B4B).withOpacity(0.8),
            width: 1,
          ),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _tabItem("Polls", AppAssets.poll, 0),
            _tabItem("Debates", AppAssets.war, 1),
            _tabItem("Reposts", AppAssets.repost, 2),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title, String iconPath, int index) {
    bool isActive = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isActive ? Colors.white : Colors.white38,
                    BlendMode.srcIn,
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  title,
                  style: AppText.h5().copyWith(
                    color: isActive ? Colors.white : Colors.white38,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Container(
              height: 2,
              color: isActive ? const Color(0xFF6366F1) : Colors.white10,
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: POLLS ---
  Widget _buildPollsTab() {
    return Column(children: [_sectionHeader("My Polls"), _buildPollCard()]);
  }

  Widget _buildPollCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _pollStat(
                Icons.poll_outlined,
                "3,420 votes",
                const Color(0xFFFF006E),
              ),
              const SizedBox(width: 15),
              _pollStat(
                Icons.favorite_outline,
                "1655",
                const Color(0xFFFF006E),
              ),
              const SizedBox(width: 15),
              _pollStat(
                Icons.chat_bubble_outline,
                "32",
                const Color(0xFFFF006E),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _miniProfileHeader("Tonoy_Saha", "Ends 1 week ago", isDark: false),
          const SizedBox(height: 15),
          Text(
            "Should remote work be the default for tech companies?",
            style: AppText.h4.bold.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            "Remote work increases productivity and work-life balance...",
            style: AppText.body2().copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB 2: DEBATES ---
  Widget _buildDebatesTab() {
    return Column(
      children: [
        _sectionHeader("My Debates"),
        _buildDebateMatchCard(isWinner: true),
        _buildDebateMatchCard(isWinner: false),
      ],
    );
  }

  Widget _buildDebateMatchCard({required bool isWinner}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF5A1435), Color(0xFF0F4D52)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _iconLabel(Icons.remove_red_eye_outlined, "125.7k"),
              _iconLabel(Icons.access_time, "30 min"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _matchAvatar("jamie_vardy", isWinner, const Color(0xFFFF006E)),
              SvgPicture.asset(
                AppAssets.war,
                width: 45,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              _matchAvatar(
                "emily_watson11",
                !isWinner,
                const Color(0xFF00B4D8),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Color(0xFF818CF8), size: 14),
              SizedBox(width: 5),
              Text(
                "TOPIC",
                style: TextStyle(
                  color: Color(0xFF818CF8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            "Climate change requires immediate action",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          _matchPollBar(39, 61),
          const SizedBox(height: 20),
          _watchButton(),
        ],
      ),
    );
  }

  // --- TAB 3: REPOSTS ---
  Widget _buildRepostsTab() {
    return Column(children: [_sectionHeader("My Reposts"), _buildRepostCard()]);
  }

  Widget _buildRepostCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Tonoy_Saha", style: AppText.body1.bold),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.repeat,
                          color: Color(0xFF6366F1),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "reposted",
                          style: AppText.label().copyWith(
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "1 day ago",
                      style: AppText.label().copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Remote work increases productivity and work-life balance...",
            style: AppText.body2(),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _miniProfileHeader(
                  "@zara_debates",
                  "Ends 1 week ago",
                  isDark: false,
                ),
                const SizedBox(height: 10),
                Text(
                  "Should remote work be the default for tech companies?",
                  style: AppText.body2.bold,
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://i.pravatar.cc/400?u=post',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 15),
                _fullWidthButton("View Discussion"),
              ],
            ),
          ),
          const SizedBox(height: 15),
          _repostFooter(),
        ],
      ),
    );
  }

  // --- SHARED REUSABLE COMPONENTS ---
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppText.h4.bold.copyWith(color: Colors.white)),
          const Row(
            children: [
              Text(
                "All",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Icon(Icons.arrow_right, color: Colors.white54),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconLabel(IconData icon, String label) => Row(
    children: [
      Icon(icon, color: Colors.white70, size: 14),
      const SizedBox(width: 5),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ],
  );

  Widget _matchPollBar(int d, int a) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$d% votes",
            style: const TextStyle(
              color: Color(0xFFFF006E),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$a% votes",
            style: const TextStyle(
              color: Color(0xFF00B4D8),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Row(
        children: [
          Expanded(
            flex: d,
            child: Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFFF006E),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
              ),
            ),
          ),
          Expanded(
            flex: a,
            child: Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF00B4D8),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _miniProfileHeader(String user, String time, {bool isDark = true}) =>
      Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: AppText.label.bold.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  time,
                  style: AppText.label().copyWith(
                    color: Colors.grey,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _fullWidthButton(String label) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6366F1), Color(0xFF3730A3)],
      ),
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  );

  Widget _repostFooter() => Row(
    children: [
      const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
      const SizedBox(width: 5),
      const Text("1.1k", style: TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(width: 15),
      const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
      const SizedBox(width: 5),
      const Text("32", style: TextStyle(color: Colors.grey, fontSize: 12)),
      const Spacer(),
      const Text(
        "View Comments",
        style: TextStyle(
          color: Color(0xFF6366F1),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xFF6366F1)),
    ],
  );

  Widget _pollStat(IconData icon, String label, Color color) => Row(
    children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(width: 5),
      Text(label, style: AppText.label.bold.copyWith(color: color)),
    ],
  );

  Widget _matchAvatar(String name, bool isWinner, Color ring) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isWinner ? Colors.amber : ring,
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
              ),
            ),
            if (isWinner)
              const Icon(
                Icons.workspace_premium,
                color: Colors.amber,
                size: 20,
              ),
          ],
        ),
        const SizedBox(height: 5),
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _watchButton() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6366F1), Color(0xFF3730A3)],
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Watch The Debate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          AppAssets.debate,
          height: 16,
          width: 16,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ],
    ),
  );
}
