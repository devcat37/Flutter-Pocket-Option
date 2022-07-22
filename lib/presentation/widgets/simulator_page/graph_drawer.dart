import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:pocket_option/domain/models/value_history.dart';
import 'package:pocket_option/internal/states/simulator_state.dart';
import 'package:pocket_option/internal/utils/infrastructure.dart';

class GraphDrawer extends CustomPainter {
  const GraphDrawer({
    required this.height,
    required this.width,
    required this.currentTime,
    this.valueHistory = const [],
    this.betValue,
    this.betType,
  });

  final double height;
  final double width;

  final List<ValueHistory> valueHistory;
  final DateTime currentTime;

  final ValueHistory? betValue;
  final BetType? betType;

  double get minValue => (valueHistory.map((e) => e.rate).reduce((a, b) => min(a, b))) * 1.1;
  double get maxValue => (valueHistory.map((e) => e.rate).reduce((a, b) => max(a, b))) / 1.1;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBorder(canvas);
    _drawTime(canvas);
    _drawValues(canvas);
  }

  void _drawValues(Canvas canvas) {
    final double blockSize = 56.r;
    final double borderWidth = width - 56.w;
    final double borderHeight = height - 18.h;

    final Paint valuePaint = Paint()
      ..color = whiteColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.r;

    final Paint gradientPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          whiteColor.withOpacity(0.5),
          whiteColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTRB(0, 0, borderWidth, borderHeight));

    final TextStyle style = TextStyle(fontSize: 9.w, fontWeight: FontWeight.w600, color: whiteColor);

    final Path path = Path();
    final Path gradientPath = Path();

    Offset betValueOffset = Offset.zero;

    for (ValueHistory history in valueHistory) {
      final double valuePercent = (history.rate - minValue) / (maxValue - minValue);
      final int secondsSinceNow = currentTime.difference(history.date).inSeconds;
      final double secondsPixels = secondsSinceNow * ((blockSize * 1.5)) / 600;

      final Offset coordinates = Offset(borderWidth - (blockSize * 1.5) - secondsPixels, borderHeight * valuePercent);

      if (valueHistory.indexOf(history) == 0) {
        path.moveTo(coordinates.dx, coordinates.dy);

        gradientPath.moveTo(coordinates.dx, borderHeight);
        gradientPath.lineTo(coordinates.dx, coordinates.dy);

        final RRect rrect = RRect.fromLTRBR(
          coordinates.dx - 10.r,
          coordinates.dy - 10.r,
          coordinates.dx + 10.r,
          coordinates.dy + 10.r,
          Radius.circular(4.r),
        );

        // Маркер на последнем значении.
        canvas.drawRRect(rrect, Paint()..color = whiteColor.withOpacity(0.4));
        canvas.drawRRect(
            rrect,
            Paint()
              ..color = whiteColor
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.r);

        final RRect centerRrect = RRect.fromLTRBR(
          coordinates.dx - 2.r,
          coordinates.dy - 2.r,
          coordinates.dx + 2.r,
          coordinates.dy + 2.r,
          Radius.circular(1.r),
        );

        canvas.drawRRect(centerRrect, Paint()..color = whiteColor);

        canvas.drawLine(
          Offset(0, coordinates.dy),
          Offset(borderWidth, coordinates.dy),
          Paint()
            ..color = whiteColor
            ..strokeWidth = 1.r,
        );

        final text = TextSpan(text: history.rate.toStringAsFixed(4), style: style);
        final textPainter = TextPainter(text: text, textDirection: TextDirection.ltr);

        textPainter.layout(minWidth: 0, maxWidth: borderWidth);
        textPainter.paint(
          canvas,
          Offset(borderWidth - textPainter.width - 8.w, coordinates.dy - textPainter.height / 2 - 10.h),
        );
      } else {
        path.lineTo(coordinates.dx, coordinates.dy);

        gradientPath.lineTo(coordinates.dx, coordinates.dy);
      }

      if (valueHistory.indexOf(history) == valueHistory.length - 1) {
        // Завершаем градиент.
        gradientPath.lineTo(coordinates.dx, borderHeight);
      }

      if (history == betValue && betType != null) {
        betValueOffset = Offset(coordinates.dx, coordinates.dy);
      }
    }
    gradientPath.close();

    // Градиент под графиком.
    canvas.drawPath(gradientPath, gradientPaint);

    // График.
    canvas.drawPath(path, valuePaint);

    if (betValue != null && betValueOffset != Offset.zero) {
      final RRect rrect = RRect.fromLTRBR(
        betValueOffset.dx - 12.r,
        betValueOffset.dy - 12.r,
        betValueOffset.dx + 12.r,
        betValueOffset.dy + 12.r,
        Radius.circular(4.r),
      );

      // Маркер на последнем значении.
      canvas.drawRRect(
        rrect,
        Paint()..color = betType == BetType.up ? greenColor : redColor,
      );
      canvas.drawLine(
        Offset(0, betValueOffset.dy),
        Offset(borderWidth, betValueOffset.dy),
        Paint()
          ..color = betType == BetType.up ? greenColor : redColor
          ..strokeWidth = 1.0,
      );

      final IconData icon = betType == BetType.up ? Icons.expand_less : Icons.expand_more;

      final textPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(color: whiteColor, fontSize: 20.r, fontFamily: icon.fontFamily, package: icon.fontPackage),
          ),
          textDirection: TextDirection.ltr);

      textPainter.layout(minWidth: 0, maxWidth: 40.r);
      textPainter.paint(
          canvas, Offset(betValueOffset.dx - textPainter.width / 2, betValueOffset.dy - textPainter.height / 2));
    }
  }

  void _drawTime(Canvas canvas) {
    final double borderWidth = width - 56.w;

    // Нужно сделать, чтобы текущее время было посередине.
    // Со временем горизонтальная шкала сдвигается влево.
    // 56.w pixels - 10 минут.

    final double blockSize = 56.r * 1.5;
    final int horizontalBlocksCount = borderWidth ~/ blockSize;

    final TextStyle style = TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4));

    for (int i = 0; i < horizontalBlocksCount; i++) {
      final int time = currentTime.millisecondsSinceEpoch - i * 600000;

      final text = TextSpan(text: DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(time)), style: style);
      final textPainter = TextPainter(text: text, textDirection: TextDirection.ltr);

      textPainter.layout(minWidth: 0, maxWidth: borderWidth);
      textPainter.paint(
        canvas,
        Offset(borderWidth - (i + 1) * blockSize - textPainter.width / 2, height),
      );
    }
  }

  void _drawBorder(Canvas canvas) {
    final double borderWidth = width - 56.w;
    final double borderHeight = height - 18.h;

    final Paint outerBorderPaint = Paint()
      ..color = whiteColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Paint innerBorderPaint = Paint()
      ..color = whiteColor.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double blockSize = 56.r;
    final int horizontalBlocksCount = borderWidth ~/ (blockSize * 1.5);
    final int verticalBlocksCount = borderHeight ~/ blockSize;

    for (int i = 0; i < horizontalBlocksCount; i++) {
      canvas.drawLine(Offset(borderWidth - (i + 1) * (blockSize * 1.5), 0),
          Offset(borderWidth - (i + 1) * (blockSize * 1.5), borderHeight), innerBorderPaint);
    }

    final double valueLength = (maxValue - minValue) / verticalBlocksCount;
    final TextStyle style = TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.4));

    for (int i = 0; i < verticalBlocksCount + 1; i++) {
      final text = TextSpan(text: (maxValue - valueLength * i).toStringAsFixed(5), style: style);
      final textPainter = TextPainter(text: text, textDirection: TextDirection.ltr);

      textPainter.layout(minWidth: 0, maxWidth: borderWidth);
      textPainter.paint(
        canvas,
        Offset(borderWidth + 4.w, borderHeight - i * blockSize - textPainter.height / 2),
      );

      if (i == verticalBlocksCount) break;

      canvas.drawLine(Offset(0, borderHeight - (i + 1) * blockSize),
          Offset(borderWidth, borderHeight - (i + 1) * blockSize), innerBorderPaint);
    }

    canvas.drawLine(Offset(0, borderHeight), Offset(borderWidth, borderHeight), outerBorderPaint);
    canvas.drawLine(Offset(borderWidth, borderHeight), Offset(borderWidth, 0), outerBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
