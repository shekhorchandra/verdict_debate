import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ProfileController.dart';


class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Obx(() => Text(
          controller.username.value,
          style: const TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}