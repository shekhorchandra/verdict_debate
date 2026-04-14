import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_color.dart';
import '../../../../core/values/app_text.dart';
import '../controller/explore_details_controller.dart';


class DebateDetailView extends GetView<DebateDetailController> {
  const DebateDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1029),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopNavigation(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHandle(),
                          _buildProfileHeader(),
                          const SizedBox(height: 15),
                          _buildTimeSection(),
                          const SizedBox(height: 15),
                          _buildMainImage(),
                          const SizedBox(height: 20),
                          _buildContentBody(),
                          const SizedBox(height: 25),
                          _buildActionButtons(),
                          const SizedBox(height: 15),
                          _buildPollBar(),
                          const SizedBox(height: 15),
                          _buildVotingInsights(),
                          const SizedBox(height: 20),
                          _buildCommentBox(),
                          const SizedBox(height: 25),
                          _buildDiscussionHeader(),
                          _buildCommentsList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
          const SizedBox(width: 5),
          Text("For you", style: AppText.h5.bold.copyWith(color: Colors.white)),
          Container(
            height: 20,
            width: 1,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
          const Icon(Icons.person_outline, color: Colors.white54, size: 18),
          const SizedBox(width: 5),
          Text("Following", style: AppText.h5().copyWith(color: Colors.white54)),
          const Spacer(),
          const Icon(Icons.notifications_none, color: Color(0xFF818CF8), size: 28),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 40,
        height: 5,
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        const CircleAvatar(radius: 25, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=zara')),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@zara_debates", style: AppText.h5.bold),
              Text("3.3k followers", style: AppText.label().copyWith(color: Colors.grey)),
            ],
          ),
        ),
        Obx(() => ElevatedButton(
          onPressed: controller.toggleFollow,
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.isFollowing.value ? Colors.grey[200] : AppColor.primary,
            foregroundColor: controller.isFollowing.value ? Colors.black : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: Text(controller.isFollowing.value ? "Following" : "+ Follow"),
        )),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Starts 2h ago", style: AppText.body2().copyWith(color: Colors.grey)),
        Text("Ends: 05/04/2026", style: AppText.body2().copyWith(color: Colors.grey)),
      ],
    );
  }

  Widget _buildMainImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=800&q=80',
        height: 180, width: double.infinity, fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Should remote work be the default for tech companies?", style: AppText.h4.bold),
        const SizedBox(height: 10),
        Obx(() => Text(
          "Remote work has become increasingly popular, offering benefits for both employees and organizations. It boosts productivity by allowing individuals to work in comfortable environments. It also improves work-life balance...",
          maxLines: controller.isDescriptionExpanded.value ? 20 : 3,
          overflow: TextOverflow.ellipsis,
          style: AppText.body2().copyWith(color: Colors.grey[700], height: 1.5),
        )),
        GestureDetector(
          onTap: controller.toggleDescription,
          child: Text(
            controller.isDescriptionExpanded.value ? "See less" : "See more....",
            style: AppText.body2.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const Center(child: Text("What's your take?", style: TextStyle(fontSize: 12, color: Colors.grey))),
        const SizedBox(height: 12),
        Row(
          children: [
            _voteBtn("Disagree", Icons.thumb_down_alt_outlined, const Color(0xFFFF006E)),
            const SizedBox(width: 15),
            _voteBtn("Agree", Icons.thumb_up_alt_outlined, const Color(0xFF00B4D8)),
          ],
        ),
      ],
    );
  }

  Widget _voteBtn(String label, IconData icon, Color color) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.onVote(label == "Agree"),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPollBar() {
    return Obx(() => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${controller.disagreePercent}%", style: AppText.label.bold.copyWith(color: const Color(0xFFFF006E))),
            Text("${controller.agreePercent}%", style: AppText.label.bold.copyWith(color: const Color(0xFF00B4D8))),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(flex: controller.disagreePercent.value, child: Container(height: 8, decoration: const BoxDecoration(color: Color(0xFFFF006E), borderRadius: BorderRadius.horizontal(left: Radius.circular(10))))),
            Expanded(flex: controller.agreePercent.value, child: Container(height: 8, decoration: const BoxDecoration(color: Color(0xFF00B4D8), borderRadius: BorderRadius.horizontal(right: Radius.circular(10))))),
          ],
        ),
      ],
    ));
  }

  Widget _buildVotingInsights() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColor.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Icon(Icons.poll_outlined, color: Color(0xFF818CF8), size: 20),
          const SizedBox(width: 10),
          Text("Voting Insights", style: AppText.body2.medium.copyWith(color: const Color(0xFF818CF8))),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF818CF8)),
        ],
      ),
    );
  }

  Widget _buildCommentBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "What's your thought about this discussion?", border: InputBorder.none, hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF818CF8), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.send_outlined, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Discussions (124)", style: AppText.body1.bold),
        Text("See all", style: AppText.body2().copyWith(color: Colors.grey)),
      ],
    );
  }

  Widget _buildCommentsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) => _commentItem(),
    );
  }

  Widget _commentItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=zara')),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("@zara_debates", style: AppText.body2.bold),
                Text("2h ago", style: AppText.label().copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text("Completely agree! This is the future.", style: AppText.body2()),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.teal),
            const SizedBox(width: 4),
            Text("28", style: AppText.label().copyWith(color: Colors.teal)),
            const SizedBox(width: 15),
            const Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.pink),
            const SizedBox(width: 4),
            Text("15", style: AppText.label().copyWith(color: Colors.pink)),
            const SizedBox(width: 20),
            Text("Reply", style: AppText.label().copyWith(color: Colors.grey)),
            const Spacer(),
            Text("View 12 replies", style: AppText.label().copyWith(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}