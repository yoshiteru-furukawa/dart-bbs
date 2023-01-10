import 'dart:convert';

import 'package:http/http.dart' as http;

// Interface
// input  : publickey String
//        : secretkey String
//        : message String
//
// output : proof value

Future<String> getProofValue(String pk, String sk, String message) async {
  var url = Uri.parse(
    "http://35.86.230.210:3000/create_vc", //HTTP request
  );
  var response = await http.post(
    url,
    body: json.encode({
        "pk": pk,
        "sk": sk,
        "messages": [ message ],
    }),
    headers: {"Content-Type": "application/json"},
  );

  return json.decode(response.body)["proof"];
}
