import 'package:flutter/material.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;

  const GlobalBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The absolute darkest color of your background
      backgroundColor: const Color(0xFF02010A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF09071F), // Slightly lighter navy at top
              Color(0xFF03020C), // Deep black-navy center
              Color(0xFF05041A), // Subtle lift at bottom
            ],
          ),
        ),
        child: Stack(
          children: [
            /// Top-left deep purple glow
            Positioned(
              top: -150,
              left: -300,
              child: _glowCircle(
                600,
                const Color(0xFF2C1654).withOpacity(0.4), // Muted purple
              ),
            ),

            /// Bottom-right vibrant indigo glow (the most visible part)
            Positioned(
              bottom: -250,
              right: -250,
              child: _glowCircle(
                650,
                const Color(0xFF2C1654).withOpacity(0.01), // Vibrant indigo/navy
              ),
            ),

            /// Content
            SafeArea(
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _glowCircle(double size, Color color) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.7,
            colors: [
              color,
              color.withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
      ),
    );
  }
}