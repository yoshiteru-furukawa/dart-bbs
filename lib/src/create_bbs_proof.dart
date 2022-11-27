import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bs58/bs58.dart';
// input  : signature
//        : publickey
//        : VC
//
// output : proof

Future<String> createBbsProof(signature, publicKey, VC) async {
  var url = Uri.parse(
    'http://localhost:3000',
  );
  var response = await http.post(url,
      body: json.encode({
        "signature": base64.decode(signature),
        "publicKey": base58.decode(publicKey),
        "VC": VC
      }),
      headers: {"Content-Type": "application/json"});
  return json.decode(response.body)["proof"];
}
