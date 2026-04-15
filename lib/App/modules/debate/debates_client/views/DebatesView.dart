import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/DebatesController.dart';


class DebatesView extends GetView<DebatesController> {
  const DebatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debates")),
      body: Center(
        child: Obx(() => Text(
          controller.title.value,
          style: const TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}