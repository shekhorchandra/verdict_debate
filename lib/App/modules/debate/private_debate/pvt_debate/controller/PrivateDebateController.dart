import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class PrivateDebateController extends GetxController {
  // 1. Added IDs to your category list
  final List<Map<String, String>> categories = [
    {"id": "1", "title": "Politics", "image": "assets/images/politics.png"},
    {"id": "2", "title": "Religion", "image": "assets/images/religion.png"},
    {"id": "3", "title": "Ethics and\nMorality", "image": "assets/images/ethics.png"},
    {"id": "4", "title": "Random", "image": "assets/images/random.png"},
    {"id": "5", "title": "Sports", "image": "assets/images/sports.png"},
  ];

  // 2. Updated navigation with Map arguments
  void onCategoryTap(String id, String title) {
    Get.toNamed(
      AppRoutes.COUNTRY_FILTER,
      arguments: {
        "id": id,
        "title": title,
      },
    );
  }
}