import 'dart:convert';

import 'package:dart_bbs/src/models/vp.dart';
import 'package:http/http.dart' as http;

// input  : signature String
//          publicKey String
//          messages String[]
//
// output : result Bool 35.86.230.210

Future<bool> blsVerify(signature, publicKey, messages) async {
  var url = Uri.parse(
    'http://35.86.230.210:8000/bls_verify', //HTTP request
  );

  // should be obtained from VDR
  // var publicKey = "vovnemt";

  var response = await http.post(url,
      body: json.encode({
        "signature": signature,
        "publicKey": publicKey,
        "messages": messages,
      }),
      headers: {"Content-Type": "application/json"});
  return json.decode(response.body)["is_verified"]["verified"];
}
