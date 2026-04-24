import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = "@tomal_ux".obs;
  var followers = "3455".obs;
  var debatesWon = "134".obs;
  var polls = "86".obs;

  void logout() {
    // Add logout logic here
    Get.snackbar("Auth", "Logging out...");
  }
}