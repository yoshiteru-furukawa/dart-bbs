import 'dart:convert';

import 'package:dart_bbs/src/models/jws.dart';
import 'package:http/http.dart' as http;

// input  : JWS Compact Serialization String
//          publicKey String
//
// output : result Bool

Future<bool> jwsVerify(String jwsCompactSerialization, String publicKey) async {
  var url = Uri.parse(
    "http://35.86.230.210:8000/bls_verify", //HTTP request
  );
  var jws = JsonWebSignature.fromCompactSerialization(jwsCompactSerialization);

  var response = await http.post(
    url,
    body: json.encode({
        "signature": jws.signature,
        "publicKey": publicKey,
        "messages": [ jws.payloadDecoded ],
    }),
    headers: {"Content-Type": "application/json"},
  );
  return json.decode(response.body)["is_verified"]["verified"];
}
