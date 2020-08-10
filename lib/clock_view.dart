import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  var dateTime=""; //DateTime.now();
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        dateTime = DateFormat.jm().format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: ClockPainter(),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          dateTime,
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFFF9B4AB);

    var outlineBrush = Paint()
      ..color = Color(0xFFFFFFFF)
      ..strokeWidth = 12
      ..shader
      ..style = PaintingStyle.stroke;

    var centerFillBrush = Paint()..color = Color(0xFF4A4A4A);

    var secondHandBrush = Paint()
      ..color = Color(0xFF4A4A4A)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var minuteHandBrush = Paint()
      ..color = Color(0xFF4A4A4A)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    var hourHandBrush = Paint()
      ..color = Color(0xFF4A4A4A)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - 30, fillBrush);
    canvas.drawCircle(center, radius - 30, outlineBrush);
    canvas.drawCircle(center, 7, centerFillBrush);

    var hourHandX = centerX +
        65 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        65 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minuteHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minuteHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minuteHandBrush);

    var secHandX = centerX + 90 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 90 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHandBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
