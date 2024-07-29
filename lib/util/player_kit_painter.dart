import 'package:flutter/material.dart';

import '../theme/theme.dart';

class PlayerKitPainter extends CustomPainter {
  final Color primaryColor;
  final Color borderColor;
  final Color numberColor;
  final int? number;
  final BuildContext context;

  PlayerKitPainter({
    required this.primaryColor,
    required this.borderColor,
    required this.numberColor,
    required this.number,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final borderWidth = size.width * 0.03;

    /// Draw shirt outline
    paint
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawPath(getShirtPath(size), paint);

    /// Fill shirt
    paint
      ..color = primaryColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(getShirtPath(size), paint);

    /// Draw number
    final textSpan = TextSpan(
      text: '$number',
      style: context.textStyles.matchLineupsSectionNumber.copyWith(
        color: numberColor,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout(
        maxWidth: size.width,
      );
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  Path getShirtPath(Size size) => Path()
    ..moveTo(size.width * 0.2, size.height * 0.2)
    ..lineTo(0, size.height * 0.4) // Left sleeve start
    ..lineTo(size.width * 0.15, size.height * 0.45) // Left sleeve end
    ..lineTo(size.width * 0.25, size.height * 0.3)
    ..lineTo(size.width * 0.3, 0) // Left shoulder
    ..lineTo(size.width * 0.7, 0) // Right shoulder
    ..lineTo(size.width * 0.75, size.height * 0.3)
    ..lineTo(size.width * 0.85, size.height * 0.45) // Right sleeve end
    ..lineTo(size.width, size.height * 0.4) // Right sleeve start
    ..lineTo(size.width * 0.8, size.height * 0.2)
    ..quadraticBezierTo(size.width * 0.8, size.height * 0.6, size.width * 0.6, size.height)
    ..lineTo(size.width * 0.4, size.height)
    ..quadraticBezierTo(size.width * 0.2, size.height * 0.6, size.width * 0.2, size.height * 0.2)
    ..close();

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
