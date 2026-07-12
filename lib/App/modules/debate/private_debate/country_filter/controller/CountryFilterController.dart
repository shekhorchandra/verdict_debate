import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class CountryFilterController extends GetxController {
  var selectedCountry = "Random".obs;
  var gemBalance = 500.obs;
  var filterCost = 15;

  String? categoryId;
  String? categoryTitle;

  final List<Map<String, String>> countries = [
    {"name": "Argentina", "code": "AR"},
    {"name": "Angola", "code": "AO"},
    {"name": "Australia", "code": "AU"},
    {"name": "Albania", "code": "AL"},
    {"name": "Andorra", "code": "AD"},
  ];

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      categoryId = Get.arguments['id'];
      categoryTitle = Get.arguments['title'];
    }
  }

  void selectCountry(String name) {
    selectedCountry.value = name;
  }

  void onConfirm() {
    Get.toNamed(
      AppRoutes.GENDER_FILTER,
      arguments: {
        "id": categoryId,
        "title": categoryTitle,
        "country": selectedCountry.value, // <-- IMPORTANT
      },
    );
  }
}