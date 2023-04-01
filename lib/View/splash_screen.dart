import 'dart:async';

import 'package:covid19_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStats()));
    });
  }

  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 6), vsync: this)
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Image(image: AssetImage("images/virus.png"))),
                ),
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                      child: child, angle: _controller.value * 2.0 * math.pi);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Covid-19\nTracker App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
