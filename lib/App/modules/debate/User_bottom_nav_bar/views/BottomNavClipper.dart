import 'package:flutter/material.dart';

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) { // Changed from getPath to getClip
    Path path = Path();
    double holeWidth = 80;
    double curveSize = 25;

    // Start at the left side, slightly down for the corner radius
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0); // Top left corner

    // Line to the start of the center notch
    path.lineTo((size.width / 2) - holeWidth / 2 - curveSize, 0);

    // Smooth curve entering the notch
    path.quadraticBezierTo(
      (size.width / 2) - holeWidth / 2, 0,
      (size.width / 2) - holeWidth / 2, curveSize,
    );

    // The circular dip for the FAB
    path.arcToPoint(
      Offset((size.width / 2) + holeWidth / 2, curveSize),
      radius: const Radius.circular(35),
      clockwise: false, // This makes it dip "inward"
    );

    // Smooth curve exiting the notch
    path.quadraticBezierTo(
      (size.width / 2) + holeWidth / 2, 0,
      (size.width / 2) + holeWidth / 2 + curveSize, 0,
    );

    // Line to the right corner
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20); // Top right corner

    // Line down to bottom right
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(size.width, size.height, size.width - 20, size.height); // Bottom right

    // Line to bottom left
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20); // Bottom left

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}