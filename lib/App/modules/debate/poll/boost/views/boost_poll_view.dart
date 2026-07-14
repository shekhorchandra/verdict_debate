import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/boost_poll_controller.dart';

class BoostPollView extends GetView<BoostPollController> {
  const BoostPollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Boost Your Poll", style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Color(0xFF1E1E2E),
            child: Icon(Icons.chevron_left, color: Colors.white),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            const Center(
              child: Column(
                children: [
                  Text("Increase Visibility",
                      style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Boost your poll to reach more people and get\nmore responses.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- CHOOSE BUDGET ---
            _buildSectionHeader("Choose Budget", showBadge: true),
            const SizedBox(height: 15),
            _buildBudgetGrid(),
            const SizedBox(height: 30),

            // --- BOOST DURATION ---
            _buildSectionHeader("Boost Duration"),
            const SizedBox(height: 15),
            _buildDurationSelector(),
            const SizedBox(height: 30),

            // --- BOOST SUMMARY ---
            _buildSummaryCard(),
            const SizedBox(height: 30),

            // --- ACTION BUTTON ---
            _buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showBadge = false}) {
    return Row(
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        if (showBadge) ...[
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF1E1E3F), borderRadius: BorderRadius.circular(20)),
            child: const Text("Select one", style: TextStyle(color: Color(0xFF7E7EFA), fontSize: 12)),
          )
        ]
      ],
    );
  }

  Widget _buildBudgetGrid() {
    return Obx(() {
      // --- ADD THIS LINE TO FIX THE ERROR ---
      // This "registers" the observable with Obx immediately
      final dummy = controller.selectedBudgetIndex.value;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.6,
        ),
        itemCount: controller.budgetOptions.length,
        itemBuilder: (context, index) {
          final option = controller.budgetOptions[index];
          final isSelected = controller.selectedBudgetIndex.value == index;
          return GestureDetector(
            onTap: () => controller.selectBudget(index),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isSelected ? Colors.transparent : const Color(0xFF13131D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF4F46E5) : Colors.black,
                  width: 2,
                ),
                gradient: isSelected
                    ? const LinearGradient(colors: [Color(0xFF3730A3), Colors.black])
                    : null,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(option.amount, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(option.reach, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                  if (isSelected)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.check_circle, color: Color(0xFF7E7EFA), size: 20),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildDurationSelector() {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E7FF), // Light indigo background
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedDuration.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF4F46E5)),
          dropdownColor: const Color(0xFFE0E7FF), // Background color of the list
          borderRadius: BorderRadius.circular(12),
          onChanged: (String? newValue) => controller.updateDuration(newValue),
          // Customizing how the selected item looks
          selectedItemBuilder: (BuildContext context) {
            return controller.durationOptions.map<Widget>((String item) {
              return Row(
                children: [
                  const Icon(Icons.access_time, color: Color(0xFF4F46E5)),
                  const SizedBox(width: 12),
                  Text(
                    item,
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          // List of items in the dropdown
          items: controller.durationOptions
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ));
  }

  Widget _buildSummaryCard() {
    return Obx(() {
      // Register variables at the top of Obx
      controller.selectedBudgetIndex.value;
      controller.selectedDuration.value;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Replacing single color with LinearGradient
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF44418B), // Your first color
              Color(0xFF22205D), // Your second color (#22205D)
            ],
          ),
          // If you want to keep the subtle border seen in the image:
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns header to the left
          children: [
            // --- ADDED HEADER ROW ---
            Row(
              children: [
                const Icon(Icons.bolt, color: Color(0xFF7E7EFA), size: 25), // Lightning icon
                const SizedBox(width: 8),
                Text(
                  "BOOST SUMMARY",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Spacing between header and first item

            // --- YOUR EXISTING ROWS ---
            _summaryRow(Icons.people_outline, "Estimated Reach", controller.estimatedReach),
            const Divider(color: Colors.white10, height: 30),
            _summaryRow(Icons.attach_money, "Budget", controller.budgetAmount),
            const Divider(color: Colors.white10, height: 30),
            _summaryRow(Icons.access_time, "Duration", controller.selectedDuration.value),
            const Divider(color: Colors.white10, height: 30),
            _summaryRow(Icons.trending_up, "Expected Impressions", controller.expectedImpressions),
          ],
        ),
      );
    });
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: const Color(0xFF7E7EFA), size: 18),
        ),
        const SizedBox(width: 15),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const Spacer(),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
      ),
      child: ElevatedButton(
        onPressed: controller.handlePayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Continue to Payment", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Icon(Icons.send, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}