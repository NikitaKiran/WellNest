import 'dart:math';
import 'package:flutter/material.dart';



class PatternView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doodle'),
          backgroundColor: const Color(0xFFFFCACC),),
      backgroundColor: Colors.black,
      body: Center(
        child: GenerativeArt(),
      ),
    );
  }
}

class GenerativeArt extends StatefulWidget {
  @override
  _GenerativeArtState createState() => _GenerativeArtState();
}

class _GenerativeArtState extends State<GenerativeArt> with TickerProviderStateMixin {
  final random = Random();
  final int maxSquares = 100;
  final int maxCircles = 100;
  final double minCircleRadius = 2.0;
  final double maxCircleRadius = 20.0;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 10))..repeat();
  }

  Color randomDarkColor() {
    return Color.fromARGB(
      255,
      random.nextInt(100),
      random.nextInt(100),
      random.nextInt(100),
    );
  }

  Color randomLightColor() {
    return Color.fromARGB(
      255,
      100 + random.nextInt(155),
      100 + random.nextInt(155),
      100 + random.nextInt(155),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GenerativeArtPainter(
        random: random,
        maxSquares: maxSquares,
        maxCircles: maxCircles,
        minCircleRadius: minCircleRadius,
        maxCircleRadius: maxCircleRadius,
        controller: controller,
        randomDarkColor: randomDarkColor,
        randomLightColor: randomLightColor,
      ),
      size: MediaQuery.of(context).size,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GenerativeArtPainter extends CustomPainter {
  final Random random;
  final int maxSquares;
  final int maxCircles;
  final double minCircleRadius;
  final double maxCircleRadius;
  final AnimationController controller;
  final Color Function() randomDarkColor;
  final Color Function() randomLightColor;

  GenerativeArtPainter({
    required this.random,
    required this.maxSquares,
    required this.maxCircles,
    required this.minCircleRadius,
    required this.maxCircleRadius,
    required this.controller,
    required this.randomDarkColor,
    required this.randomLightColor,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.black, BlendMode.clear);

    for (int i = 0; i < maxSquares; i++) {
      final double x = random.nextDouble() * size.width;
      final double y = random.nextDouble() * size.height;
      final double side = random.nextDouble() * 50 + 10;
      final double angle = random.nextDouble() * pi;
      final double opacity = random.nextDouble();
      final Paint paint = Paint()
        ..color = randomDarkColor().withOpacity(opacity)
        ..style = PaintingStyle.fill;
      final Rect squareRect = Rect.fromCenter(
        center: Offset(x, y),
        width: side,
        height: side,
      );
      canvas.save();
      canvas.rotate(angle);
      canvas.drawRect(squareRect, paint);
      canvas.restore();
    }

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}