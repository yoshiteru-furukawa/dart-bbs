import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bs58/bs58.dart';

// input  : signature String
//        : publickey String
//        : messages String[]
//        : revealed Number[]
//        : nonce string
//
// output : proof value

Future<String> createProofValue(
    signature, publicKey, messages, revealed, nonce) async {
  var url = Uri.parse(
    'http://localhost:3000/create_vp',
  );
  var response = await http.post(url,
      body: json.encode({
        "signature": base64.decode(signature),
        "publicKey": base58.decode(publicKey),
        "revealed": revealed,
        "messages": messages,
        // base64? or 58? should be cast
        "nonce": base64.decode(nonce)
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(response.body)["proof"];
}
