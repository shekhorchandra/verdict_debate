import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/VotingInsightsController.dart';


class VotingInsightsView extends GetView<VotingInsightsController> {
  const VotingInsightsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Nav/Padding
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const Divider(height: 1),
                      _buildTabSwitcher(),
                      Expanded(child: _buildInsightsList()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // The small handle at the top
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.grey),
              ),
              const Spacer(),
              const Icon(Icons.location_city, color: Color(0xFF818CF8), size: 22),
              const SizedBox(width: 8),
              Text(
                "Voting Insights",
                style: AppText.h5.bold.copyWith(color: const Color(0xFF818CF8)),
              ),
              const Spacer(),
              const SizedBox(width: 20), // Balance the back arrow
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _tabItem("Agree", 0, const Color(0xFF00B4D8)),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          _tabItem("Disagree", 1, const Color(0xFFFF006E)),
        ],
      )),
    );
  }

  Widget _tabItem(String title, int index, Color activeColor) {
    bool isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        color: Colors.transparent,
        child: Text(
          title,
          style: AppText.h5.bold.copyWith(
            color: isSelected ? activeColor : Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightsList() {
    return Obx(() {
      final list = controller.selectedTab.value == 0
          ? controller.agreeData
          : controller.disagreeData;
      final color = controller.selectedTab.value == 0
          ? const Color(0xFF00B4D8)
          : const Color(0xFFFF006E);

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildListItem(list[index], color);
        },
      );
    });
  }

  Widget _buildListItem(String location, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 20, color: Colors.black87),
              const SizedBox(width: 8),
              Text(location, style: AppText.body1.medium),
              const Spacer(),
              Text("24", style: AppText.body1.medium),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.6, // You can make this dynamic based on data
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}