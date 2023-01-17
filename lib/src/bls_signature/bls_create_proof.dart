import 'dart:convert';

import 'package:http/http.dart' as http;

/* Interface
 input  : signature String
        : publickey String
        : messages String[]
        : revealed Number[]
        : nonce string

 output : proof value 
*/

Future<String> blsCreateProof(
    signature, publicKey, messages, revealed, nonce) async {
  var url = Uri.parse(
    'http://35.86.230.210:8000/bls_create_proof', //HTTP request
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
