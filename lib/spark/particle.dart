import 'dart:math';
import 'package:flutter/material.dart';

class Particle extends StatefulWidget {
  const Particle({super.key,
    this.duration = const Duration(milliseconds: 500)
  });

  final Duration duration;
  @override
  State<StatefulWidget> createState() {
    return _ParticleState();
  }
}

class _ParticleState extends State<Particle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double randomSpawnDelay;
  late double randomSize;
  late double arcImpact;
  late bool isStar;
  late double starPosition;
  bool visible = true;

  @override
  void initState() {
    super.initState();
    randomSpawnDelay = Random().nextDouble();
    randomSize = Random().nextDouble();
    arcImpact = Random().nextDouble() * 2 - 1;
    isStar = Random().nextDouble() > 0.9;
    starPosition = Random().nextDouble() + 0.5;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _startNextAnimation(
        Duration(milliseconds: (Random().nextDouble() * 1000).toInt())
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        visible = false;
        _startNextAnimation();
      }
    });

    _controller.addListener(() {
      setState(() {});
    });
  }

  void _startNextAnimation([Duration? after]) {
    if (after == null) {
      int millis = (randomSpawnDelay * 300).toInt();
      after = Duration(milliseconds: millis);
    }

    Future.delayed(after, () {
      if (!mounted) {
        return;
      }

      setState(() {
        randomSpawnDelay = Random().nextDouble();
        randomSize = Random().nextDouble();
        arcImpact = Random().nextDouble() * 2 - 1;
        isStar = Random().nextDouble() > 0.3;
        starPosition = Random().nextDouble() + 0.5;
        visible = true;
      });

      _controller.forward(from: 0.0);
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: randomSize * 1.5,
        height: 30,
        child: Opacity(
            opacity: visible ? 1.0 : 0.0,
            child: CustomPaint(
                painter: ParticlePainter(
                    currentLifetime: _controller.value,
                    randomSize: randomSize,
                    arcImpact: arcImpact,
                    isStar: isStar,
                    starPosition: starPosition
                )
            )
        )
    );
  }
}

class ParticlePainter extends CustomPainter {
  ParticlePainter({
    required this.currentLifetime,
    required this.randomSize,
    required this.arcImpact,
    required this.isStar,
    required this.starPosition,
  });

  final double currentLifetime;
  final double randomSize;
  final double arcImpact;
  final bool isStar;
  final double starPosition;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double width = size.width;
    double height = size.height * randomSize * currentLifetime * 2.5;

    if (isStar) {
      _drawStar(paint, width, height, size, canvas);
    }

    _drawParticle(paint, width, height, size, canvas);
  }

  void _drawParticle(Paint paint, double width, double height, Size size, Canvas canvas) {
    Rect rect = Rect.fromLTWH(
        0,
        0,
        width,
        height
    );

    Path path = Path();
    LinearGradient gradient = LinearGradient(
        colors: const [Colors.transparent, Color.fromRGBO(255, 255, 160, 1.0), Color.fromRGBO(255, 255, 160, 0.7), Color.fromRGBO(255, 180, 120, 0.7)],
        stops: [0, size.height * currentLifetime / 30, 0.6, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
    paint.shader = gradient.createShader(rect);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = width;
    path.cubicTo(0, 0, width * 4 * arcImpact, height * 0.5, width, height);

    canvas.drawPath(path, paint);
  }

  void _drawStar(Paint paint, double width, double height, Size size, Canvas canvas) {
    Path path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = width * 0.25;
    paint.color = const Color.fromRGBO(255, 255, 160, 1.0);

    double starSize = size.width * 2.5;
    double starBottom = height * starPosition;

    path.moveTo(0, starBottom - starSize);
    path.lineTo(starSize, starBottom);
    path.moveTo(starSize, starBottom - starSize);
    path.lineTo(0, starBottom);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}