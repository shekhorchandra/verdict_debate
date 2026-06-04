import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import '../controller/GenderSelectionController.dart';

class GenderSelectionView extends GetView<GenderSelectionController> {
  const GenderSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E), // Deep dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Back Button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF252348),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                ),
              ),

              const SizedBox(height: 40),
              const Text(
                "Select Your Gender",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Gender Row
              Row(
                children: [
                  _buildGenderBtn(label: "Male", icon: Icons.male, index: 1),
                  const SizedBox(width: 15),
                  _buildGenderBtn(label: "Female", icon: Icons.female, index: 2),
                ],
              ),

              const SizedBox(height: 40),
              const Text(
                "Nationality",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Country Picker Dropdown
              _buildCountrySelector(context),

              const Spacer(),

              // Continue Button
              _buildContinueButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderBtn({required String label, required IconData icon, required int index}) {
    return Expanded(
      child: Obx(() {
        bool isSelected = controller.selectedGender.value == index;
        return GestureDetector(
          onTap: () => controller.selectGender(index),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: isSelected
                  ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)])
                  : null,
              color: isSelected ? null : const Color(0xFF252348),
              border: isSelected ? null : Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCountrySelector(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            controller.updateCountry(country.name, country.countryCode);
          },
          countryListTheme: CountryListThemeData(
            backgroundColor: const Color(0xFF0D0C1E),
            textStyle: const TextStyle(color: Colors.white),
            searchTextStyle: const TextStyle(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            inputDecoration: InputDecoration(
              hintText: "Search country",
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(Icons.search, color: Colors.white38),
              filled: true,
              fillColor: const Color(0xFF252348),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF252348).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF4F46E5).withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Obx(() => Text(
                _getFlag(controller.selectedCountryCode.value),
                style: const TextStyle(fontSize: 20)
            )),
            const SizedBox(width: 12),
            Obx(() => Text(
              controller.selectedCountryName.value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            )),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF818CF8)),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF4F46E5)]),
      ),
      child: ElevatedButton(
        onPressed: controller.onContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // Helper to get flag emoji from country code
  String _getFlag(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}