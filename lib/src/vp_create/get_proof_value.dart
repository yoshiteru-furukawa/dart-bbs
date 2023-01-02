import 'dart:convert';

import 'package:http/http.dart' as http;

// input  : signature String
//        : publickey String
//        : messages String[]
//        : revealed Number[]
//        : nonce string
//
// output : proof value

Future<String> getProofValue(
    signature, publicKey, messages, revealed, nonce) async {
  var url = Uri.parse(
    'http://localhost:8000/create_vp',
  );
  var response = await http.post(url,
      body: json.encode({
        "signature": signature,
        "publicKey": publicKey,
        "revealed": revealed,
        "messages": messages,
        "nonce": nonce
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["proof"];
}
