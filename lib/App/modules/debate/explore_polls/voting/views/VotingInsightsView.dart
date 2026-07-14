import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/VotingInsightsController.dart'; // Ensure correct path

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
                      // Removed Tab Switcher because we show both now
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
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
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
              Text("Voting Insights", style: AppText.h5.bold.copyWith(color: const Color(0xFF818CF8))),
              const Spacer(),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsList() {
    // Note: You can change this to use a combined list from your controller
    final list = controller.agreeData;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        // Passing static 60/40 for now to match image,
        // you can make this dynamic from your data model later
        return _buildListItem(list[index], 60, 40);
      },
    );
  }

  Widget _buildListItem(String location, int agreePct, int disagreePct) {
    const Color agreeColor = Color(0xFF00B4D8); // Cyan
    const Color disagreeColor = Color(0xFFFF006E); // Pink

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          // Top Row: Location and Total Votes
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 20, color: Colors.black87),
              const SizedBox(width: 8),
              Text(location, style: AppText.body1.medium.copyWith(color: Colors.black87)),
              const Spacer(),
              const Icon(Icons.person_outline, size: 18, color: Colors.grey),
              const SizedBox(width: 4),
              Text("24", style: AppText.body1.medium.copyWith(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar Row with Percentages
          Row(
            children: [
              // Left Percentage
              Text("$agreePct%", style: const TextStyle(color: agreeColor, fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(width: 10),

              // The Combined Bar
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    children: [
                      // Agree Segment (Cyan)
                      Expanded(
                        flex: agreePct,
                        child: Container(height: 8, color: agreeColor),
                      ),
                      // Disagree Segment (Pink)
                      Expanded(
                        flex: disagreePct,
                        child: Container(height: 8, color: disagreeColor),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),
              // Right Percentage
              Text("$disagreePct%", style: const TextStyle(color: disagreeColor, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}