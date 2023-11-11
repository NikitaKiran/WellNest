import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fractal/flutter_fractal.dart';
import 'package:wellnest/widgets/viewer.dart';
import 'package:funvas/funvas.dart';


class PatternView extends StatefulWidget {

  static final examples = <SizedBox>[
    SizedBox(child: FunvasContainer(funvas: Art3())),
    SizedBox(child: const ChakraLoadingIndicator(duration: Duration(seconds: 5),)),
    SizedBox(child: FunvasContainer(funvas: Art2()))
  ];

  @override
  State<PatternView> createState() => _PatternViewState();
}

class _PatternViewState extends State<PatternView> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    player.setSource(AssetSource('music2.mp3'));
    player.resume();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pattern Viewer'),
          backgroundColor: const Color(0xFFFFCACC),),
      backgroundColor: Colors.black,
      body: Center(
        child: Viewer(boxes: PatternView.examples,)
      ),
    );
  }
}


class Art2 extends Funvas {
  @override
  void u(double t, [bool recurse = true]) {
    c.drawColor(const Color(0xff000000), BlendMode.srcOver);

    const d = 1500.0;
    s2q(d);

    c.translate(d / 2, d / 2);

    final paint = Paint()
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..color = HSVColor.fromAHSV(
          1,
          (360 * t/(t+10)),
          1,
          1,
        ).toColor();
    final p = 1 - (t / 11 + 1 / 2) % 1;
    _draw(d, t, Curves.easeIn.transform((1 - p) % 1), paint);
    _draw(d, t, Curves.easeIn.transform(p), paint);
  }

  void _draw(double d, double t, double p, Paint paint) {
    void f(double X, double Y, double w) {
      if (X * X + Y * Y <= d * 3e3 * p) {
        if (w < 10) return;
        f(X, Y, w /= 2);
        f(X + w, Y, w);
        f(X, Y + w, w);
        f(X + w, Y + w, w);
      } else {
        c.drawRect(Rect.fromLTWH(X, Y, w, w), paint);
      }
    }

    for (var i = 0; i < 4; i++) {
      c.save();
      c.rotate(pi / 2 * i);
      c.scale(.5);
      f(0, 0, d);
      c.restore();
    }
  }
}



class Art3 extends Funvas  {
  @override
  void u(double t) {
    //c.drawPaint(Paint()..color = const Color(0xffdddddd));
    c.saveLayer(Offset.zero & Size(x.width, x.height), Paint());
    //c.drawPaint(Paint()..color = const Color(0xffffffff));

    final d = s2q(750).width;
    const r = 7.0, n = 42;

    Offset position(int i) {
      return (Offset.zero & Size.square(d)).center +
          Offset.fromDirection(
            t * pi * 2 * (n - i) / n,
            d / 2 / (n + 1) * (i + 1),
          );
    }

    Paint paint(int i, [bool difference = true]) {
      return Paint()
        ..color = HSVColor.fromAHSV(
          1,
          360 * i / n,
          1,
          1,
        ).toColor()
        ..strokeWidth = 2
        ..blendMode = difference ? BlendMode.xor : BlendMode.srcOver;
    }

    for (var i = 0; i < n; i++) {
      final p2 = position(i);
      if (i != 0) {
        final p1 = position(i - 1);
        c.drawPath(
          Path()
            ..moveTo(d / 2, d / 2)
            ..lineTo(p1.dx, p1.dy)
            ..lineTo(p2.dx, p2.dy)
            ..close(),
          paint(i),
        );
      }
      c.drawCircle(p2, r, paint(i));
    }

    for (var i = 0; i < n; i++) {
      c.drawCircle(position(i), r, paint(i, false));
    }
    c.restore();
  }
}