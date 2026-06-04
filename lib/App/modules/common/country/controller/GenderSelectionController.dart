import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class GenderSelectionController extends GetxController {
  // Observable for gender: 0 for none, 1 for Male, 2 for Female
  var selectedGender = 0.obs;

  // Observable for country
  var selectedCountryName = "United State".obs;
  var selectedCountryCode = "US".obs;

  void selectGender(int index) => selectedGender.value = index;

  void updateCountry(String name, String code) {
    selectedCountryName.value = name;
    selectedCountryCode.value = code;
  }

  void onContinue() {
    if (selectedGender.value == 0) {
      Get.snackbar("Required", "Please select your gender");
      return;
    }

    print(
      "Gender: ${selectedGender.value}, Country: ${selectedCountryName.value}",
    );

    Get.offAllNamed(AppRoutes.USER_BOTTOM_NAV);
  }
}