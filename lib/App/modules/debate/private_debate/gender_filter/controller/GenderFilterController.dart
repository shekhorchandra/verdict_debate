import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class GenderFilterController extends GetxController {
  // Current state
  var selectedGender = 0.obs; // 0: Random, 1: Male, 2: Female
  var gemBalance = 500.obs;
  var filterCost = 25;

  // Variables to hold data from previous screens (Private Debate & Country Filter)
  String? categoryId;
  String? categoryTitle;
  String? selectedCountry;

  @override
  void onInit() {
    super.onInit();
    // 1. Capture ALL arguments passed down the chain
    if (Get.arguments != null) {
      categoryId = Get.arguments['id'];
      categoryTitle = Get.arguments['title'];
      selectedCountry = Get.arguments['country'];

      print("Flow: Category($categoryTitle) -> Country($selectedCountry)");
    }
  }

  void selectGender(int index) {
    selectedGender.value = index;
  }

  void onConfirm() {
    // 2. Logic to deduct gems if a filter (Male/Female) is used
    if (selectedGender.value != 0) {
      if (gemBalance.value >= filterCost) {
        gemBalance.value -= filterCost;
      } else {
        Get.snackbar(
          "Insufficient Gems",
          "You need $filterCost gems to use the gender filter.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }
    }

    Get.toNamed(
      AppRoutes.MATCH_SETTINGS,
      arguments: {
        "id": categoryId,
        "title": categoryTitle,
        "country": selectedCountry ?? "Random",
        "gender": _getGenderLabel(),
      },
    );
  }

  String _getGenderLabel() {
    if (selectedGender.value == 1) return "Male";
    if (selectedGender.value == 2) return "Female";
    return "Random";
  }
}
