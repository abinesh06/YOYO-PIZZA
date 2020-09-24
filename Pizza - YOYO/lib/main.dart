import 'package:bot/screens/home_screen.dart';
import 'package:bot/screens/splash_screen.dart';
import 'package:bot/screens/new_order.dart';
import 'package:bot/screens/track_order.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Hexcolor("#ff6600"),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        NewOrder.routeName: (_) => NewOrder(),
        TrackOrder.routeName: (_) => TrackOrder(),
      },
    );
  }
}
