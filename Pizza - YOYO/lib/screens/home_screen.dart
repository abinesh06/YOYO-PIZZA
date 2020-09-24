import 'package:bot/screens/new_order.dart';
import 'package:bot/screens/track_order.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  static const routeName = '/home';

  TextStyle textStyle = const TextStyle(
    fontSize: 24,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Yo Yo Pizza"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(NewOrder.routeName);
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 140,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/new_order.jpg"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "New Order",
              style: textStyle,
            ),
            SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(TrackOrder.routeName);
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: 140,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/images/track_order.png"),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "Track Order",
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
