import 'package:flutter/material.dart';

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path get pessimisticPath => getPath(Size(100, 100)); // Dummy for compilation

  @override
  Path getPath(Size size) {
    Path path = Path();
    double holeWidth = 80;
    double holeHeight = 45;
    double curveSize = 25;

    path.moveTo(0, 20); // Top left corner radius start
    path.quadraticBezierTo(0, 0, 20, 0); // Top left corner

    // Line to the start of the notch
    path.lineTo((size.width / 2) - holeWidth / 2 - curveSize, 0);

    // The "Dip" curve
    path.quadraticBezierTo(
      (size.width / 2) - holeWidth / 2, 0,
      (size.width / 2) - holeWidth / 2, curveSize,
    );
    path.arcToPoint(
      Offset((size.width / 2) + holeWidth / 2, curveSize),
      radius: const Radius.circular(35),
      clockwise: false,
    );
    path.quadraticBezierTo(
      (size.width / 2) + holeWidth / 2, 0,
      (size.width / 2) + holeWidth / 2 + curveSize, 0,
    );

    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20); // Top right corner
    path.lineTo(size.width, size.height - 20);
    path.quadraticBezierTo(size.width, size.height, size.width - 20, size.height);
    path.lineTo(20, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 20);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    throw UnimplementedError();
  }
}