import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/CountryFilterController.dart';

class CountryFilterView extends GetView<CountryFilterController> {
  const CountryFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background (Simulating Live Camera/Video)
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6",
              fit: BoxFit.cover,
            ),
          ),

          // 2. Top UI (Back and Gems)
          _buildTopOverlay(),

          // 3. Bottom Filter Sheet
          _buildBottomFilterSheet(),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.diamond, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Obx(() => Text("${controller.gemBalance.value}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomFilterSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.7,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF2E2C5C), // Deep purple background
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Country Filter", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white10),

                    // Random Option
                    _buildCountryTile("Random", ""),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text("Select a country to match with", style: TextStyle(color: Colors.white, fontSize: 16)),
                        const SizedBox(width: 10),
                        _gemBadge(controller.filterCost.toString()),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Country List
                    ...controller.countries.map((c) => _buildCountryTile(c['name']!, c['code']!)).toList(),
                  ],
                ),
              ),
            ),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: _buildConfirmButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryTile(String name, String code) {
    return Obx(() {
      bool isSelected = controller.selectedCountry.value == name;
      return ListTile(
        onTap: () => controller.selectCountry(name),
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? const Color(0xFF818CF8) : Colors.white38,
        ),
        title: Row(
          children: [
            if (code.isNotEmpty) ...[
              Text(_getFlag(code), style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
            ],
            Text(name, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 16)),
          ],
        ),
      );
    });
  }

  Widget _buildConfirmButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
      ),
      child: ElevatedButton(
        onPressed: controller.onConfirm,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Confirm & Continue", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            const Icon(Icons.diamond, color: Colors.white70, size: 18),
            const SizedBox(width: 4),
            Text("${controller.filterCost}", style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _gemBadge(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.diamond, color: Colors.white, size: 12),
          const SizedBox(width: 4),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _getFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}