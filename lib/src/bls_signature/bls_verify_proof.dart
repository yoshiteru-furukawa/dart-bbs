import 'dart:convert';

import 'package:http/http.dart' as http;

// input  : VP String
//
// output : result Bool

Future<bool> blsVerifyProof(proof, publicKey, messages, nonce) async {
  var url = Uri.parse(
    'http://35.86.230.210:9000/bls_verify_proof', //HTTP request
  );

  var response = await http.post(url,
      body: json.encode({
        "proof": proof,
        "publicKey": publicKey,
        "messages": messages,
        "nonce": nonce
      }),
      headers: {"Content-Type": "application/json"});

  return json.decode(json.decode(response.body)["isProofVerified"])["verified"];
}
