import 'package:flutter/material.dart';
import 'animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Joseph',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFE1E1E1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Joseph',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'The eternal truth',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                color: Colors.black
              )
            ),
            const SizedBox(
              height: 250,
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width*0.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnimationPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF9D9D9D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Color(0xFF9D9D9D)),
                  ),
                ),
                child: const Text(
                    'Read',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
