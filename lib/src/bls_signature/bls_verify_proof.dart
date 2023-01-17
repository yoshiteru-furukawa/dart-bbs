import 'dart:convert';

import 'package:dart_bbs/src/bls_signature/uri_settings.dart';
import 'package:http/http.dart' as http;

// input  : VP String
//
// output : result Bool

Future<bool> blsVerifyProof(proof, publicKey, messages, nonce) async {
  var response = await http.post(blsVerifyUri,
      body: json.encode({
        "proof": proof,
        "publicKey": publicKey,
        "messages": messages,
        "nonce": nonce
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(json.decode(response.body)["isProofVerified"])["verified"];
}
