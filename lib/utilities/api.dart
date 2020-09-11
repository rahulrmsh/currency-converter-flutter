import 'dart:convert';

import 'package:http/http.dart' as http;

Map items = {};
// ignore: missing_return
Future<double> getBase(String fromCode, String toCode) async {
  try {
    final response = await http
        .get('https://api.exchangeratesapi.io/latest?base=' + fromCode);
    if (response.statusCode == 200) {
      var list = json.decode(response.body) as Map;
      list.forEach((key, value) {
        if (key == 'rates') {
          items.addAll(value);
          items.forEach((key, value) {
            if (key == toCode) {
              print((value));
              return ((value));
            }
          });
        }
      });
    } else {
      print(0);
      return 0.0;
    }
  } catch (e) {
    print(e);
    return 0.0;
  }
}
