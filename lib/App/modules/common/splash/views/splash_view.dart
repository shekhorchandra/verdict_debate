import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_color.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: No Scaffold background needed here as it's provided by main.dart builder
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.splash,
            width: 400,
            height: 400,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 60,
            height: 40,
            child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOut,
              colors: [
                AppColor.primaryScale.s500,
                AppColor.primaryScale.s800,
                AppColor.primaryScale.s800,
              ],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}