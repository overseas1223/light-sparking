import 'dart:math';
import 'package:flutter/material.dart';
import 'particle.dart';

class Sparkler extends StatefulWidget {
  const Sparkler({super.key});

  @override
  State<Sparkler> createState() => _SparklerState();
}

class _SparklerState extends State<Sparkler> {
  final double width = 300;
  final double progress = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: width,
          child: SizedBox(
              height: 100,
              child: Stack(
                children: getParticles(),
              )
          ),
        )
    );
  }

  List<Widget> getParticles() {
    List<Widget> particles = [];
    double width = 300;
    particles.add(
        CustomPaint(
            child: Container()
        )
    );

    int maxParticles = 160;
    for (var i = 1; i <= maxParticles; i++) {
      if (progress >= 1) {
        continue;
      }
      particles.add(
          Padding(
              padding: EdgeInsets.only(left: progress * width, top: 20),
              child: Transform.rotate(
                  angle: maxParticles / i * pi,
                  child: const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Particle()
                  )
              )
          )
      );
    }

    return particles;
  }
}