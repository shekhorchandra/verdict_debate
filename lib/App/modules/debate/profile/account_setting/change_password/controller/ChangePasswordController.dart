import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  // Visibility states
  var isCurrentObscured = true.obs;
  var isNewObscured = true.obs;
  var isConfirmObscured = true.obs;

  void toggleCurrent() => isCurrentObscured.value = !isCurrentObscured.value;
  void toggleNew() => isNewObscured.value = !isNewObscured.value;
  void toggleConfirm() => isConfirmObscured.value = !isConfirmObscured.value;

  void onSave() {
    if (newPassController.text != confirmPassController.text) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    Get.snackbar("Success", "Password updated successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
    Get.back();
  }

  @override
  void onClose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}