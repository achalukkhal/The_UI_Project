
import 'package:flutter/material.dart';

class CustomBorder extends CustomPainter {
  final Color strokeColor;
  final Color backgroundColor;
  final double width;
  final double height;

  CustomBorder(
      { this.width = 190,
        this.height = 190,
        this.strokeColor = Colors.white, @required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = strokeColor;
    final fill = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 60.0
      ..color = backgroundColor;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, width, height), Radius.circular(20)),
        paint);

    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(0, (height / 1.45) / 2 , width, height - (height / 1.45) )), fill);
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH((width / 1.45) / 2, 0, width - (width / 1.45) , height)), fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
