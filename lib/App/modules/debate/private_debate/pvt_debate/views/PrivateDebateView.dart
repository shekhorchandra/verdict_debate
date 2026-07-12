import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/values/app_text.dart';
import '../controller/PrivateDebateController.dart';

class PrivateDebateView extends GetView<PrivateDebateController> {
  const PrivateDebateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important to show GlobalBackground
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Private Debates",
          style: AppText.h4.bold.copyWith(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 20, // Horizontal gap
          mainAxisSpacing: 20, // Vertical gap
          childAspectRatio: 0.85, // Adjust height/width ratio
        ),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final item = controller.categories[index];
          // Calling the helper method with all 3 required arguments
          return _buildCategoryCard(
            item['id']!,
            item['title']!,
            item['image']!,
          );
        },
      ),
    );
  }

  // Helper method updated to accept id, title, and imagePath
  Widget _buildCategoryCard(String id, String title, String imagePath) {
    return GestureDetector(
      onTap: () => controller.onCategoryTap(id, title), // Passing ID and Title to Controller
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5D5FEF), // Lighter purple top
              Color(0xFF3F3D79), // Darker purple bottom
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image/Illustration
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    color: Colors.white24,
                    size: 50,
                  ),
                ),
              ),
            ),

            // Title
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppText.body1.bold.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}