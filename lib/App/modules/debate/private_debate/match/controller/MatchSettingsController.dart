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
    // Fixed the null issue by using 'categoryTitle' instead of arguments directly
    print("Searching for a match in $categoryTitle ($selectedCountry) for $selectedDuration...");
  }
}