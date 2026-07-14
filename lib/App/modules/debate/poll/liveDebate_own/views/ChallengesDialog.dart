import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../waitting_own/controller/WaitingController.dart';

class ChallengesDialog extends StatelessWidget {
  const ChallengesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIX: Change the type to WaitingController
    final WaitingController controller = Get.find<WaitingController>();

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF2E2B5F),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    const Text("Challenges",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white12),

              // List
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: Obx(() => ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: controller.challengers.length,
                    separatorBuilder: (context, index) => const Divider(color: Colors.white10, height: 30),
                    itemBuilder: (context, index) {
                      final user = controller.challengers[index];
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(user['img']!), radius: 25),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                    children: [
                                      TextSpan(text: "${user['name']} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: "Challenged The Debate!", style: TextStyle(color: Colors.white70)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              _actionBtn("Reject", Colors.redAccent, () => controller.rejectChallenge(index)),
                              const SizedBox(width: 15),
                              _actionBtn("Accept", Colors.greenAccent[700]!, () => controller.acceptChallenge()),
                            ],
                          )
                        ],
                      );
                    },
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionBtn(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))),
        ),
      ),
    );
  }
}