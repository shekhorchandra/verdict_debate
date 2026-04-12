import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'App/core/values/app_color.dart';
import 'App/core/values/app_strings.dart';
import 'App/core/values/app_text.dart';
import 'App/routes/app_pages.dart';
import 'App/routes/app_routes.dart';

void main() async {
  runApp(const DebateApp());
}

class DebateApp extends StatelessWidget {
  const DebateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: AppColorScheme.light,
        // scaffoldBackgroundColor: Colors.black, // Base is black
        fontFamily: 'FontMain',
        textTheme: AppText.textTheme,
      ),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      // THIS WRAPS EVERY PAGE IN THE GRADIENT BACKGROUND
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // 1. TOP LEFT GLOW
              Positioned(
                top: -180,
                left: -180,
                child: _glowCircle(500, AppColor.primaryScale.s700.withOpacity(0.3)),
              ),
              // 2. BOTTOM RIGHT GLOW
              Positioned(
                bottom: -300,
                right: -200,
                child: _glowCircle(600, AppColor.primaryScale.s500.withOpacity(0.3)),
              ),
              // 3. THE ACTUAL CONTENT (Splash, Onboarding, etc.)
              if (child != null) child,
            ],
          ),
        );
      },
    );
  }

  // Helper for background circles
  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}