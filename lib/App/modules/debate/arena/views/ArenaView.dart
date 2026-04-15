import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ArenaController.dart';


class ArenaView extends GetView<ArenaController> {
  const ArenaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Arena")),
      body: Center(
        child: Obx(() => Text(
          controller.title.value,
          style: const TextStyle(fontSize: 20),
        )),
      ),
    );
  }
}