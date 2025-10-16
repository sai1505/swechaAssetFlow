import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Custom SVG illustration for Asset Management using CustomPaint
class AssetManagementIllustration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint blackPaint = Paint()
      ..color = AppConstants.primaryBlack
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = AppConstants.primaryBlack
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint whitePaint = Paint()
      ..color = AppConstants.primaryWhite
      ..style = PaintingStyle.fill;

    final Paint greyPaint = Paint()
      ..color = AppConstants.lightGrey
      ..style = PaintingStyle.fill;

    // Background Circle (decorative)
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.45),
      size.width * 0.35,
      greyPaint,
    );

    // Draw Clipboard/Document Base
    final clipboardPath = Path();
    clipboardPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.25,
          size.height * 0.2,
          size.width * 0.5,
          size.height * 0.65,
        ),
        const Radius.circular(8),
      ),
    );
    canvas.drawPath(clipboardPath, whitePaint);
    canvas.drawPath(clipboardPath, strokePaint);

    // Draw Clipboard Clip
    final clipPath = Path();
    clipPath.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.4,
          size.height * 0.15,
          size.width * 0.2,
          size.height * 0.08,
        ),
        const Radius.circular(6),
      ),
    );
    canvas.drawPath(clipPath, blackPaint);
    canvas.drawPath(clipPath, strokePaint);

    // Draw checkboxes/list items
    for (int i = 0; i < 4; i++) {
      final double yOffset = size.height * (0.3 + i * 0.12);

      // Checkbox
      final checkboxRect = Rect.fromLTWH(
        size.width * 0.32,
        yOffset,
        size.width * 0.08,
        size.width * 0.08,
      );
      canvas.drawRect(checkboxRect, whitePaint);
      canvas.drawRect(checkboxRect, strokePaint);

      // Checkmark for first two items
      if (i < 2) {
        final checkPath = Path();
        checkPath.moveTo(size.width * 0.33, yOffset + size.width * 0.04);
        checkPath.lineTo(
          size.width * 0.355,
          yOffset + size.width * 0.06,
        );
        checkPath.lineTo(size.width * 0.39, yOffset + size.width * 0.02);
        canvas.drawPath(checkPath, strokePaint);
      }

      // Line next to checkbox (representing text)
      canvas.drawLine(
        Offset(size.width * 0.43, yOffset + size.width * 0.04),
        Offset(size.width * 0.65, yOffset + size.width * 0.04),
        strokePaint,
      );
    }

    // Draw Box/Package Icon (bottom right)
    final boxPath = Path();
    boxPath.moveTo(size.width * 0.72, size.height * 0.65);
    boxPath.lineTo(size.width * 0.82, size.height * 0.59);
    boxPath.lineTo(size.width * 0.92, size.height * 0.65);
    boxPath.lineTo(size.width * 0.92, size.height * 0.78);
    boxPath.lineTo(size.width * 0.82, size.height * 0.84);
    boxPath.lineTo(size.width * 0.72, size.height * 0.78);
    boxPath.close();

    canvas.drawPath(boxPath, whitePaint);
    canvas.drawPath(boxPath, strokePaint);

    // Box middle line
    canvas.drawLine(
      Offset(size.width * 0.82, size.height * 0.59),
      Offset(size.width * 0.82, size.height * 0.84),
      strokePaint,
    );

    // Draw Gear Icon (bottom left)
    _drawGear(
      canvas,
      Offset(size.width * 0.15, size.height * 0.72),
      size.width * 0.06,
      strokePaint,
      whitePaint,
    );

    // Draw Chart/Analytics Icon (top right)
    _drawBarChart(
      canvas,
      Offset(size.width * 0.85, size.height * 0.25),
      size.width * 0.08,
      size.height * 0.12,
      strokePaint,
      greyPaint,
    );
  }

  void _drawGear(
    Canvas canvas,
    Offset center,
    double radius,
    Paint stroke,
    Paint fill,
  ) {
    final gearPath = Path();
    const int teeth = 8;
    const double outerRadius = 1.0;
    const double innerRadius = 0.7;

    for (int i = 0; i < teeth * 2; i++) {
      final angle = (i * 3.14159) / teeth;
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final x = center.dx + radius * r * cos(angle);
      final y = center.dy + radius * r * sin(angle);

      if (i == 0) {
        gearPath.moveTo(x, y);
      } else {
        gearPath.lineTo(x, y);
      }
    }
    gearPath.close();

    canvas.drawPath(gearPath, fill);
    canvas.drawPath(gearPath, stroke);

    // Center circle
    canvas.drawCircle(center, radius * 0.3, fill);
    canvas.drawCircle(center, radius * 0.3, stroke);
  }

  void _drawBarChart(
    Canvas canvas,
    Offset topLeft,
    double width,
    double height,
    Paint stroke,
    Paint fill,
  ) {
    final barWidth = width * 0.2;
    final spacing = width * 0.05;

    for (int i = 0; i < 3; i++) {
      final barHeight = height * (0.5 + i * 0.2);
      final rect = Rect.fromLTWH(
        topLeft.dx + i * (barWidth + spacing),
        topLeft.dy + height - barHeight,
        barWidth,
        barHeight,
      );
      canvas.drawRect(rect, fill);
      canvas.drawRect(rect, stroke);
    }
  }

  double cos(double angle) => Offset(angle, 0).direction.isNaN ? 1.0 : angle;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Simple Document Stack Illustration
class DocumentStackIllustration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint whitePaint = Paint()
      ..color = AppConstants.primaryWhite
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = AppConstants.primaryBlack
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw 3 stacked documents
    for (int i = 0; i < 3; i++) {
      final offset = i * 8.0;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.2 + offset,
          size.height * 0.2 + offset,
          size.width * 0.5,
          size.height * 0.6,
        ),
        const Radius.circular(8),
      );
      canvas.drawRRect(rect, whitePaint);
      canvas.drawRRect(rect, strokePaint);

      // Draw lines on the top document
      if (i == 2) {
        for (int j = 0; j < 4; j++) {
          canvas.drawLine(
            Offset(
              size.width * 0.3,
              size.height * (0.35 + j * 0.1),
            ),
            Offset(
              size.width * 0.6,
              size.height * (0.35 + j * 0.1),
            ),
            strokePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
