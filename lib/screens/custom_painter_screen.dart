import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterScreen extends StatefulWidget {
  const CustomPainterScreen({super.key});

  @override
  State<CustomPainterScreen> createState() => _CustomPainterScreenState();
}

class _CustomPainterScreenState extends State<CustomPainterScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curve;

  late double _redProgressTweenEnd;
  late double _greenProgressTweenEnd;
  late double _blueProgressTweenEnd;

  final ValueNotifier<double> _milliseconds = ValueNotifier<double>(1200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _milliseconds.value.toInt()),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo);

    _redProgressTweenEnd = Random().nextDouble() * 2.0;
    _greenProgressTweenEnd = Random().nextDouble() * 2.0;
    _blueProgressTweenEnd = Random().nextDouble() * 2.0;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 100));
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('CustomPainter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final redProgress = Tween<double>(
                  begin: 0,
                  end: _redProgressTweenEnd,
                ).animate(_curve);

                final greenProgress = Tween<double>(
                  begin: 0,
                  end: _greenProgressTweenEnd,
                ).animate(_curve);

                final blueProgress = Tween<double>(
                  begin: 0,
                  end: _blueProgressTweenEnd,
                ).animate(_curve);

                return CustomPaint(
                  painter: MyPainter(
                    redProgress: redProgress.value,
                    greenProgress: greenProgress.value,
                    blueProgress: blueProgress.value,
                  ),
                  size: Size(400, 400),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _milliseconds,
              builder: (context, value, child) {
                return Slider(
                  min: 500,
                  max: 5000,
                  label: _milliseconds.value.toString().substring(
                    0,
                    _milliseconds.value.toString().lastIndexOf('.'),
                  ),
                  showValueIndicator: ShowValueIndicator.onDrag,
                  value: _milliseconds.value,
                  onChanged: (value) => _milliseconds.value = value,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'refresh',
        onPressed: () {
          // setState(() {});
          _redProgressTweenEnd = Random().nextDouble() * 2.0;
          _greenProgressTweenEnd = Random().nextDouble() * 2.0;
          _blueProgressTweenEnd = Random().nextDouble() * 2.0;

          _controller
            ..duration = Duration(milliseconds: _milliseconds.value.toInt())
            ..forward(from: 0);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class MyPainter({
  required final double redProgress,
  required final double greenProgress,
  required final double blueProgress,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // final Paint rectPaint = Paint()..color = Colors.blue;
    //
    // canvas.drawRect(rect, rectPaint);
    //
    // final Offset c = Offset(size.width / 2, size.height / 2);
    // final double radius = size.width / 2;
    // final Paint circlePaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 20;
    //
    // canvas.drawCircle(c, radius, circlePaint);
    final Offset center = Offset(size.width / 2, size.height / 2);
    const double startAngle = -0.5 * pi;

    final double redRadius = (size.width / 2) * 0.9;

    final Paint redCirclePaint = Paint()
      ..color = Colors.red.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final Paint redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect redArdRect = Rect.fromCircle(center: center, radius: redRadius);

    canvas.drawCircle(center, redRadius, redCirclePaint);
    canvas.drawArc(
      redArdRect,
      startAngle,
      redProgress * pi,
      false,
      redArcPaint,
    );

    final double greenRadius = (size.width / 2) * 0.75;

    final Rect greenRect = Rect.fromCircle(center: center, radius: greenRadius);

    final Paint greenPaint = Paint()
      ..color = Colors.green.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final Paint greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawCircle(center, greenRadius, greenPaint);
    canvas.drawArc(
      greenRect,
      startAngle,
      greenProgress * pi,
      false,
      greenArcPaint,
    );

    final double blueRadius = (size.width / 2) * 0.6;

    final Rect blueRect = Rect.fromCircle(center: center, radius: blueRadius);

    final Paint bluePaint = Paint()
      ..color = Colors.blue.shade400.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final Paint blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, blueRadius, bluePaint);
    canvas.drawArc(
      blueRect,
      startAngle,
      blueProgress * pi,
      false,


      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) {
    return oldDelegate.redProgress != redProgress ||
        oldDelegate.greenProgress != greenProgress ||
        oldDelegate.blueProgress != blueProgress;
  }
}
