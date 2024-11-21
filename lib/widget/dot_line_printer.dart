import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double dashWidth = 5.0; // Adjust the dash width as needed
    double dashSpace = 5.0; // Adjust the dash space as needed

    double startY = size.height / 2;
    double endX = size.width;

    for (double i = 0; i < endX; i += dashWidth + dashSpace) {
      canvas.drawLine(Offset(i, startY), Offset(i + dashWidth, startY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}