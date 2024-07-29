import 'package:flutter/material.dart';

class FieldPainter extends CustomPainter {
  final Color linesColor;
  final double cornerRadius;

  FieldPainter({
    required this.linesColor,
    this.cornerRadius = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = linesColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    /// Draw field border
    final borderPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(cornerRadius),
        ),
      );
    canvas.drawPath(borderPath, paint);

    /// Draw center line
    final centerLinePath = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2);
    canvas.drawPath(centerLinePath, paint);

    /// Draw center circle
    final centerCirclePath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 5,
        ),
      );
    canvas.drawPath(centerCirclePath, paint);

    /// Draw penalty areas
    final penaltyAreaWidth = size.width * 0.6;
    final penaltyAreaHeight = size.height * 0.2;

    final topPenaltyAreaPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width - penaltyAreaWidth) / 2,
            0,
            penaltyAreaWidth,
            penaltyAreaHeight,
          ),
          Radius.circular(cornerRadius),
        ),
      );
    canvas.drawPath(topPenaltyAreaPath, paint);

    final bottomPenaltyAreaPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width - penaltyAreaWidth) / 2,
            size.height - penaltyAreaHeight,
            penaltyAreaWidth,
            penaltyAreaHeight,
          ),
          Radius.circular(cornerRadius),
        ),
      );
    canvas.drawPath(bottomPenaltyAreaPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
