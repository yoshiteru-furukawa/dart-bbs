import 'dart:convert';

import 'package:http/http.dart' as http;

/* Interface
 input  : publickey String
        : messages String[]
        : signature(proofValue) String

 output : verifiedResult Bool 
*/

Future<bool> blsVerify(
    String publicKey, List<String> messages, String signature) async {
  var blsVerifyUri = Uri.parse("http://35.86.230.210:8000/bls_verify");
  var response = await http.post(
    blsVerifyUri,
    body: json.encode({
      "signature": signature,
      "publicKey": publicKey,
      "messages": messages,
    }),
    headers: {"Content-Type": "application/json"},
  );
  return json.decode(response.body)["is_verified"]["verified"];
}
