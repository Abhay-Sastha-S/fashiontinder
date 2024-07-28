import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'home_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 4), () {}); // Increase delay to match animation duration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedTextKit(
          repeatForever: false,
          animatedTexts: [
            ScaleAnimatedText(
              'Fashion Times',
              textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              duration: Duration(seconds: 2),
            ),
            ScaleAnimatedText(
              'FT',
              textStyle: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),
              duration: Duration(seconds: 2),
            ),
          ],
          onFinished: () {
            // Optional: handle the animation finish event if needed
          },
        ),
      ),
    );
  }
}
