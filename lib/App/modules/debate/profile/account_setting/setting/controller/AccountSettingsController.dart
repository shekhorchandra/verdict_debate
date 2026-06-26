import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/app_routes.dart';

class AccountSettingsController extends GetxController {
  // Controllers for the input fields
  final usernameController = TextEditingController(text: "Tonoy_Saha");
  final emailController = TextEditingController(text: "example123@gmail.com");
  final dobController = TextEditingController(text: "01/04/2001");

  void changePassword() {
    Get.toNamed(AppRoutes.CHANGE_PASSWORD);
  }

  void deleteAccount() {
    Get.toNamed(AppRoutes.DELETE_ACCOUNT);
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }
}