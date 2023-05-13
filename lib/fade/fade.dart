import 'package:flutter/material.dart';
import 'dart:async';
import '../main.dart';

class FadeInOutText extends StatefulWidget {
  const FadeInOutText({Key? key}) : super(key: key);

  @override
  State<FadeInOutText> createState() => _FadeInOutTextState();
}

class _FadeInOutTextState extends State<FadeInOutText>
    with SingleTickerProviderStateMixin {
  List<String> texts = ['Text A', 'Text B', 'Text C', 'Text D', 'Text E', 'Text F', 'Text G', 'Text H'];
  int index = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Timer(const Duration(seconds: 17), () {
            _controller.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          } else {
            setState(() {
              index = index + 1;
            });
            Timer(const Duration(seconds: 5), () {
              _controller.forward();
            });
          }
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FadeTransition(
        opacity: _animation,
        child: Text(
          texts[index],
          style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'roboto'
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}