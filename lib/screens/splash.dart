import 'package:currency_converter/utilities/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              child: Container(
                color: topContainer,
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.50,
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: Container(
                color: bottomContainer,
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height) * 0.50,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.center,
              child: Image(image: null),
            )
          ],
        ),
      ),
    );
  }
}
