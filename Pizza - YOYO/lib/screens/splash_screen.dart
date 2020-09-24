import 'package:bot/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.orange, Colors.deepOrange],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomeScreen(),
      title: new Text('Yo Yo Pizza',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
          foreground: Paint()..shader = linearGradient,
        ),
      ),
      image: Image.asset("assets/images/logo.jpg"),
      photoSize: 100.0,
    );
  }
}
