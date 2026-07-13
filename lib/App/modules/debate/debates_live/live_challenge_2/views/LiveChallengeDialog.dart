import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_assets.dart';
import '../controller/LiveChallengeController.dart';

class LiveChallengeDialog extends StatelessWidget {
  const LiveChallengeDialog({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   // Access the controller already initialized by the page
  //   final LiveChallengeController controller = Get.find<LiveChallengeController>();
  //
  //   return Center(
  //     child: Material(
  //       color: Colors.transparent,
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 30),
  //         padding: const EdgeInsets.all(25),
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF2E2B5F),
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Icon
  //             const Icon(Icons.eighteen_mp, color: Colors.orange, size: 60),
  //             const SizedBox(height: 20),
  //             // Title
  //             const Text(
  //               "Challenge The Debaters",
  //               style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
  //             ),
  //             const SizedBox(height: 15),
  //             // Description
  //             const Text(
  //               "By sending a challenge_1, the debate_final_4 host can accept your request to join their live",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(color: Colors.white, fontSize: 14),
  //             ),
  //             const SizedBox(height: 30),
  //             // THE BUTTON
  //             SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () => controller.sendRequest(), // TRIGGERS NAVIGATION
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.orange,
  //                   padding: const EdgeInsets.symmetric(vertical: 15),
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                 ),
  //                 child: const Text("Send Request", style: TextStyle(fontWeight: FontWeight.bold)),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // We can find the controller already initialized in the page
    final LiveChallengeController controller = Get.find<LiveChallengeController>();

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF2E2B5F), // Deep purple background
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Close Button
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),

            // Main Content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                // Swords Icon (Using Flutter Icon or SVG)
                SvgPicture.asset(
                  AppAssets.war,
                  width: 80,
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.5),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Challenge The Debaters",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFB300),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Description
                const Text(
                  "By sending a challenge, the debate host can accept your request to join their live",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),

                // Send Request Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.sendRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA500), // Orange
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Send Request",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}