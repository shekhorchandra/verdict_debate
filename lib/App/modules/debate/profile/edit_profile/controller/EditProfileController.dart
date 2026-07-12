import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {

  late TextEditingController nameController;
  late TextEditingController usernameController;

  var selectedCountry = "United State".obs;
  var selectedCountryCode = "US".obs;
  var selectedDob = "Birth Date".obs;

  // Profile Image
  Rx<File?> profileImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();


  @override
  void onInit() {
    super.onInit();

    usernameController = TextEditingController(text: "Tonoy Saha");
    nameController = TextEditingController();
  }


  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      profileImage.value = File(image.path);
    }
  }


  void updateCountry(String name, String code) {
    selectedCountry.value = name;
    selectedCountryCode.value = code;
  }


  void updateDob(DateTime date) {
    selectedDob.value = "${date.day}/${date.month}/${date.year}";
  }


  void saveChanges() {
    Get.snackbar(
      "Success",
      "Profile updated successfully",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }


  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}