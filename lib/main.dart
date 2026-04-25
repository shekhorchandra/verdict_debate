import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'App/core/values/app_strings.dart';
import 'App/core/values/app_text.dart';
import 'App/routes/app_pages.dart';
import 'App/routes/app_routes.dart';
import 'global_background.dart';

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
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: AppColor.BG,
        // canvasColor: AppColor.BG,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        useMaterial3: true,
        fontFamily: 'FontMain',
        textTheme: AppText.textTheme,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      // THIS WRAPS EVERY PAGE IN THE GRADIENT BACKGROUND
      builder: (context, child) {
        return GlobalBackground(child: child ?? const SizedBox());
      },
    );
  }
}
