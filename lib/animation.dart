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

    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Sparkler(),
            SizedBox(
              height: 250,
            ),
            FadeInOutText()
          ],
        ),
      ),
    );
  }
}