import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';


class MatchSettingsController extends GetxController {
  var selectedDuration = "10m".obs;
  var gemBalance = 500.obs;

  // Added these to store the choices from sub-filters
  var selectedCountry = "Country".obs;
  var selectedGender = "Gender".obs;

  final List<String> durations = ["10m", "15m", "30m", "45m", "60m", "75m"];
  final List<String> proDurations = ["30m", "45m", "60m", "75m"];

  String? categoryId;
  String? categoryTitle;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      categoryId = Get.arguments['id'];
      categoryTitle = Get.arguments['title'];

      selectedCountry.value =
          Get.arguments['country'] ?? "Country";

      selectedGender.value =
          Get.arguments['gender'] ?? "Gender";
    }
  }

  void onBack() {
    Get.back();
  }

  void selectDuration(String dur) => selectedDuration.value = dur;

  // Use '.then' to capture the result when the user comes back from filters
  void openGenderFilter() {
    Get.toNamed(AppRoutes.GENDER_FILTER, arguments: Get.arguments)?.then((val) {
      if (val != null) selectedGender.value = val;
    });
  }

  void openCountryFilter() {
    Get.toNamed(AppRoutes.COUNTRY_FILTER, arguments: Get.arguments)?.then((val) {
      if (val != null) selectedCountry.value = val;
    });
  }

  void findMatch() {
    debugPrint("Searching for a match in $categoryTitle ($selectedCountry) for $selectedDuration...");

    // 1. Show a searching snackbar (Optional but recommended for UX)
    Get.snackbar(
      "Searching",
      "Finding the best opponent for $categoryTitle...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.indigo.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // 2. Navigate to the Live Stream page
    // We pass the categoryTitle and duration so the next page can display them
    Get.toNamed(
      AppRoutes.LIVE_STREAM,
      arguments: {
        "category": categoryTitle,
        "duration": selectedDuration,
      },
    );
  }


}