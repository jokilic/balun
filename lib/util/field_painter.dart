import 'package:flutter/material.dart';

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    /// Draw center line
    canvas
      ..drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      )

      /// Draw center circle
      ..drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 5,
        paint,
      );

    /// Draw penalty areas
    final penaltyAreaWidth = size.width * 0.6;
    final penaltyAreaHeight = size.height * 0.2;
    canvas
      ..drawRect(
        Rect.fromLTWH(
          (size.width - penaltyAreaWidth) / 2,
          0,
          penaltyAreaWidth,
          penaltyAreaHeight,
        ),
        paint,
      )
      ..drawRect(
        Rect.fromLTWH(
          (size.width - penaltyAreaWidth) / 2,
          size.height - penaltyAreaHeight,
          penaltyAreaWidth,
          penaltyAreaHeight,
        ),
        paint,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
