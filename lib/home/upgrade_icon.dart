import 'package:clc_app/resources/default_color.dart';
import 'package:flutter/material.dart';

class UploadIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = primeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final double radius = size.width / 2;
    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

    final Paint arrowPaint = Paint()
      ..color = primeColor
      ..style = PaintingStyle.fill;

    // Draw arrow pointing up
    Path arrowPath = Path();
    arrowPath.moveTo(size.width * 0.5, size.height * 0.2); // Arrow tip
    arrowPath.lineTo(size.width * 0.8, size.height * 0.5);
    arrowPath.lineTo(size.width * 0.6, size.height * 0.5);
    arrowPath.lineTo(size.width * 0.6, size.height * 0.75);
    arrowPath.lineTo(size.width * 0.4, size.height * 0.75);
    arrowPath.lineTo(size.width * 0.4, size.height * 0.5);
    arrowPath.lineTo(size.width * 0.2, size.height * 0.5);
    arrowPath.close();

    canvas.drawPath(arrowPath, arrowPaint);

    // Draw base line
    final Paint linePaint = Paint()
      ..color = primeColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.8, size.width * 0.5, 1),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
