import 'package:currency_converter/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height);
    final width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              child: Container(
                color: topContainer,
                width: width,
                height: height * 0.50,
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: Container(
                color: bottomContainer,
                width: width,
                height: height * 0.50,
              ),
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.08),
                child: Text(
                  'Currency',
                  style: GoogleFonts.acme(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.15,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.08),
                child: Text(
                  'Converter',
                  style: GoogleFonts.acme(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.15,
                      color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('images/gold1.png'),
                height: height * 0.70,
                width: width * 0.70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
