import 'dart:ui';

import 'package:bus_android/server/busInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double test = 0;

class BusRoad extends CustomPainter {
  final prevStationName;
  final nowStationName;

  BusRoad({this.prevStationName, this.nowStationName});

  @override
  void paint(Canvas canvas, Size size) {
    TextSpan textSpan1 = TextSpan(
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        text: prevStationName);
    TextSpan textSpan2 = TextSpan(
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        text: nowStationName);
    TextPainter textPainter1 = TextPainter(
      text: textSpan1,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    TextPainter textPainter2 =
        TextPainter(text: textSpan2, textDirection: TextDirection.ltr);

    textPainter1.layout();
    textPainter2.layout();

    Offset offset1 = Offset(100, size.height / 2 + 35);
    Offset offset2 = Offset(size.width - 100, size.height / 2 + 35);
    textPainter1.paint(canvas, offset1);
    textPainter2.paint(canvas, offset2);

    drawLine(canvas, size);
    drawCircle(canvas, size);
    drawCurrentCircle(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  drawLine(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    Offset p1 = Offset(0, size.height / 2);
    Offset p2 = Offset(size.width, size.height / 2);

    canvas.drawLine(p1, p2, paint);
  }

  drawCircle(Canvas canvas, Size size) {
    Paint circle1 = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25.0;

    Paint circle2 = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15.0;

    List<Offset> offsetPoints = [];
    offsetPoints.add(Offset(100, size.height / 2));
    offsetPoints.add(Offset(size.width - 100, size.height / 2));

    canvas.drawPoints(PointMode.points, offsetPoints, circle1);
    canvas.drawPoints(PointMode.points, offsetPoints, circle2);
  }

  drawCurrentCircle(Canvas canvas, Size size) {
    Paint circle1 = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30.0;

    Paint circle2 = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0;

    List<Offset> offsetPoints = [];
    offsetPoints.add(Offset(100 + 247 * test / 100, size.height / 2));

    canvas.drawPoints(PointMode.points, offsetPoints, circle1);
    canvas.drawPoints(PointMode.points, offsetPoints, circle2);
  }
}
