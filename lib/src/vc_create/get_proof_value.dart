import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bs58/bs58.dart';

// Interface
// input  : publickey String
//        : secretkey String
//        : messages String[]
//
// output : proof value

Future<String> getProofValue(pk, sk, messages) async {
  var url = Uri.parse(
    'http://35.86.230.210:3000/create_vc', //HTTP request
  );
  var response = await http.post(url,
      body: json.encode({
        "pk": pk,
        "sk": sk,
        "messages": messages,
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["proof"];
}
