import 'dart:convert';
import 'package:currency_converter/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:currency_converter/utilities/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  Map crossItem = {};
  TextEditingController _controller;
  TextEditingController _controllerTop;
  TextEditingController _controllerBtm;
  List<String> items = [];
  List<String> name = [];
  List<String> country = [];
  int indexTopCount = 0;
  int indexBottomCount = 1;
  double percentCount = 1;
  double topCount = 1.0;
  double rate = 0;
  double bottomCount = 1.0;
  @override
  void initState() {
    getCode();
    getRates(items[indexTopCount], items[indexBottomCount]);

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

  void getRates(String fromCode, String toCode) async {
    try {
      final response = await http
          .get('https://api.exchangeratesapi.io/latest?base=' + fromCode);
      if (response.statusCode == 200) {
        var list = json.decode(response.body) as Map;
        list.forEach((key, value) {
          if (key == 'rates') {
            crossItem.addAll(value);
            crossItem.forEach((key, value) {
              if (key == toCode) {
                setState(() {
                  rate = value;
                  setRates();
                });
              }
            });
          }
        });
      } else {
        print(0);
      }
    } catch (e) {
      print('Something happened');
      print(e);
    }
  }

  void setRates() {
    setState(() {
      bottomCount = topCount * rate;
      bottomCount = bottomCount - (bottomCount * (percentCount / 100));
      _controller =
          TextEditingController(text: percentCount.toStringAsFixed(2));
      _controllerTop = TextEditingController(text: topCount.toStringAsFixed(2));
      _controllerBtm =
          TextEditingController(text: bottomCount.toStringAsFixed(2));
    });
  }

  void swapValues() {
    setState(() {
      var indx = indexTopCount;
      var cnt = topCount;
      topCount = bottomCount;
      indexTopCount = indexBottomCount;
      bottomCount = cnt;
      indexBottomCount = indx;
      _controller =
          TextEditingController(text: percentCount.toStringAsFixed(2));
      _controllerTop = TextEditingController(text: topCount.toStringAsFixed(2));
      _controllerBtm =
          TextEditingController(text: bottomCount.toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height);
    final width = (MediaQuery.of(context).size.width);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
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
                                  getRates(items[indexTopCount],
                                      items[indexBottomCount]);
                                });
                              },
                            ),
                            TextFormField(
                              maxLength: 9,
                              onChanged: (value) {
                                _controllerTop =
                                    TextEditingController(text: value);
                                setState(() {
                                  topCount = double.tryParse(value);
                                  getRates(items[indexTopCount],
                                      items[indexBottomCount]);
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
                              maxLength: 9,
                              onChanged: (value) {
                                _controllerBtm =
                                    TextEditingController(text: value);
                                setState(() {
                                  bottomCount = double.tryParse(value);
                                  getRates(items[indexTopCount],
                                      items[indexBottomCount]);
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
                                  getRates(items[indexTopCount],
                                      items[indexBottomCount]);
                                });
                              },
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
                                      getRates(items[indexTopCount],
                                          items[indexBottomCount]);
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
                    padding: EdgeInsets.symmetric(
                        vertical: width * 0.035, horizontal: width * 0.2),
                    color: bottomContainer,
                    width: width,
                    height: height * 0.10,
                    child: OutlineButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      highlightedBorderColor: Colors.white,
                      borderSide: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2),
                      child: Text(
                        'Swap',
                        style: GoogleFonts.raleway(
                            fontSize: height * 0.025,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          swapValues();
                        });
                      },
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
