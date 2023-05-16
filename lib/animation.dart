import 'package:flutter/material.dart';
import 'fade/fade.dart';
import 'spark/spark.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Sparkler(),
            Image.asset(
              'assets/image/star.gif',
              width: 400.0,
              height: 500.0,
            ),
            const SizedBox(
              height: 100,
            ),
            const FadeInOutText()
          ],
        ),
      ),
    );
  }
}