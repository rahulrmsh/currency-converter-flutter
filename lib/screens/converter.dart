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
  List<String> items = [];
  List<String> name = [];
  List<String> country = [];
  int indexCount = 0;
  @override
  void initState() {
    getCode();
    super.initState();
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
    print(items);
    print(name);
    print(country);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropDown(
                            showUnderline: false,
                            items: country,
                            dropDownType: DropDownType.Button,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                country[indexCount],
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                indexCount = country.indexOf(value);
                              });
                            },
                          ),
                          DropDown(
                            showUnderline: false,
                            items: items,
                            onChanged: (value) {
                              setState(
                                () {
                                  indexCount = items.indexOf(value);
                                },
                              );
                            },
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              items[indexCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              '56.67',
                              style: GoogleFonts.acme(
                                color: Colors.black,
                                fontSize: height * 0.10,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: height * 0.001,
                      color: Colors.grey,
                    ),
                    Container(
                      child: Column(
                        children: [
                          DropDown(
                            showUnderline: false,
                            items: country,
                            dropDownType: DropDownType.Button,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                country[indexCount],
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                indexCount = country.indexOf(value);
                              });
                            },
                          ),
                          DropDown(
                            showUnderline: false,
                            items: items,
                            onChanged: (value) {
                              setState(
                                () {
                                  indexCount = items.indexOf(value);
                                },
                              );
                            },
                            dropDownType: DropDownType.Button,
                            hint: Text(
                              items[indexCount],
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              '56.67',
                              style: GoogleFonts.acme(
                                color: Colors.black,
                                fontSize: height * 0.10,
                              ),
                            ),
                          )
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
                child: Container(
                  color: topContainer,
                  width: width,
                  height: height * 0.10,
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
          ],
        ),
      ),
    );
  }
}
