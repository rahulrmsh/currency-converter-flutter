import 'dart:ffi';

import 'package:currency_converter/utilities/constants.dart';
import 'package:currency_converter/utilities/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  TextEditingController _controller;
  TextEditingController _controllerTop;
  TextEditingController _controllerBtm;
  List<String> items = [];
  List<String> name = [];
  List<String> country = [];
  int indexTopCount = 0;
  int indexBottomCount = 1;
  double percentCount = 1;
  Double topCount;
  Double bottomCount;
  @override
  void initState() {
    getCode();
    super.initState();
    _controller = new TextEditingController(text: percentCount.toString());
    _controllerTop = new TextEditingController(text: topCount.toString());
    _controllerBtm = new TextEditingController(text: bottomCount.toString());
  }

  void getCode() {
    countries.forEach((element) {
      element.forEach((key, value) {
        if (key == 'Code') {
          items.add(value);
        }
        if (key == 'Name') {
          name.add(value);
        }
        if (key == 'Country') {
          country.add(value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height);
    final width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropDown(
                            showUnderline: false,
                            items: country,
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              country[indexTopCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                indexTopCount = country.indexOf(value);
                              });
                            },
                          ),
                          DropDown(
                            showUnderline: false,
                            items: items,
                            onChanged: (value) {
                              setState(
                                () {
                                  indexTopCount = items.indexOf(value);
                                },
                              );
                            },
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              items[indexTopCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextFormField(
                            maxLength: 6,
                            onChanged: (value) {
                              _controller = TextEditingController(text: value);
                              setState(() {
                                percentCount = double.tryParse(value);
                              });
                            },
                            controller: _controllerTop,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: height * 0.10,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: height * 0.05),
                      child: Column(
                        children: [
                          TextFormField(
                            maxLength: 6,
                            onChanged: (value) {
                              _controller = TextEditingController(text: value);
                              setState(() {
                                percentCount = double.tryParse(value);
                              });
                            },
                            controller: _controllerBtm,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: height * 0.10,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                          DropDown(
                            showUnderline: false,
                            items: country,
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              country[indexBottomCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                indexBottomCount = country.indexOf(value);
                              });
                            },
                          ),
                          DropDown(
                            showUnderline: false,
                            items: items,
                            onChanged: (value) {
                              setState(
                                () {
                                  indexBottomCount = items.indexOf(value);
                                },
                              );
                            },
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              items[indexBottomCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              child: Hero(
                tag: 'topContainer',
                child: Material(
                  child: Container(
                    color: topContainer,
                    width: width,
                    height: height * 0.10,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.029, left: width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Percent Conversion Charge ',
                              style: GoogleFonts.raleway(
                                  fontSize: height * 0.025,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Container(
                              width: width * 0.2,
                              height: width * 0.1,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  shape: BoxShape.rectangle,
                                  color: topContainer,
                                  border: Border.all(
                                      color: Colors.white, width: 1.4)),
                              child: TextFormField(
                                maxLength: 6,
                                onChanged: (value) {
                                  _controller =
                                      TextEditingController(text: value);
                                  setState(() {
                                    percentCount = double.tryParse(value);
                                  });
                                },
                                controller: _controller,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              alignment: Alignment.topCenter,
            ),
            Align(
              child: Hero(
                tag: 'bottomContainer',
                child: Container(
                  color: bottomContainer,
                  width: width,
                  height: height * 0.10,
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
            Align(
              alignment: Alignment.center,
              child: Divider(
                height: height * 0.001,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 350),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  floatingActionButton: FloatingActionButton(
                    heroTag: "btn1",
                    elevation: 8,
                    onPressed: () {},
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return RadialGradient(
                          center: Alignment.center,
                          radius: 0.5,
                          colors: <Color>[Color(0xFF0466c8), Color(0xFF081c15)],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: Icon(
                        Icons.swap_vert_circle_sharp,
                        size: 56.0,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerTop,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
