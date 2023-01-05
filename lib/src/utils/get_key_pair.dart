import 'dart:convert';

import 'package:http/http.dart' as http;

// input  :
//
// output : keyPair
// 35.86.230.210

Future<Map> getKeyPair() async {
  var url = Uri.parse(
    'http://35.86.230.210:8000/create_key_pair',
  );
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["keyPair"];
}
