import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_assets.dart';
import '../controller/challenge_controller.dart';

class ChallengeDialog extends StatelessWidget {
  const ChallengeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We can find the controller already initialized in the page
    final ChallengeController controller = Get.find();

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