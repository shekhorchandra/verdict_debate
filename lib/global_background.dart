import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'App/core/values/app_color.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;

  const GlobalBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: -180,
            left: -180,
            child: _glowCircle(
              500,
              AppColor.primaryScale.s700.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: -300,
            right: -200,
            child: _glowCircle(
              600,
              AppColor.primaryScale.s500.withOpacity(0.3),
            ),
          ),
          child,
        ],
      ),
    );
  }

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